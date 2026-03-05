import { headers } from 'next/headers'

interface Player {
  username: string
  level: number
  xp: number
  totalCommands: number
  streak: number
  achievements: number
  hunger: number
  happiness: number
  energy: number
  skin: string
  evolution: string
  updatedAt: string
}

interface BattleEntry {
  id: string
  playerA: string
  playerB: string
  winner: string
  result: string
  playerALevel: number
  playerBLevel: number
  playerAPower: number
  playerBPower: number
  playerAAttack?: string | null
  playerADefense?: string | null
  playerBAttack?: string | null
  playerBDefense?: string | null
  playerAScore?: number
  playerBScore?: number
  battleType?: string
  createdAt: string
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
}

function getEvolution(level: number): string {
  if (level >= 20) return 'Cosmic'
  if (level >= 15) return 'Mythic'
  if (level >= 10) return 'Epic'
  if (level >= 5) return 'Evolved'
  return 'Baby'
}

function getBadgeClass(evolution: string): string {
  switch (evolution) {
    case 'Epic': return 'epic'
    case 'Mythic': return 'mythic'
    case 'Cosmic': return 'cosmic'
    default: return ''
  }
}

function getSkinEmoji(skin: string): string {
  switch (skin?.toLowerCase()) {
    case 'cat': return '[=^.^=]'
    case 'skull': return '[X_X]'
    case 'clippy': return '[o_O]'
    default: return '[◉‿◉]'
  }
}

function formatZone(zone?: string | null): string {
  if (!zone) return '-'
  switch (zone) {
    case 'head': return 'Head'
    case 'body': return 'Body'
    case 'legs': return 'Legs'
    default: return zone
  }
}

function getBaseUrl(): string {
  const host = headers().get('host') || 'localhost:3000'
  const protocol = host.includes('localhost') ? 'http' : 'https'
  return `${protocol}://${host}`
}

async function getLeaderboard(): Promise<Player[]> {
  try {
    const res = await fetch(`${getBaseUrl()}/api/leaderboard`, {
      cache: 'no-store',
    })
    if (!res.ok) return []
    const data = await res.json()
    return data.players || []
  } catch {
    return []
  }
}

async function getBattles(): Promise<BattleEntry[]> {
  try {
    const res = await fetch(`${getBaseUrl()}/api/battles?limit=20`, {
      cache: 'no-store',
    })
    if (!res.ok) return []
    const data = await res.json()
    return data.battles || []
  } catch {
    return []
  }
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
    }
  } catch {
    return fallback
  }
}

