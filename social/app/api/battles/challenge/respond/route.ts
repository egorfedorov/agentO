import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

type ChallengeStatus = 'pending' | 'accepted' | 'declined'

interface ChallengeRecord {
  challenger: string
  opponent: string
  status: ChallengeStatus
  createdAt: string
  expiresAt: string
  updatedAt: string
  battlePayload?: string
}

interface SideStats {
  username: string
  level: number
  hunger: number
  happiness: number
  energy: number
  streak: number
  achievements: number
  power: number
}

interface BattlePayload {
  id: string
  createdAt: string
  challenger: SideStats
  opponent: SideStats
  winner: string
}

function challengeKey(challenger: string, opponent: string): string {
  return `battle:challenge:${challenger}:${opponent}`
}

function inboxKey(username: string): string {
  return `battle:inbox:${username}`
}

function toInt(value: unknown, fallback = 0): number {
  const num = typeof value === 'number' ? value : Number(value)
  return Number.isFinite(num) ? Math.floor(num) : fallback
}

function clamp(value: number, min: number, max: number): number {
  return Math.max(min, Math.min(max, value))
}

function seededLuck(seed: string): number {
  let hash = 2166136261
  for (let i = 0; i < seed.length; i += 1) {
    hash ^= seed.charCodeAt(i)
    hash = Math.imul(hash, 16777619)
  }
  const normalized = (hash >>> 0) / 4294967295
  return 0.85 + normalized * 0.3
}

function computePower(stats: Omit<SideStats, 'power'>, seed: string): number {
  const avgStats = (stats.hunger + stats.happiness + stats.energy) / 3
  const base = stats.level * 100 + avgStats * 2
  const streakBonus = stats.streak * 15
  const achBonus = stats.achievements * 20
  const luck = seededLuck(seed)
  return Math.floor((base + streakBonus + achBonus) * luck)
}

function parseSide(username: string, data: Record<string, unknown> | null): Omit<SideStats, 'power'> {
  return {
    username,
    level: clamp(toInt(data?.level, 1), 1, 100),
    hunger: clamp(toInt(data?.hunger, 50), 0, 100),
    happiness: clamp(toInt(data?.happiness, 50), 0, 100),
    energy: clamp(toInt(data?.energy, 50), 0, 100),
    streak: clamp(toInt(data?.streak, 0), 0, 3650),
    achievements: clamp(toInt(data?.achievements, 0), 0, 500),
  }
}

function parseBattlePayload(raw: unknown): BattlePayload | null {
  if (!raw) return null
  if (typeof raw === 'object') return raw as BattlePayload
  if (typeof raw === 'string') {
    try {
      return JSON.parse(raw) as BattlePayload
    } catch {
      return null
    }
  }
  return null
}

async function pushBattleLog(payload: BattlePayload) {
  const entry = {
    id: payload.id,
    playerA: payload.challenger.username,
    playerB: payload.opponent.username,
    winner: payload.winner,
    result:
      payload.winner === payload.challenger.username
        ? 'win'
        : payload.winner === payload.opponent.username
          ? 'loss'
          : 'draw',
    playerALevel: payload.challenger.level,
    playerBLevel: payload.opponent.level,
    playerAPower: payload.challenger.power,
    playerBPower: payload.opponent.power,
    createdAt: payload.createdAt,
  }
  const serialized = JSON.stringify(entry)
  await Promise.all([
    kv.lpush('battle:feed', serialized),
    kv.ltrim('battle:feed', 0, 199),
    kv.lpush(`battle:player:${payload.challenger.username}`, serialized),
    kv.ltrim(`battle:player:${payload.challenger.username}`, 0, 99),
    kv.lpush(`battle:player:${payload.opponent.username}`, serialized),
    kv.ltrim(`battle:player:${payload.opponent.username}`, 0, 99),
  ])
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    const challenger = String(body?.challenger || '').trim()
    const opponent = String(body?.opponent || '').trim()
    const accepted = Boolean(body?.accepted)
    const token = String(body?.token || '').trim()

    if (!challenger || !opponent) {
      return NextResponse.json({ error: 'Missing challenger or opponent' }, { status: 400 })
    }

    const [challengerData, opponentData] = (await Promise.all([
      kv.hgetall(`player:${challenger}`),
      kv.hgetall(`player:${opponent}`),
    ])) as [Record<string, unknown> | null, Record<string, unknown> | null]

    if (!opponentData) {
      return NextResponse.json({ error: 'Opponent not on leaderboard' }, { status: 404 })
    }
    const opponentOwnerToken = String(opponentData.ownerToken || '')
    if (opponentOwnerToken && token !== opponentOwnerToken) {
      return NextResponse.json({ error: 'Invalid opponent token' }, { status: 403 })
    }

    const key = challengeKey(challenger, opponent)
    const challenge = (await kv.hgetall(key)) as Partial<ChallengeRecord> | null
    if (!challenge) {
      return NextResponse.json({ status: 'not_found' })
    }

    const expiresMs = challenge.expiresAt ? Date.parse(challenge.expiresAt) : 0
    if (challenge.status === 'pending' && expiresMs > 0 && expiresMs < Date.now()) {
      await Promise.all([kv.del(key), kv.zrem(inboxKey(opponent), challenger)])
      return NextResponse.json({ status: 'expired' })
    }

    if (challenge.status === 'accepted' || challenge.status === 'declined') {
      return NextResponse.json({
        status: challenge.status,
        challenger,
        opponent,
        battle: parseBattlePayload(challenge.battlePayload),
      })
    }

    const status: ChallengeStatus = accepted ? 'accepted' : 'declined'
    const updatedAt = new Date().toISOString()
    let battlePayload: BattlePayload | null = null

    if (status === 'accepted') {
      const challengerStatsBase = parseSide(challenger, challengerData)
      const opponentStatsBase = parseSide(opponent, opponentData)
      const seedBase = `${challenger}|${opponent}|${challenge.createdAt || updatedAt}`
      const challengerPower = computePower(challengerStatsBase, `${seedBase}|challenger`)
      const opponentPower = computePower(opponentStatsBase, `${seedBase}|opponent`)
      const winner =
        challengerPower > opponentPower
          ? challenger
          : opponentPower > challengerPower
            ? opponent
            : 'draw'

      battlePayload = {
        id: `battle_${Date.now()}_${Math.random().toString(36).slice(2, 8)}`,
        createdAt: updatedAt,
        challenger: { ...challengerStatsBase, power: challengerPower },
        opponent: { ...opponentStatsBase, power: opponentPower },
        winner,
      }
    }

    await Promise.all([
      kv.hset(key, {
        status,
        updatedAt,
        ...(battlePayload ? { battlePayload: JSON.stringify(battlePayload) } : {}),
      }),
      kv.expire(key, 60 * 60 * 24),
      kv.zrem(inboxKey(opponent), challenger),
      ...(battlePayload ? [pushBattleLog(battlePayload)] : []),
    ])

    return NextResponse.json({
      ok: true,
      status,
      challenger,
      opponent,
      updatedAt,
      battle: battlePayload,
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
