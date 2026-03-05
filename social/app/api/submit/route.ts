import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

type PlayerRecord = {
  level?: number | string
  xp?: number | string
  totalCommands?: number | string
  streak?: number | string
  achievements?: number | string
  hunger?: number | string
  happiness?: number | string
  energy?: number | string
  skin?: string
  evolution?: string
  ownerToken?: string
  updatedAt?: string
  createdAt?: string
}

function toInt(value: unknown, fallback = 0): number {
  const num = typeof value === 'number' ? value : Number(value)
  return Number.isFinite(num) ? Math.floor(num) : fallback
}

function clamp(value: number, min: number, max: number): number {
  return Math.max(min, Math.min(max, value))
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

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    const username = String(body?.username || '').trim()
    let token = String(body?.token || '').trim()

    if (!username) {
      return NextResponse.json({ error: 'Missing required field: username' }, { status: 400 })
    }

    const input = {
      level: clamp(toInt(body?.level, 1), 1, 100),
      xp: clamp(toInt(body?.xp, 0), 0, 50_000_000),
      totalCommands: clamp(toInt(body?.totalCommands, 0), 0, 20_000_000),
      streak: clamp(toInt(body?.streak, 0), 0, 3650),
      achievements: clamp(toInt(body?.achievements, 0), 0, 500),
      hunger: clamp(toInt(body?.hunger, 0), 0, 100),
      happiness: clamp(toInt(body?.happiness, 0), 0, 100),
      energy: clamp(toInt(body?.energy, 0), 0, 100),
      skin: String(body?.skin || 'Robot').slice(0, 40),
    }

    const key = `player:${username}`
    const existing = (await kv.hgetall(key)) as PlayerRecord | null

    if (existing?.ownerToken) {
      if (!token || token !== existing.ownerToken) {
        return NextResponse.json(
          { error: 'Username is protected by another device token' },
          { status: 403 }
        )
      }
    } else if (existing && !token) {
      return NextResponse.json(
        { error: 'Client update required. Re-submit from latest Agent-O app.' },
        { status: 409 }
      )
    }

    if (!token) {
      token = crypto.randomUUID().replaceAll('-', '')
    }

    const prev = {
      level: toInt(existing?.level, 1),
      xp: toInt(existing?.xp, 0),
      totalCommands: toInt(existing?.totalCommands, 0),
      streak: toInt(existing?.streak, 0),
      achievements: toInt(existing?.achievements, 0),
    }

    // Anti-cheat gates: reject unrealistic single-update jumps.
    if (existing) {
      if (input.level > prev.level + 5) {
        return NextResponse.json({ error: 'Suspicious level jump detected' }, { status: 422 })
      }
      if (input.xp > prev.xp + 50_000) {
        return NextResponse.json({ error: 'Suspicious XP jump detected' }, { status: 422 })
      }
      if (input.totalCommands > prev.totalCommands + 20_000) {
        return NextResponse.json({ error: 'Suspicious command jump detected' }, { status: 422 })
      }
      if (input.streak > prev.streak + 2) {
        return NextResponse.json({ error: 'Suspicious streak jump detected' }, { status: 422 })
      }
      if (input.achievements > prev.achievements + 10) {
        return NextResponse.json({ error: 'Suspicious achievements jump detected' }, { status: 422 })
      }
    }

    // Keep best-known progress to prevent accidental local resets from wiping data.
    const merged = {
      level: existing ? Math.max(input.level, prev.level) : input.level,
      xp: existing ? Math.max(input.xp, prev.xp) : input.xp,
      totalCommands: existing ? Math.max(input.totalCommands, prev.totalCommands) : input.totalCommands,
      streak: existing ? Math.max(input.streak, prev.streak) : input.streak,
      achievements: existing ? Math.max(input.achievements, prev.achievements) : input.achievements,
      hunger: input.hunger,
      happiness: input.happiness,
      energy: input.energy,
      skin: input.skin || existing?.skin || 'Robot',
    }

    const score =
      merged.level * 1000 +
      merged.xp +
      merged.streak * 50 +
      merged.achievements * 100

    const now = new Date().toISOString()
    await kv.hset(key, {
      level: merged.level,
      xp: merged.xp,
      totalCommands: merged.totalCommands,
      streak: merged.streak,
      achievements: merged.achievements,
      hunger: merged.hunger,
      happiness: merged.happiness,
      energy: merged.energy,
      skin: merged.skin,
      evolution: getEvolution(merged.level),
      ownerToken: token,
      updatedAt: now,
      createdAt: existing?.createdAt || now,
    })
    await kv.zadd('leaderboard', { score, member: username })

    return NextResponse.json({
      ok: true,
      score,
      rank: await getRank(username),
      token,
      protected: true,
      merged,
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