export default async function Home() {
  const [players, battles, market] = await Promise.all([
    getLeaderboard(),
    getBattles(),
    getMarketSummary(),
  ])
  const totalXP = players.reduce((sum, p) => sum + p.xp, 0)
  const totalCommands = players.reduce((sum, p) => sum + p.totalCommands, 0)
  const topStreak = players.reduce((max, p) => Math.max(max, p.streak), 0)

  return (
    <div className="container">
      <div className="header">
        <h1>Agent-O Leaderboard</h1>
        <p>Global rankings of Agent-O ASCII desktop companions</p>
        <p className="subtitle">Level up your pet, earn achievements, climb the board</p>
      </div>

      <div className="stats-row">
        <div className="stat-box">
          <div className="number">{players.length}</div>
          <div className="label">Players</div>
        </div>
        <div className="stat-box">
          <div className="number">{totalXP.toLocaleString()}</div>
          <div className="label">Total XP</div>
        </div>
        <div className="stat-box">
          <div className="number">{totalCommands.toLocaleString()}</div>
          <div className="label">Commands</div>
        </div>
        <div className="stat-box">
          <div className="number">{topStreak}d</div>
          <div className="label">Best Streak</div>
        </div>
      </div>

      <div className="leaderboard">
        <div className="leaderboard-header">
          <span>#</span>
          <span>Player</span>
          <span>Level</span>
          <span>XP</span>
          <span>Streak</span>
          <span>Ach.</span>
        </div>

        {players.length === 0 ? (
          <div className="empty">
            <div className="robot">[◉‿◉]</div>
            <p>No players yet. Be the first!</p>
            <p style={{ marginTop: 8, fontSize: '0.8rem' }}>
              Run <code style={{ color: '#00e676' }}>/leaderboard</code> in Agent-O to submit your pet
            </p>
          </div>
        ) : (
          players.map((player, i) => {
            const rank = i + 1
            const evolution = player.evolution || getEvolution(player.level)
            return (
              <div className="player-row" key={player.username}>
                <span className={`rank rank-${rank <= 3 ? rank : 0}`}>
                  {rank === 1 ? '👑' : rank === 2 ? '🥈' : rank === 3 ? '🥉' : `#${rank}`}
                </span>
                <div className="player-name">
                  <a href={`/player/${player.username}`} className="name">{getSkinEmoji(player.skin)} {player.username}</a>
                  <span className="skin">{player.skin || 'Robot'} &middot; {evolution}</span>
                </div>
                <span className={`level-badge ${getBadgeClass(evolution)}`}>
                  Lv.{player.level}
                </span>
                <span className="xp-cell">{player.xp.toLocaleString()}</span>
                <span className="streak-cell">{player.streak}d 🔥</span>
                <span className="ach-cell">{player.achievements} 🏆</span>
              </div>
            )
          })
        )}
      </div>

      <div className="battle-feed">
        <div className="battle-feed-head">
          <h2>Recent Battles</h2>
          <p>Who fought, who won, and when.</p>
        </div>
        {battles.length === 0 ? (
          <p className="battle-empty">No battles logged yet. Challenge someone with <code>/battle username</code>.</p>
        ) : (
          <div className="battle-list">
            {battles.map((battle) => {
              const isDraw = battle.winner === 'draw'
              const winnerLabel = isDraw ? 'Draw' : `${battle.winner} won`
              return (
                <div className="battle-row" key={battle.id}>
                  <div className="battle-main">
                    <span className="battle-pair">
                      <a href={`/player/${battle.playerA}`}>{battle.playerA}</a> vs{' '}
                      <a href={`/player/${battle.playerB}`}>{battle.playerB}</a>
                    </span>
                    <span className={`battle-winner ${isDraw ? 'draw' : ''}`}>{winnerLabel}</span>
                  </div>
                  <div className="battle-sub">
                    Lv.{battle.playerALevel} ({battle.playerAPower}) · Lv.{battle.playerBLevel} ({battle.playerBPower})
                    {battle.playerAAttack && battle.playerADefense && battle.playerBAttack && battle.playerBDefense ? (
                      <>
                        {' · '}
                        A:{formatZone(battle.playerAAttack)}/{formatZone(battle.playerADefense)}
                        {' · '}
                        B:{formatZone(battle.playerBAttack)}/{formatZone(battle.playerBDefense)}
                        {typeof battle.playerAScore === 'number' && typeof battle.playerBScore === 'number'
                          ? ` · Score ${battle.playerAScore}:${battle.playerBScore}`
                          : ''}
                      </>
                    ) : null}
                  </div>
                  <div className="battle-time">
                    {battle.createdAt ? new Date(battle.createdAt).toLocaleString() : 'Unknown time'}
                  </div>
                </div>
              )
            })}
          </div>
        )}
      </div>

      <div className="market-preview">
        <div className="market-preview-head">
          <h2>Pet Marketplace</h2>
          <a href="/marketplace">Open Marketplace →</a>
        </div>
        <div className="market-preview-stats">
          <span>Listings: {market.counts.activeListings}</span>
          <span>Active rentals: {market.counts.activeRentals}</span>
          <span>Total rentals: {market.counts.totalRentals}</span>
        </div>
        <p>
          Publish your pet for rent with <code>/rent publish &lt;pricePerDay&gt; &lt;maxDays&gt; &lt;title&gt;</code>
          {' '}in Agent-O.
        </p>
      </div>

      <div className="earn-section">
        <div className="earn-head">
          <h2>How To Earn With Specialist Pets</h2>
          <p>Train a niche pet, publish listing, get hired for focused workflows.</p>
        </div>

        <div className="earn-stats">
          <span>Avg listing price: {market.economics.avgPricePerDayActive.toLocaleString()} XP/day</span>
          <span>Avg rental duration: {market.economics.avgRentalDaysRecent} days</span>
          <span>Market utilization: {market.economics.utilizationPct}%</span>
          <span>Recent rental volume: {market.economics.recentRentalVolume.toLocaleString()} XP</span>
        </div>

        <div className="earn-steps">
          <div className="earn-step">
            <h3>1) Train Daily</h3>
            <p>Use Claude/Codex prompts in your niche and improve profile with <code>/training</code> + <code>/train</code>.</p>
          </div>
          <div className="earn-step">
            <h3>2) Publish Your Pet</h3>
            <p>List your specialist pet with <code>/rent publish</code> and set rental conditions.</p>
          </div>
          <div className="earn-step">
            <h3>3) Get Hired</h3>
            <p>Renters choose pets by specialization quality and rental history on the marketplace.</p>
          </div>
        </div>

        <div className="earn-specialties">
          <h3>Top Specializations Right Now</h3>
          {market.specializations.length === 0 ? (
            <p className="battle-empty">No specialization data yet. Publish first listings to populate demand map.</p>
          ) : (
            <div className="earn-specialty-grid">
              {market.specializations.slice(0, 6).map((spec) => (
                <div className="earn-specialty-card" key={spec.key}>
                  <div className="name">{spec.label}</div>
                  <div className="meta">
                    Listings {spec.listings} · Avg {spec.avgPricePerDay.toLocaleString()} XP/day
                  </div>
                  <div className="meta">
                    Rentals {spec.renterCount} · Total days {spec.totalDays}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      <div className="join-section">
        <h2>Join the Leaderboard</h2>
        <p>1. Install Agent-O</p>
        <code>git clone https://github.com/egorfedorov/agentO.git && cd agentO && ./run.sh</code>
        <p>2. Set your username and publish</p>
        <code>/name YourName</code>
        <br />
        <code>/leaderboard</code>
        <p style={{ marginTop: 16, color: '#484f58' }}>
          Your pet stats, level, achievements, and streak will appear here.
          <br />
          Keep playing to climb the ranks!
        </p>
      </div>

      <div className="footer">
        <a href="https://github.com/egorfedorov/agentO">GitHub</a>
        {' · '}
        <a href="https://egorfedorov.github.io/agentO/">Website</a>
        {' · '}
        Built with Agent-O v3
      </div>
    </div>
  )
}
