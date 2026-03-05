import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'
import {
  ACTIVE_RENTALS_COUNT_KEY,
  LISTINGS_ACTIVE_INDEX,
  RECENT_RENTALS_LIST,
  TOTAL_RENTALS_COUNT_KEY,
  PlayerRecord,
  activeRentalLockKey,
  clamp,
  listingKey,
  ownerRentalsKey,
  parseMarketListing,
  rentalKey,
  renterRentalsKey,
  toInt,
} from '../shared'

export const dynamic = 'force-dynamic'

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    const ownerUsername = String(body?.ownerUsername || '').trim()
    const renterUsername = String(body?.renterUsername || '').trim()
    const token = String(body?.token || '').trim()

    if (!ownerUsername || !renterUsername) {
      return NextResponse.json({ error: 'Missing ownerUsername or renterUsername' }, { status: 400 })
    }
    if (ownerUsername.toLowerCase() === renterUsername.toLowerCase()) {
      return NextResponse.json({ error: 'Cannot rent your own pet' }, { status: 400 })
    }

    const [ownerPlayer, renterPlayer] = (await Promise.all([
      kv.hgetall(`player:${ownerUsername}`),
      kv.hgetall(`player:${renterUsername}`),
    ])) as [PlayerRecord | null, PlayerRecord | null]

    if (!ownerPlayer) {
      return NextResponse.json({ error: 'Owner player not found' }, { status: 404 })
    }
    if (!renterPlayer) {
      return NextResponse.json({ error: 'Renter player not found' }, { status: 404 })
    }

    const renterToken = String(renterPlayer.ownerToken || '')
    if (renterToken && token !== renterToken) {
      return NextResponse.json({ error: 'Invalid renter token' }, { status: 403 })
    }

    const lock = await kv.get<string>(activeRentalLockKey(ownerUsername))
    if (lock) {
      return NextResponse.json({ error: 'Pet is currently rented' }, { status: 409 })
    }

    const listingRow = (await kv.hgetall(listingKey(ownerUsername))) as Record<string, unknown> | null
    const listing = parseMarketListing(ownerUsername, listingRow, ownerPlayer, false)
    if (!listing) {
      return NextResponse.json({ error: 'Listing not found' }, { status: 404 })
    }
    if (!listing.active) {
      return NextResponse.json({ error: 'Listing is inactive' }, { status: 409 })
    }

    let days = clamp(toInt(body?.days, listing.minDays), listing.minDays, listing.maxDays)
    if (days < listing.minDays) {
      days = listing.minDays
    }

    const nowMs = Date.now()
    const createdAt = new Date(nowMs).toISOString()
    const endAtMs = nowMs + days * 24 * 60 * 60 * 1000
    const endAt = new Date(endAtMs).toISOString()
    const id = `rental_${nowMs}_${Math.random().toString(36).slice(2, 8)}`
    const totalPrice = days * listing.pricePerDay
    const ttlSec = Math.min((days + 45) * 24 * 60 * 60, 180 * 24 * 60 * 60)

    await Promise.all([
      kv.hset(rentalKey(id), {
        id,
        ownerUsername,
        renterUsername,
        title: listing.title,
        pricePerDay: listing.pricePerDay,
        days,
        totalPrice,
        status: 'active',
        createdAt,
        startAt: createdAt,
        endAt,
      }),
      kv.expire(rentalKey(id), ttlSec),
      kv.lpush(ownerRentalsKey(ownerUsername), id),
      kv.ltrim(ownerRentalsKey(ownerUsername), 0, 199),
      kv.lpush(renterRentalsKey(renterUsername), id),
      kv.ltrim(renterRentalsKey(renterUsername), 0, 199),
      kv.lpush(RECENT_RENTALS_LIST, id),
      kv.ltrim(RECENT_RENTALS_LIST, 0, 199),
      kv.set(activeRentalLockKey(ownerUsername), id, { ex: Math.max(days * 24 * 60 * 60, 3600) }),
      kv.hset(listingKey(ownerUsername), {
        active: 0,
        renterCount: listing.renterCount + 1,
        totalDays: listing.totalDays + days,
        updatedAt: createdAt,
      }),
      kv.zrem(LISTINGS_ACTIVE_INDEX, ownerUsername),
      kv.incr(ACTIVE_RENTALS_COUNT_KEY),
      kv.incr(TOTAL_RENTALS_COUNT_KEY),
    ])

    return NextResponse.json({
      ok: true,
      rental: {
        id,
        ownerUsername,
        renterUsername,
        title: listing.title,
        pricePerDay: listing.pricePerDay,
        days,
        totalPrice,
        status: 'active',
        createdAt,
        startAt: createdAt,
        endAt,
      },
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
