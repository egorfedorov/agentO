import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

const CHALLENGE_TTL_MS = 10 * 60 * 1000
const ACTIVE_LOCK_TTL_SEC = 20 * 60

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

function challengeKey(challenger: string, opponent: string): string {
  return `battle:challenge:${challenger}:${opponent}`
}

function inboxKey(username: string): string {
  return `battle:inbox:${username}`
}

function activeLockKey(username: string): string {
  return `battle:active:${username}`
}

async function clearActiveLock(username: string, expectedValue: string) {
  const key = activeLockKey(username)
  const current = await kv.get<string>(key)
  if (current === expectedValue) {
    await kv.del(key)
  }
}

function parseBattlePayload(raw: unknown): Record<string, unknown> | null {
  if (!raw) return null
  if (typeof raw === 'object') return raw as Record<string, unknown>
  if (typeof raw === 'string') {
    try {
      return JSON.parse(raw) as Record<string, unknown>
    } catch {
      return null
    }
  }
  return null
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    const challenger = String(body?.challenger || '').trim()
    const opponent = String(body?.opponent || '').trim()
    const token = String(body?.token || '').trim()

    if (!challenger || !opponent) {
      return NextResponse.json({ error: 'Missing challenger or opponent' }, { status: 400 })
    }
    if (challenger.toLowerCase() === opponent.toLowerCase()) {
      return NextResponse.json({ error: 'Cannot challenge yourself' }, { status: 400 })
    }

    const [challengerData, opponentData] = await Promise.all([
      kv.hgetall(`player:${challenger}`),
      kv.hgetall(`player:${opponent}`),
    ])

    if (!challengerData) {
      return NextResponse.json({ error: 'Challenger not on leaderboard' }, { status: 404 })
    }
    if (!opponentData) {
      return NextResponse.json({ error: 'Opponent not on leaderboard' }, { status: 404 })
    }
    const challengerOwnerToken = String((challengerData as Record<string, unknown>)?.ownerToken || '')
    if (challengerOwnerToken && token != challengerOwnerToken) {
      return NextResponse.json({ error: 'Invalid challenger token' }, { status: 403 })
    }

    const key = challengeKey(challenger, opponent)
    const existing = (await kv.hgetall(key)) as Partial<ChallengeRecord> | null
    const nowMs = Date.now()
    const existingExpiresMs = existing?.expiresAt ? Date.parse(existing.expiresAt) : 0
    const isExistingActive = existingExpiresMs > nowMs
    const existingBattle = parseBattlePayload(existing?.battlePayload)
    const [challengerLock, opponentLock] = await Promise.all([
      kv.get<string>(activeLockKey(challenger)),
      kv.get<string>(activeLockKey(opponent)),
    ])

    if (challengerLock && challengerLock !== key) {
      return NextResponse.json({ error: `${challenger} already has an active battle/challenge` }, { status: 409 })
    }
    if (opponentLock && opponentLock !== key) {
      return NextResponse.json({ error: `${opponent} is already in another battle/challenge` }, { status: 409 })
    }

    if (
      isExistingActive &&
      existing?.status === 'accepted' &&
      String((existingBattle as { status?: unknown } | null)?.status || '').toLowerCase() !== 'resolved'
    ) {
      return NextResponse.json({
        ok: true,
        status: 'accepted',
        challenger,
        opponent,
        expiresAt: existing?.expiresAt,
        battle: existingBattle,
      })
    }

    if (isExistingActive && existing?.status === 'pending') {
      return NextResponse.json({
        ok: true,
        status: 'pending',
        challenger,
        opponent,
        expiresAt: existing?.expiresAt,
      })
    }

    if (!isExistingActive && existing) {
      await Promise.all([
        kv.del(key),
        kv.zrem(inboxKey(opponent), challenger),
        clearActiveLock(challenger, key),
        clearActiveLock(opponent, key),
      ])
    }

    const createdAt = new Date(nowMs).toISOString()
    const expiresAt = new Date(nowMs + CHALLENGE_TTL_MS).toISOString()

    await Promise.all([
      kv.hset(key, {
        challenger,
        opponent,
        status: 'pending',
        createdAt,
        expiresAt,
        updatedAt: createdAt,
      }),
      kv.expire(key, 60 * 60 * 24),
      kv.zadd(inboxKey(opponent), { score: nowMs + CHALLENGE_TTL_MS, member: challenger }),
      kv.set(activeLockKey(challenger), key, { ex: ACTIVE_LOCK_TTL_SEC }),
      kv.set(activeLockKey(opponent), key, { ex: ACTIVE_LOCK_TTL_SEC }),
    ])

    return NextResponse.json({
      ok: true,
      status: 'pending',
      challenger,
      opponent,
      createdAt,
      expiresAt,
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
