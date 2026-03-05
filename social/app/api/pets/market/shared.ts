export interface PlayerRecord extends Record<string, unknown> {
  ownerToken?: string
  level?: number | string
  skin?: string
  evolution?: string
}

export interface MarketListing {
  ownerUsername: string
  title: string
  description: string
  pricePerDay: number
  minDays: number
  maxDays: number
  active: boolean
  rented: boolean
  createdAt: string
  updatedAt: string
  renterCount: number
  totalDays: number
  level: number
  skin: string
  evolution: string
}

export interface MarketRental {
  id: string
  ownerUsername: string
  renterUsername: string
  title: string
  pricePerDay: number
  days: number
  totalPrice: number
  status: 'active' | 'ended' | 'cancelled'
  createdAt: string
  startAt: string
  endAt: string
  endedAt?: string
}

export const LISTINGS_ACTIVE_INDEX = 'pet:market:listings:active'
export const ACTIVE_RENTALS_COUNT_KEY = 'pet:market:rental:active_count'
export const TOTAL_RENTALS_COUNT_KEY = 'pet:market:rental:total_count'
export const RECENT_RENTALS_LIST = 'pet:market:rental:recent'

export function listingKey(ownerUsername: string): string {
  return `pet:market:listing:${ownerUsername}`
}

export function rentalKey(rentalId: string): string {
  return `pet:market:rental:${rentalId}`
}

export function ownerRentalsKey(ownerUsername: string): string {
  return `pet:market:rental:owner:${ownerUsername}`
}

export function renterRentalsKey(renterUsername: string): string {
  return `pet:market:rental:renter:${renterUsername}`
}

export function activeRentalLockKey(ownerUsername: string): string {
  return `pet:market:rental:active:${ownerUsername}`
}

export function toInt(value: unknown, fallback = 0): number {
  const num = typeof value === 'number' ? value : Number(value)
  return Number.isFinite(num) ? Math.floor(num) : fallback
}

export function clamp(value: number, min: number, max: number): number {
  return Math.max(min, Math.min(max, value))
}

export function toBool(value: unknown, fallback = false): boolean {
  if (typeof value === 'boolean') return value
  if (typeof value === 'number') return value !== 0
  if (typeof value === 'string') {
    const v = value.trim().toLowerCase()
    if (['true', '1', 'yes', 'on'].includes(v)) return true
    if (['false', '0', 'no', 'off'].includes(v)) return false
  }
  return fallback
}

export function toIso(value: unknown, fallback: string): string {
  if (typeof value === 'string' && value.trim().length > 0) return value
  return fallback
}

export function parseMarketListing(
  ownerUsername: string,
  row: Record<string, unknown> | null,
  player: Record<string, unknown> | null,
  rented: boolean,
): MarketListing | null {
  if (!row) return null
  const nowIso = new Date().toISOString()
  const level = clamp(toInt(player?.level ?? row.level, 1), 1, 100)
  const skin = String(player?.skin || row.skin || 'Robot')
  const evolution = String(player?.evolution || row.evolution || 'Baby')
  const pricePerDay = clamp(toInt(row.pricePerDay, 10), 1, 1_000_000)
  const maxDays = clamp(toInt(row.maxDays, 7), 1, 30)
  const minDays = clamp(toInt(row.minDays, 1), 1, maxDays)
  const active = toBool(row.active, true) && !rented

  return {
    ownerUsername,
    title: String(row.title || `${ownerUsername}'s Pet`).slice(0, 80),
    description: String(row.description || 'Smart Agent-O pet companion').slice(0, 500),
    pricePerDay,
    minDays,
    maxDays,
    active,
    rented,
    createdAt: toIso(row.createdAt, nowIso),
    updatedAt: toIso(row.updatedAt, nowIso),
    renterCount: clamp(toInt(row.renterCount, 0), 0, 10_000_000),
    totalDays: clamp(toInt(row.totalDays, 0), 0, 10_000_000),
    level,
    skin,
    evolution,
  }
}

export function parseMarketRental(row: Record<string, unknown> | null): MarketRental | null {
  if (!row) return null
  const id = String(row.id || '').trim()
  const ownerUsername = String(row.ownerUsername || '').trim()
  const renterUsername = String(row.renterUsername || '').trim()
  if (!id || !ownerUsername || !renterUsername) return null
  const createdAt = toIso(row.createdAt, new Date().toISOString())
  const statusRaw = String(row.status || 'active').toLowerCase()
  const status: MarketRental['status'] =
    statusRaw === 'ended' ? 'ended' : statusRaw === 'cancelled' ? 'cancelled' : 'active'

  return {
    id,
    ownerUsername,
    renterUsername,
    title: String(row.title || `${ownerUsername}'s Pet`).slice(0, 80),
    pricePerDay: clamp(toInt(row.pricePerDay, 1), 1, 1_000_000),
    days: clamp(toInt(row.days, 1), 1, 30),
    totalPrice: clamp(toInt(row.totalPrice, 1), 1, 100_000_000),
    status,
    createdAt,
    startAt: toIso(row.startAt, createdAt),
    endAt: toIso(row.endAt, createdAt),
    endedAt: row.endedAt ? String(row.endedAt) : undefined,
  }
}
