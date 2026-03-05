import type { Metadata } from 'next'
import { headers } from 'next/headers'

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
}

export const metadata: Metadata = {
  title: 'How Agent-O Pets Learn',
  description:
    'Training architecture of Agent-O specialist pets: prompt signals, specialization graph, and rental economy.',
}

function getBaseUrl(): string {
  const host = headers().get('host') || 'localhost:3000'
  const protocol = host.includes('localhost') ? 'http' : 'https'
  return `${protocol}://${host}`
}

async function getMarketSummary(): Promise<MarketSummary> {
  const fallback: MarketSummary = {
    counts: {
      activeListings: 0,
      activeRentals: 0,
      totalRentals: 0,
    },
    economics: {
      avgPricePerDayActive: 0,
      avgRentalDaysRecent: 0,
      recentRentalVolume: 0,
      utilizationPct: 0,
    },
    specializations: [],
  }

  try {
    const res = await fetch(`${getBaseUrl()}/api/pets/market/summary?limit=6`, {
      cache: 'no-store',
    })
    if (!res.ok) return fallback
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
    }
  } catch {
    return fallback
  }
}

export default async function LearningPage() {
  const market = await getMarketSummary()
  const topSpecs = market.specializations.slice(0, 5)

  return (
    <div className="container learning-page">
      <div className="learning-nav">
        <a href="/">← Leaderboard</a>
        <span>•</span>
        <a href="/marketplace">Marketplace</a>
      </div>

      <section className="learning-hero">
        <p className="learning-eyebrow">Agent-O Intelligence Architecture</p>
        <h1>How Your Pet Learns, Specializes, and Becomes Rentable</h1>
        <p className="learning-subtitle">
          Every Claude/Codex prompt becomes training signal. Signals shape a specialty profile.
          Strong profiles get selected in the marketplace and generate rental value.
        </p>

        <div className="learning-hero-cta">
          <a className="learning-btn learning-btn-primary" href="https://github.com/egorfedorov/agentO">
            Install Agent-O
          </a>
          <a className="learning-btn learning-btn-ghost" href="/marketplace">
            View Marketplace
          </a>
        </div>

        <div className="learning-kpis">
          <div className="learning-kpi">
            <span>Active listings</span>
            <strong>{market.counts.activeListings}</strong>
          </div>
          <div className="learning-kpi">
            <span>Active rentals</span>
            <strong>{market.counts.activeRentals}</strong>
          </div>
          <div className="learning-kpi">
            <span>Market utilization</span>
            <strong>{market.economics.utilizationPct}%</strong>
          </div>
          <div className="learning-kpi">
            <span>Avg price/day</span>
            <strong>{market.economics.avgPricePerDayActive.toLocaleString()} XP</strong>
          </div>
        </div>
      </section>

      <section className="learning-svg-card">
        <div className="learning-section-head">
          <h2>Training Pipeline (Live Concept)</h2>
          <p>From raw prompts to specialist skills and rental demand.</p>
        </div>

        <svg
          className="learning-pipeline-svg"
          viewBox="0 0 1080 320"
          role="img"
          aria-label="Agent-O learning pipeline diagram"
        >
          <defs>
            <linearGradient id="nodeGradA" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="#0f1f35" />
              <stop offset="100%" stopColor="#1a1430" />
            </linearGradient>
            <linearGradient id="nodeGradB" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="#132a25" />
              <stop offset="100%" stopColor="#1f1635" />
            </linearGradient>
            <filter id="softGlow" x="-50%" y="-50%" width="200%" height="200%">
              <feGaussianBlur stdDeviation="6" result="blur" />
              <feMerge>
                <feMergeNode in="blur" />
                <feMergeNode in="SourceGraphic" />
              </feMerge>
            </filter>
          </defs>

          <rect x="40" y="40" width="220" height="92" rx="16" className="lp-node lp-node-a" />
          <text x="60" y="77" className="lp-node-title">1. Prompt Stream</text>
          <text x="60" y="102" className="lp-node-text">Claude CLI + Codex CLI</text>

          <rect x="300" y="40" width="220" height="92" rx="16" className="lp-node lp-node-b" />
          <text x="320" y="77" className="lp-node-title">2. Signal Parsing</text>
          <text x="320" y="102" className="lp-node-text">topics, tools, intent</text>

          <rect x="560" y="40" width="240" height="92" rx="16" className="lp-node lp-node-c" />
          <text x="580" y="77" className="lp-node-title">3. Specialty Graph</text>
          <text x="580" y="102" className="lp-node-text">score per domain</text>

          <rect x="840" y="40" width="200" height="92" rx="16" className="lp-node lp-node-d" />
          <text x="860" y="77" className="lp-node-title">4. Rent Market</text>
          <text x="860" y="102" className="lp-node-text">demand + price/day</text>

          <path className="lp-flow f1" d="M260 86 H300" />
          <path className="lp-flow f2" d="M520 86 H560" />
          <path className="lp-flow f3" d="M800 86 H840" />

          <circle cx="160" cy="212" r="38" className="lp-orb orb-a" />
          <text x="128" y="216" className="lp-orb-text">Game Dev</text>

          <circle cx="320" cy="248" r="30" className="lp-orb orb-b" />
          <text x="295" y="252" className="lp-orb-text">Art</text>

          <circle cx="470" cy="212" r="34" className="lp-orb orb-c" />
          <text x="434" y="216" className="lp-orb-text">Frontend</text>

          <circle cx="640" cy="248" r="30" className="lp-orb orb-d" />
          <text x="607" y="252" className="lp-orb-text">Backend</text>

          <circle cx="800" cy="212" r="34" className="lp-orb orb-e" />
          <text x="770" y="216" className="lp-orb-text">Automation</text>

          <path className="lp-link" d="M198 194 L292 233" />
          <path className="lp-link" d="M350 248 L436 223" />
          <path className="lp-link" d="M504 216 L610 244" />
          <path className="lp-link" d="M670 241 L766 219" />

          <circle cx="270" cy="86" r="5" className="lp-pulse" filter="url(#softGlow)" />
          <circle cx="530" cy="86" r="5" className="lp-pulse delay-1" filter="url(#softGlow)" />
          <circle cx="815" cy="86" r="5" className="lp-pulse delay-2" filter="url(#softGlow)" />
        </svg>
      </section>

      <section className="learning-grid">
        <article className="learning-card">
          <h3>1) Capture Prompt Signals</h3>
          <p>
            Agent-O records prompts from Claude and Codex sessions and extracts domain hints:
            framework names, tool chains, and recurring vocabulary.
          </p>
          <code>/promptstats 7</code>
        </article>
        <article className="learning-card">
          <h3>2) Score Specialist Domains</h3>
          <p>
            The pet updates specialty scores continuously. Stronger domains become your active
            specialist profile automatically.
          </p>
          <code>/specialist</code>
        </article>
        <article className="learning-card">
          <h3>3) Manual Override When Needed</h3>
          <p>
            You can lock a domain manually for a project sprint, then return to auto-learning
            once the sprint is done.
          </p>
          <code>/specialist set stake_game_dev</code>
        </article>
      </section>

      <section className="learning-grid learning-grid-2">
        <article className="learning-panel">
          <h3>Specialty Catalog</h3>
          <p>Built-in domains currently tracked by the pet brain:</p>
          <ul className="learning-list">
            <li>Game Dev (Stake/RGS)</li>
            <li>Image & Prompt Art</li>
            <li>Frontend & UX</li>
            <li>Backend & APIs</li>
            <li>Automation & Ops</li>
          </ul>
          <code>/specialist list</code>
        </article>

        <article className="learning-panel">
          <h3>Economy Feedback Loop</h3>
          <p>
            Better specialist quality leads to better listing conversion. That gives owners
            a reason to keep training their pet with real work prompts.
          </p>
          <div className="learning-pill-row">
            <span>Avg rental: {market.economics.avgRentalDaysRecent} days</span>
            <span>Recent volume: {market.economics.recentRentalVolume.toLocaleString()} XP</span>
          </div>
        </article>
      </section>

      <section className="learning-demand">
        <div className="learning-section-head">
          <h2>Current Demand Snapshot</h2>
          <p>Most requested specialist profiles right now.</p>
        </div>
        {topSpecs.length === 0 ? (
          <p className="battle-empty">No specialization demand data yet.</p>
        ) : (
          <div className="learning-demand-grid">
            {topSpecs.map((spec) => (
              <article className="learning-demand-card" key={spec.key}>
                <h3>{spec.label}</h3>
                <p>Listings: {spec.listings}</p>
                <p>Avg price: {spec.avgPricePerDay.toLocaleString()} XP/day</p>
                <p>Rentals: {spec.renterCount}</p>
                <p>Total rental days: {spec.totalDays}</p>
              </article>
            ))}
          </div>
        )}
      </section>

      <section className="learning-cta">
        <h2>Build a Specialist Pet People Actually Rent</h2>
        <p>
          Train daily with real prompts, inspect signals, lock domain during focused sprints,
          then publish your profile in marketplace.
        </p>
        <div className="learning-command-list">
          <code>/training</code>
          <code>/specialist</code>
          <code>/specialist auto</code>
          <code>/rent publish 80 7 GameEngineer</code>
        </div>
        <div className="learning-hero-cta">
          <a className="learning-btn learning-btn-primary" href="/marketplace">See Live Marketplace</a>
          <a className="learning-btn learning-btn-ghost" href="/">Back to Leaderboard</a>
        </div>
      </section>

      <div className="footer">
        <a href="/">Leaderboard</a>
        {' · '}
        <a href="/marketplace">Marketplace</a>
        {' · '}
        <a href="https://github.com/egorfedorov/agentO">GitHub</a>
        {' · '}
        Learning Architecture
      </div>
    </div>
  )
}
