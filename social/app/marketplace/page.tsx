import { headers } from 'next/headers'

interface MarketListing {
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

interface MarketRental {
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

interface MarketSummary {
  counts: {
    activeListings: number
    activeRentals: number
    totalRentals: number
  }
  economics: {
    avgPricePerDayActive: number
    avgRentalDaysRecent: number
    recentRentalVolume: number
    utilizationPct: number
  }
  specializations: Array<{
    key: string
    label: string
    listings: number
    avgPricePerDay: number
    renterCount: number
    totalDays: number
  }>
  recentRentals: MarketRental[]
}

function getBaseUrl(): string {
  const host = headers().get('host') || 'localhost:3000'
  const protocol = host.includes('localhost') ? 'http' : 'https'
  return `${protocol}://${host}`
}

async function getListings(): Promise<MarketListing[]> {
  try {
    const res = await fetch(`${getBaseUrl()}/api/pets/market/listings?limit=40`, {
      cache: 'no-store',
    })
    if (!res.ok) return []
    const data = await res.json()
    return data.listings || []
  } catch {
    return []
  }
}

async function getSummary(): Promise<MarketSummary> {
  const fallback: MarketSummary = {
    counts: { activeListings: 0, activeRentals: 0, totalRentals: 0 },
    economics: {
      avgPricePerDayActive: 0,
      avgRentalDaysRecent: 0,
      recentRentalVolume: 0,
      utilizationPct: 0,
    },
    specializations: [],
    recentRentals: [],
  }
  try {
    const res = await fetch(`${getBaseUrl()}/api/pets/market/summary?limit=20`, {
      cache: 'no-store',
    })
    if (!res.ok) {
      return fallback
    }
    const data = await res.json()
    return {
      counts: {
        activeListings: Number(data?.counts?.activeListings || 0),
        activeRentals: Number(data?.counts?.activeRentals || 0),
        totalRentals: Number(data?.counts?.totalRentals || 0),
      },
      economics: {
        avgPricePerDayActive: Number(data?.economics?.avgPricePerDayActive || 0),
        avgRentalDaysRecent: Number(data?.economics?.avgRentalDaysRecent || 0),
        recentRentalVolume: Number(data?.economics?.recentRentalVolume || 0),
        utilizationPct: Number(data?.economics?.utilizationPct || 0),
      },
      specializations: Array.isArray(data?.specializations) ? data.specializations : [],
      recentRentals: (data?.recentRentals || []) as MarketRental[],
    }
  } catch {
    return fallback
  }
}

function statusLabel(listing: MarketListing): string {
  if (listing.rented) return 'Rented now'
  if (!listing.active) return 'Offline'
  return 'Available'
}

export default async function MarketplacePage() {
  const [listings, summary] = await Promise.all([getListings(), getSummary()])

  return (
    <div className="container">
      <div className="header">
        <a href="/" style={{ color: '#4dd4e6', textDecoration: 'none', fontSize: '0.9rem' }}>
          ← Back to Leaderboard
        </a>
        <h1 style={{ marginTop: 16 }}>Pet Marketplace</h1>
        <p>Rent Agent-O pets from real players. One active renter per pet.</p>
      </div>

      <div className="stats-row">
        <div className="stat-box">
          <div className="number">{summary.counts.activeListings}</div>
          <div className="label">Listings</div>
        </div>
        <div className="stat-box">
          <div className="number">{summary.counts.activeRentals}</div>
          <div className="label">Active Rentals</div>
        </div>
        <div className="stat-box">
          <div className="number">{summary.counts.totalRentals}</div>
          <div className="label">Total Rentals</div>
        </div>
      </div>

      <div className="market-instructions">
        <h2>Commands in Agent-O</h2>
        <p><code>/rent publish 50 7 CyberCat</code> to publish your pet listing</p>
        <p><code>/rent take username 3</code> to rent someone&apos;s pet</p>
        <p><code>/rent my both</code> to view your rental history</p>
        <p><code>/rent end rental_id</code> to end your active rental as owner</p>
      </div>

      <div className="earn-section">
        <div className="earn-head">
          <h2>Specialist Pet Economy</h2>
          <p>Pets that are better in one domain are more likely to be rented.</p>
        </div>
        <div className="earn-stats">
          <span>Avg price: {summary.economics.avgPricePerDayActive.toLocaleString()} XP/day</span>
          <span>Avg duration: {summary.economics.avgRentalDaysRecent} days</span>
          <span>Utilization: {summary.economics.utilizationPct}%</span>
          <span>Recent volume: {summary.economics.recentRentalVolume.toLocaleString()} XP</span>
        </div>
        <div className="earn-specialties">
          <h3>Most Requested Specializations</h3>
          {summary.specializations.length === 0 ? (
            <p className="battle-empty">No specialization stats yet.</p>
          ) : (
            <div className="earn-specialty-grid">
              {summary.specializations.slice(0, 6).map((spec) => (
                <div className="earn-specialty-card" key={spec.key}>
                  <div className="name">{spec.label}</div>
                  <div className="meta">Listings {spec.listings} · Avg {spec.avgPricePerDay.toLocaleString()} XP/day</div>
                  <div className="meta">Rentals {spec.renterCount} · Total {spec.totalDays} days</div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      <div className="market-grid">
        {listings.length === 0 ? (
          <div className="market-empty">
            <p>No active listings yet. Publish with <code>/rent publish ...</code></p>
          </div>
        ) : (
          listings.map((listing) => (
            <div className="market-card" key={listing.ownerUsername}>
              <div className="market-card-top">
                <a href={`/player/${listing.ownerUsername}`}>{listing.ownerUsername}</a>
                <span className={`market-status ${listing.active && !listing.rented ? 'ok' : 'off'}`}>
                  {statusLabel(listing)}
                </span>
              </div>
              <h3>{listing.title}</h3>
              <p className="market-meta">
                Lv.{listing.level} · {listing.skin} · {listing.evolution}
              </p>
              <p className="market-description">{listing.description}</p>
              <div className="market-price">{listing.pricePerDay.toLocaleString()} XP/day</div>
              <p className="market-meta">
                Min {listing.minDays}d · Max {listing.maxDays}d · Rentals {listing.renterCount}
              </p>
              <code>/rent take {listing.ownerUsername} {Math.max(1, listing.minDays)}</code>
            </div>
          ))
        )}
      </div>

      <div className="battle-feed" style={{ marginTop: 28 }}>
        <div className="battle-feed-head">
          <h2>Recent Rentals</h2>
          <p>Who rented whose pet and for how long.</p>
        </div>
        {summary.recentRentals.length === 0 ? (
          <p className="battle-empty">No rentals yet.</p>
        ) : (
          <div className="battle-list">
            {summary.recentRentals.map((rental) => (
              <div className="battle-row" key={rental.id}>
                <div className="battle-main">
                  <span className="battle-pair">
                    <a href={`/player/${rental.renterUsername}`}>{rental.renterUsername}</a>
                    {' '}→{' '}
                    <a href={`/player/${rental.ownerUsername}`}>{rental.ownerUsername}</a>
                  </span>
                  <span className={`battle-winner ${rental.status === 'active' ? '' : 'draw'}`}>
                    {rental.status}
                  </span>
                </div>
                <div className="battle-sub">
                  {rental.title} · {rental.days}d · {rental.totalPrice.toLocaleString()} XP total
                </div>
                <div className="battle-time">
                  {rental.createdAt ? new Date(rental.createdAt).toLocaleString() : 'Unknown time'}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      <div className="footer">
        <a href="/">Leaderboard</a>
        {' · '}
        <a href="https://github.com/egorfedorov/agentO">GitHub</a>
        {' · '}
        Marketplace
      </div>
    </div>
  )
}
