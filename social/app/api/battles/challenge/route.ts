import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

const CHALLENGE_TTL_MS = 10 * 60 * 1000

type ChallengeStatus = 'pending' | 'accepted' | 'declined'

interface ChallengeRecord {
  challenger: string
  opponent: string
  status: ChallengeStatus
  createdAt: string
  expiresAt: string
  updatedAt: string
}

function challengeKey(challenger: string, opponent: string): string {
  return `battle:challenge:${challenger}:${opponent}`
}

function inboxKey(username: string): string {
  return `battle:inbox:${username}`
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

    if (isExistingActive && existing?.status === 'accepted') {
      return NextResponse.json({
        ok: true,
        status: 'accepted',
        challenger,
        opponent,
        expiresAt: existing?.expiresAt,
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

    const createdAt = new Date(nowMs).toISOString()
    const expiresAt = new Date(nowMs + CHALLENGE_TTL_MS).toISOString()

    await kv.hset(key, {
      challenger,
      opponent,
      status: 'pending',
      createdAt,
      expiresAt,
      updatedAt: createdAt,
    })
    await kv.expire(key, 60 * 60 * 24)
    await kv.zadd(inboxKey(opponent), { score: nowMs + CHALLENGE_TTL_MS, member: challenger })

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
