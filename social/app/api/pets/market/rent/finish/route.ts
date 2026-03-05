import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'
import {
  ACTIVE_RENTALS_COUNT_KEY,
  LISTINGS_ACTIVE_INDEX,
  PlayerRecord,
  activeRentalLockKey,
  listingKey,
  parseMarketRental,
  rentalKey,
} from '../../shared'

export const dynamic = 'force-dynamic'

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    const ownerUsername = String(body?.ownerUsername || '').trim()
    const token = String(body?.token || '').trim()
    const rentalId = String(body?.rentalId || '').trim()

    if (!ownerUsername || !rentalId) {
      return NextResponse.json({ error: 'Missing ownerUsername or rentalId' }, { status: 400 })
    }

    const ownerPlayer = (await kv.hgetall(`player:${ownerUsername}`)) as PlayerRecord | null
    if (!ownerPlayer) {
      return NextResponse.json({ error: 'Owner player not found' }, { status: 404 })
    }

    const ownerToken = String(ownerPlayer.ownerToken || '')
    if (ownerToken && token !== ownerToken) {
      return NextResponse.json({ error: 'Invalid owner token' }, { status: 403 })
    }

    const rentalRow = (await kv.hgetall(rentalKey(rentalId))) as Record<string, unknown> | null
    const rental = parseMarketRental(rentalRow)
    if (!rental) {
      return NextResponse.json({ error: 'Rental not found' }, { status: 404 })
    }
    if (rental.ownerUsername.toLowerCase() !== ownerUsername.toLowerCase()) {
      return NextResponse.json({ error: 'Only owner can finish this rental' }, { status: 403 })
    }
    if (rental.status !== 'active') {
      return NextResponse.json({ ok: true, rental, note: `Rental already ${rental.status}` })
    }

    const nowIso = new Date().toISOString()
    const lockKey = activeRentalLockKey(ownerUsername)
    const lockValue = await kv.get<string>(lockKey)

    await Promise.all([
      kv.hset(rentalKey(rentalId), {
        status: 'ended',
        endedAt: nowIso,
        updatedAt: nowIso,
      }),
      kv.expire(rentalKey(rentalId), 120 * 24 * 60 * 60),
      lockValue === rentalId ? kv.del(lockKey) : Promise.resolve(0),
      kv.hset(listingKey(ownerUsername), {
        active: 1,
        updatedAt: nowIso,
      }),
      kv.zadd(LISTINGS_ACTIVE_INDEX, { score: Date.now(), member: ownerUsername }),
      kv.decr(ACTIVE_RENTALS_COUNT_KEY),
    ])

    const activeCount = Number(await kv.get<number>(ACTIVE_RENTALS_COUNT_KEY) || 0)
    if (activeCount < 0) {
      await kv.set(ACTIVE_RENTALS_COUNT_KEY, 0)
    }

    const updatedRental = parseMarketRental(
      (await kv.hgetall(rentalKey(rentalId))) as Record<string, unknown> | null,
    )

    return NextResponse.json({ ok: true, rental: updatedRental })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
