import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'
import {
  PlayerRecord,
  ownerRentalsKey,
  parseMarketRental,
  rentalKey,
  renterRentalsKey,
} from '../shared'

export const dynamic = 'force-dynamic'

type RentalsRole = 'owner' | 'renter' | 'both'

function parseRole(value: string | null): RentalsRole {
  const role = (value || '').trim().toLowerCase()
  if (role === 'owner' || role === 'renter' || role === 'both') return role
  return 'both'
}

export async function GET(req: NextRequest) {
  try {
    const username = req.nextUrl.searchParams.get('username')?.trim() || ''
    const token = req.nextUrl.searchParams.get('token')?.trim() || ''
    const role = parseRole(req.nextUrl.searchParams.get('role'))
    const limitRaw = Number(req.nextUrl.searchParams.get('limit') || '30')
    const limit = Number.isFinite(limitRaw) ? Math.max(1, Math.min(200, limitRaw)) : 30

    if (!username) {
      return NextResponse.json({ error: 'Missing username' }, { status: 400 })
    }

    const player = (await kv.hgetall(`player:${username}`)) as PlayerRecord | null
    if (!player) {
      return NextResponse.json({ error: 'Player not found on leaderboard' }, { status: 404 })
    }
    const ownerToken = String(player.ownerToken || '')
    if (ownerToken && token !== ownerToken) {
      return NextResponse.json({ error: 'Invalid owner token' }, { status: 403 })
    }

    const listFetchLimit = Math.min(limit * 3, 300)
    const [ownerIds, renterIds] = await Promise.all([
      role === 'renter'
        ? Promise.resolve([] as string[])
        : kv.lrange<string[]>(ownerRentalsKey(username), 0, listFetchLimit - 1),
      role === 'owner'
        ? Promise.resolve([] as string[])
        : kv.lrange<string[]>(renterRentalsKey(username), 0, listFetchLimit - 1),
    ])

    const uniqueIds: string[] = []
    const seen = new Set<string>()
    for (const id of [...ownerIds, ...renterIds]) {
      const clean = String(id || '').trim()
      if (!clean || seen.has(clean)) continue
      seen.add(clean)
      uniqueIds.push(clean)
    }

    const rentals = (
      await Promise.all(
        uniqueIds.map(async (id) => {
          const row = (await kv.hgetall(rentalKey(id))) as Record<string, unknown> | null
          return parseMarketRental(row)
        }),
      )
    )
      .filter((row): row is NonNullable<typeof row> => Boolean(row))
      .filter((row) => {
        if (role === 'owner') return row.ownerUsername.toLowerCase() === username.toLowerCase()
        if (role === 'renter') return row.renterUsername.toLowerCase() === username.toLowerCase()
        return (
          row.ownerUsername.toLowerCase() === username.toLowerCase() ||
          row.renterUsername.toLowerCase() === username.toLowerCase()
        )
      })
      .sort((a, b) => Date.parse(b.createdAt) - Date.parse(a.createdAt))
      .slice(0, limit)

    const activeCount = rentals.filter((r) => r.status === 'active').length
    const ownerCount = rentals.filter((r) => r.ownerUsername.toLowerCase() === username.toLowerCase()).length
    const renterCount = rentals.filter((r) => r.renterUsername.toLowerCase() === username.toLowerCase()).length

    return NextResponse.json({
      username,
      role,
      rentals,
      counts: {
        active: activeCount,
        owner: ownerCount,
        renter: renterCount,
      },
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
