import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'
import {
  LISTINGS_ACTIVE_INDEX,
  PlayerRecord,
  activeRentalLockKey,
  clamp,
  listingKey,
  parseMarketListing,
  toBool,
  toInt,
} from '../shared'

export const dynamic = 'force-dynamic'

export async function GET(req: NextRequest) {
  try {
    const owner = req.nextUrl.searchParams.get('owner')?.trim() || ''
    const limitRaw = Number(req.nextUrl.searchParams.get('limit') || '40')
    const limit = Number.isFinite(limitRaw) ? Math.max(1, Math.min(100, limitRaw)) : 40

    if (owner) {
      const [row, player, lock] = await Promise.all([
        kv.hgetall(listingKey(owner)),
        kv.hgetall(`player:${owner}`),
        kv.get<string>(activeRentalLockKey(owner)),
      ])
      const listing = parseMarketListing(
        owner,
        (row as Record<string, unknown> | null) ?? null,
        (player as Record<string, unknown> | null) ?? null,
        Boolean(lock),
      )
      return NextResponse.json({ listings: listing ? [listing] : [] })
    }

    const owners = await kv.zrange<string[]>(LISTINGS_ACTIVE_INDEX, 0, limit - 1, { rev: true })
    if (!owners.length) {
      return NextResponse.json({ listings: [] })
    }

    const listings = (
      await Promise.all(
        owners.map(async (ownerUsername) => {
          const [row, player, lock] = await Promise.all([
            kv.hgetall(listingKey(ownerUsername)),
            kv.hgetall(`player:${ownerUsername}`),
            kv.get<string>(activeRentalLockKey(ownerUsername)),
          ])
          return parseMarketListing(
            ownerUsername,
            (row as Record<string, unknown> | null) ?? null,
            (player as Record<string, unknown> | null) ?? null,
            Boolean(lock),
          )
        }),
      )
    ).filter((listing): listing is NonNullable<typeof listing> => Boolean(listing))

    return NextResponse.json({ listings })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    const username = String(body?.username || '').trim()
    const token = String(body?.token || '').trim()
    const requestedActive =
      body?.active === undefined ? undefined : toBool(body.active, true)

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

    const existingRow = (await kv.hgetall(listingKey(username))) as Record<string, unknown> | null
    const existing = parseMarketListing(username, existingRow, player, false)

    const title = String(body?.title ?? existing?.title ?? `${username}'s Pet`)
      .trim()
      .slice(0, 80)
    const description = String(
      body?.description ??
        existing?.description ??
        `Level ${toInt(player.level, 1)} ${String(player.skin || 'Robot')} companion`,
    )
      .trim()
      .slice(0, 500)
    const pricePerDay = clamp(
      toInt(body?.pricePerDay ?? existing?.pricePerDay, 10),
      1,
      1_000_000,
    )
    const maxDays = clamp(toInt(body?.maxDays ?? existing?.maxDays, 7), 1, 30)
    const minDays = clamp(toInt(body?.minDays ?? existing?.minDays, 1), 1, maxDays)

    const lock = await kv.get<string>(activeRentalLockKey(username))
    const rented = Boolean(lock)
    const active = (requestedActive ?? existing?.active ?? true) && !rented
    const nowIso = new Date().toISOString()

    await Promise.all([
      kv.hset(listingKey(username), {
        ownerUsername: username,
        title,
        description,
        pricePerDay,
        minDays,
        maxDays,
        active: active ? 1 : 0,
        renterCount: toInt(existingRow?.renterCount, 0),
        totalDays: toInt(existingRow?.totalDays, 0),
        level: toInt(player.level, 1),
        skin: String(player.skin || 'Robot'),
        evolution: String(player.evolution || 'Baby'),
        createdAt: existing?.createdAt || nowIso,
        updatedAt: nowIso,
      }),
      kv.expire(listingKey(username), 60 * 60 * 24 * 365),
      active
        ? kv.zadd(LISTINGS_ACTIVE_INDEX, { score: Date.now(), member: username })
        : kv.zrem(LISTINGS_ACTIVE_INDEX, username),
    ])

    const freshListing = parseMarketListing(
      username,
      (await kv.hgetall(listingKey(username))) as Record<string, unknown> | null,
      player,
      rented,
    )

    return NextResponse.json({
      ok: true,
      listing: freshListing,
      note: rented ? 'Listing saved, but pet is currently rented.' : undefined,
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
