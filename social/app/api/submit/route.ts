import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()

    const { username, level, xp, totalCommands, streak, achievements, hunger, happiness, energy, skin } = body

    if (!username || typeof level !== 'number') {
      return NextResponse.json({ error: 'Missing required fields: username, level' }, { status: 400 })
    }

    // Calculate score for ranking (weighted: level*1000 + xp + streak*50 + achievements*100)
    const score = level * 1000 + (xp || 0) + (streak || 0) * 50 + (achievements || 0) * 100

    // Store player data
    await kv.hset(`player:${username}`, {
      level: level || 1,
      xp: xp || 0,
      totalCommands: totalCommands || 0,
      streak: streak || 0,
      achievements: achievements || 0,
      hunger: hunger || 0,
      happiness: happiness || 0,
      energy: energy || 0,
      skin: skin || 'Robot',
      evolution: getEvolution(level || 1),
      updatedAt: new Date().toISOString(),
    })

    // Add/update in sorted set for ranking
    await kv.zadd('leaderboard', { score, member: username })

    return NextResponse.json({ ok: true, score, rank: await getRank(username) })
  } catch (e) {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}

function getEvolution(level: number): string {
  if (level >= 20) return 'Cosmic'
  if (level >= 15) return 'Mythic'
  if (level >= 10) return 'Epic'
  if (level >= 5) return 'Evolved'
  return 'Baby'
}

async function getRank(username: string): Promise<number> {
  const rank = await kv.zrevrank('leaderboard', username)
  return rank !== null ? rank + 1 : -1
}
