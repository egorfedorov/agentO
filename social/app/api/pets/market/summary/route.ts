import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'
import {
  ACTIVE_RENTALS_COUNT_KEY,
  LISTINGS_ACTIVE_INDEX,
  RECENT_RENTALS_LIST,
  TOTAL_RENTALS_COUNT_KEY,
  parseMarketRental,
  rentalKey,
  toInt,
} from '../shared'

export const dynamic = 'force-dynamic'

export async function GET(req: NextRequest) {
  try {
    const limitRaw = Number(req.nextUrl.searchParams.get('limit') || '10')
    const limit = Number.isFinite(limitRaw) ? Math.max(1, Math.min(50, limitRaw)) : 10

    const [activeListingsRaw, activeRentalsRaw, totalRentalsRaw, recentIds] = await Promise.all([
      kv.zcard(LISTINGS_ACTIVE_INDEX),
      kv.get<number | string>(ACTIVE_RENTALS_COUNT_KEY),
      kv.get<number | string>(TOTAL_RENTALS_COUNT_KEY),
      kv.lrange<string[]>(RECENT_RENTALS_LIST, 0, limit * 2 - 1),
    ])

    const seen = new Set<string>()
    const uniqueIds: string[] = []
    for (const id of recentIds) {
      const clean = String(id || '').trim()
      if (!clean || seen.has(clean)) continue
      seen.add(clean)
      uniqueIds.push(clean)
      if (uniqueIds.length >= limit) break
    }

    const recentRentals = (
      await Promise.all(
        uniqueIds.map(async (id) => {
          const row = (await kv.hgetall(rentalKey(id))) as Record<string, unknown> | null
          return parseMarketRental(row)
        }),
      )
    ).filter((row): row is NonNullable<typeof row> => Boolean(row))

    return NextResponse.json({
      counts: {
        activeListings: Math.max(0, toInt(activeListingsRaw, 0)),
        activeRentals: Math.max(0, toInt(activeRentalsRaw, 0)),
        totalRentals: Math.max(0, toInt(totalRentalsRaw, 0)),
      },
      recentRentals,
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
