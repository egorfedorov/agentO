import { headers } from 'next/headers'
import { notFound } from 'next/navigation'

interface PlayerData {
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
  rank: number
  score: number
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
  createdAt: string
}

function getEvolution(level: number): string {
  if (level >= 20) return 'Cosmic'
  if (level >= 15) return 'Mythic'
  if (level >= 10) return 'Epic'
  if (level >= 5) return 'Evolved'
  return 'Baby'
}

function getSkinArt(skin: string): string {
  switch (skin?.toLowerCase()) {
    case 'cat':
      return `
  /\\_/\\
 ( o.o )
  > ^ <
 /|   |\\
  |___|`
    case 'skull':
      return `
  .----.
 / X  X \\
 |  __  |
  \\____/
   ||||`
    case 'clippy':
      return `
  .---.
 / o O \\
 | \\_/ |
  \\   /
   | |`
    default:
      return `
  ┌──┐
  │◉◉│
  │──│
  └┬┬┘
   ││`
  }
}

function getStatBar(value: number, width: number = 10): string {
  const filled = Math.round((value / 100) * width)
  const empty = width - filled
  return '[' + '█'.repeat(filled) + '░'.repeat(empty) + ']'
}

function getBaseUrl(): string {
  const host = headers().get('host') || 'localhost:3000'
  const protocol = host.includes('localhost') ? 'http' : 'https'
  return `${protocol}://${host}`
}

async function getPlayer(username: string): Promise<PlayerData | null> {
  try {
    const res = await fetch(`${getBaseUrl()}/api/player/${username}`, {
      cache: 'no-store',
    })
    if (!res.ok) return null
    return await res.json()
  } catch {
    return null
  }
}

async function getPlayerBattles(username: string): Promise<BattleEntry[]> {
  try {
    const res = await fetch(`${getBaseUrl()}/api/battles?player=${encodeURIComponent(username)}&limit=20`, {
      cache: 'no-store',
    })
    if (!res.ok) return []
    const data = await res.json()
    return data.battles || []
  } catch {
    return []
  }
}

export default async function PlayerPage({
  params,
}: {
  params: { username: string }
}) {
  const [player, battles] = await Promise.all([getPlayer(params.username), getPlayerBattles(params.username)])

  if (!player) {
    notFound()
  }

  const evolution = player.evolution || getEvolution(player.level)
  const art = getSkinArt(player.skin)

  return (
    <div className="container">
      <div className="header">
        <a href="/" style={{ color: '#4dd4e6', textDecoration: 'none', fontSize: '0.9rem' }}>
          ← Back to Leaderboard
        </a>
        <h1 style={{ marginTop: 16 }}>{player.username}</h1>
        <p>Rank #{player.rank} · {player.skin || 'Robot'} · {evolution}</p>
      </div>

      <div className="profile-card">
        <pre className="ascii-art">{art}</pre>

        <div className="profile-stats">
          <div className="stat-line">
            <span className="stat-label">Level</span>
            <span className="stat-value level-glow">Lv.{player.level}</span>
          </div>
          <div className="stat-line">
            <span className="stat-label">Evolution</span>
            <span className="stat-value">{evolution}</span>
          </div>
          <div className="stat-line">
            <span className="stat-label">Food</span>
            <span className="stat-bar">{getStatBar(player.hunger)} {player.hunger}%</span>
          </div>
          <div className="stat-line">
            <span className="stat-label">Joy</span>
            <span className="stat-bar">{getStatBar(player.happiness)} {player.happiness}%</span>
          </div>
          <div className="stat-line">
            <span className="stat-label">Energy</span>
            <span className="stat-bar">{getStatBar(player.energy)} {player.energy}%</span>
          </div>
          <div className="stat-line">
            <span className="stat-label">XP</span>
            <span className="stat-value">{player.xp.toLocaleString()}</span>
          </div>
          <div className="stat-line">
            <span className="stat-label">Commands</span>
            <span className="stat-value">{player.totalCommands.toLocaleString()}</span>
          </div>
          <div className="stat-line">
            <span className="stat-label">Streak</span>
            <span className="stat-value">{player.streak}d 🔥</span>
          </div>
          <div className="stat-line">
            <span className="stat-label">Achievements</span>
            <span className="stat-value">{player.achievements} 🏆</span>
          </div>
        </div>
      </div>

      <div className="battle-cta">
        <h2>Challenge {player.username}</h2>
        <code>/battle {player.username}</code>
        <p style={{ marginTop: 8, color: '#484f58', fontSize: '0.85rem' }}>
          Run this command in Agent-O, then the opponent accepts with <code>/accept your_name</code>
        </p>
      </div>

      <div className="battle-feed">
        <div className="battle-feed-head">
          <h2>{player.username}'s Battle History</h2>
          <p>Latest fights, winners, and timestamps.</p>
        </div>
        {battles.length === 0 ? (
          <p className="battle-empty">No logged battles yet.</p>
        ) : (
          <div className="battle-list">
            {battles.map((battle) => {
              const isDraw = battle.winner === 'draw'
              const winnerLabel = isDraw ? 'Draw' : `${battle.winner} won`
              return (
                <div className="battle-row" key={battle.id}>
                  <div className="battle-main">
                    <span className="battle-pair">
                      {battle.playerA} vs {battle.playerB}
                    </span>
                    <span className={`battle-winner ${isDraw ? 'draw' : ''}`}>{winnerLabel}</span>
                  </div>
                  <div className="battle-sub">
                    Lv.{battle.playerALevel} ({battle.playerAPower}) · Lv.{battle.playerBLevel} ({battle.playerBPower})
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

      {player.updatedAt && (
        <p style={{ textAlign: 'center', color: '#484f58', fontSize: '0.8rem', marginTop: 24 }}>
          Last updated: {new Date(player.updatedAt).toLocaleDateString()}
        </p>
      )}

      <div className="footer">
        <a href="https://github.com/egorfedorov/agentO">GitHub</a>
        {' · '}
        <a href="/">Leaderboard</a>
        {' · '}
        <a href="https://egorfedorov.github.io/agentO/">Website</a>
      </div>
    </div>
  )
}
