import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'
import {
  ACTIVE_RENTALS_COUNT_KEY,
  LISTINGS_ACTIVE_INDEX,
  RECENT_RENTALS_LIST,
  TOTAL_RENTALS_COUNT_KEY,
  listingKey,
  parseMarketRental,
  rentalKey,
  toBool,
  toInt,
} from '../shared'

export const dynamic = 'force-dynamic'

type SpecializationKey =
  | 'stake_game_dev'
  | 'prompt_art'
  | 'frontend_ui'
  | 'backend_systems'
  | 'automation_ops'
  | 'generalist'

type SpecializationMeta = {
  key: SpecializationKey
  label: string
  keywords: string[]
}

const SPECIALIZATIONS: SpecializationMeta[] = [
  {
    key: 'stake_game_dev',
    label: 'Game Dev (Stake/RGS)',
    keywords: ['stake', 'rgs', 'slot', 'rtp', 'game math', 'freespin', 'reel', 'bonus game'],
  },
  {
    key: 'prompt_art',
    label: 'Image & Prompt Art',
    keywords: ['image', 'art', 'render', 'midjourney', 'stable diffusion', 'concept', 'illustration'],
  },
  {
    key: 'frontend_ui',
    label: 'Frontend & UX',
    keywords: ['frontend', 'react', 'next.js', 'tailwind', 'ui', 'ux', 'css', 'svelte'],
  },
  {
    key: 'backend_systems',
    label: 'Backend & API',
    keywords: ['backend', 'api', 'server', 'database', 'redis', 'postgres', 'node', 'typescript'],
  },
  {
    key: 'automation_ops',
    label: 'Automation & Ops',
    keywords: ['automation', 'script', 'ci', 'deploy', 'workflow', 'bash', 'terminal', 'git'],
  },
  {
    key: 'generalist',
    label: 'Generalist',
    keywords: [],
  },
]

function detectSpecialization(text: string): SpecializationKey {
  const normalized = text.trim().toLowerCase()
  if (!normalized) return 'generalist'
  for (const spec of SPECIALIZATIONS) {
    if (spec.key === 'generalist') continue
    if (spec.keywords.some((word) => normalized.includes(word))) {
      return spec.key
    }
  }
  return 'generalist'
}

export async function GET(req: NextRequest) {
  try {
    const limitRaw = Number(req.nextUrl.searchParams.get('limit') || '10')
    const limit = Number.isFinite(limitRaw) ? Math.max(1, Math.min(50, limitRaw)) : 10

    const [activeListingsRaw, activeRentalsRaw, totalRentalsRaw, recentIds, activeOwners] = await Promise.all([
      kv.zcard(LISTINGS_ACTIVE_INDEX),
      kv.get<number | string>(ACTIVE_RENTALS_COUNT_KEY),
      kv.get<number | string>(TOTAL_RENTALS_COUNT_KEY),
      kv.lrange<string[]>(RECENT_RENTALS_LIST, 0, limit * 2 - 1),
      kv.zrange<string[]>(LISTINGS_ACTIVE_INDEX, 0, 199, { rev: true }),
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

    const listingRows = (
      await Promise.all(
        activeOwners.map(async (ownerUsername) => {
          const row = (await kv.hgetall(listingKey(ownerUsername))) as Record<string, unknown> | null
          return row ? { ownerUsername, row } : null
        }),
      )
    ).filter((item): item is { ownerUsername: string; row: Record<string, unknown> } => Boolean(item))

    const specTotals = new Map<
      SpecializationKey,
      { count: number; totalPricePerDay: number; renterCount: number; totalDays: number }
    >()
    let activePriceTotal = 0
    let activePriceCount = 0

    for (const item of listingRows) {
      const row = item.row
      const active = toBool(row.active, true)
      if (!active) continue
      const pricePerDay = Math.max(1, toInt(row.pricePerDay, 1))
      const renterCount = Math.max(0, toInt(row.renterCount, 0))
      const totalDays = Math.max(0, toInt(row.totalDays, 0))
      const text = `${String(row.title || '')} ${String(row.description || '')}`
      const specialization = detectSpecialization(text)
      const prev = specTotals.get(specialization) || {
        count: 0,
        totalPricePerDay: 0,
        renterCount: 0,
        totalDays: 0,
      }
      specTotals.set(specialization, {
        count: prev.count + 1,
        totalPricePerDay: prev.totalPricePerDay + pricePerDay,
        renterCount: prev.renterCount + renterCount,
        totalDays: prev.totalDays + totalDays,
      })
      activePriceTotal += pricePerDay
      activePriceCount += 1
    }

    const specializations = Array.from(specTotals.entries())
      .map(([key, value]) => {
        const meta = SPECIALIZATIONS.find((item) => item.key === key)
        const avgPricePerDay =
          value.count > 0 ? Math.floor(value.totalPricePerDay / value.count) : 0
        return {
          key,
          label: meta?.label || key,
          listings: value.count,
          avgPricePerDay,
          renterCount: value.renterCount,
          totalDays: value.totalDays,
        }
      })
      .sort((a, b) => {
        if (b.listings === a.listings) return b.avgPricePerDay - a.avgPricePerDay
        return b.listings - a.listings
      })
      .slice(0, 6)

    const recentRentalDaysTotal = recentRentals.reduce((sum, row) => sum + row.days, 0)
    const recentRentalPriceTotal = recentRentals.reduce((sum, row) => sum + row.totalPrice, 0)
    const avgRentalDays = recentRentals.length
      ? Math.round((recentRentalDaysTotal / recentRentals.length) * 10) / 10
      : 0
    const activeListings = Math.max(activePriceCount, Math.max(0, toInt(activeListingsRaw, 0)))
    const activeRentals = Math.max(0, toInt(activeRentalsRaw, 0))
    const activeMarketPool = activeListings + activeRentals
    const utilizationPct =
      activeMarketPool > 0 ? Math.round((activeRentals / activeMarketPool) * 100) : 0

    return NextResponse.json({
      counts: {
        activeListings,
        activeRentals,
        totalRentals: Math.max(0, toInt(totalRentalsRaw, 0)),
      },
      economics: {
        avgPricePerDayActive: activePriceCount > 0 ? Math.floor(activePriceTotal / activePriceCount) : 0,
        avgRentalDaysRecent: avgRentalDays,
        recentRentalVolume: recentRentalPriceTotal,
        utilizationPct,
      },
      specializations,
      recentRentals,
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
