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

async function getLeaderboard(): Promise<Player[]> {
  try {
    const host = headers().get('host') || 'localhost:3000'
    const protocol = host.includes('localhost') ? 'http' : 'https'
    const res = await fetch(`${protocol}://${host}/api/leaderboard`, {
      cache: 'no-store',
    })
    if (!res.ok) return []
    const data = await res.json()
    return data.players || []
  } catch {
    return []
  }
}

export default async function Home() {
  const players = await getLeaderboard()
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
              Run <code style={{ color: '#00e676' }}>!leaderboard</code> in Agent-O to submit your pet
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

      <div className="join-section">
        <h2>Join the Leaderboard</h2>
        <p>1. Install Agent-O</p>
        <code>git clone https://github.com/egorfedorov/agentO.git && cd agentO && ./run.sh</code>
        <p>2. Set your username and publish</p>
        <code>!name YourName</code>
        <br />
        <code>!leaderboard</code>
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
