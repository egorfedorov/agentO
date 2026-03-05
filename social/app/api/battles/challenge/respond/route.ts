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
    const accepted = Boolean(body?.accepted)
    const token = String(body?.token || '').trim()

    if (!challenger || !opponent) {
      return NextResponse.json({ error: 'Missing challenger or opponent' }, { status: 400 })
    }

    const opponentData = (await kv.hgetall(`player:${opponent}`)) as Record<string, unknown> | null
    if (!opponentData) {
      return NextResponse.json({ error: 'Opponent not on leaderboard' }, { status: 404 })
    }
    const opponentOwnerToken = String(opponentData.ownerToken || '')
    if (opponentOwnerToken && token != opponentOwnerToken) {
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
      })
    }

    const status: ChallengeStatus = accepted ? 'accepted' : 'declined'
    const updatedAt = new Date().toISOString()
    await Promise.all([
      kv.hset(key, { status, updatedAt }),
      kv.expire(key, 60 * 60 * 24),
      kv.zrem(inboxKey(opponent), challenger),
    ])

    return NextResponse.json({
      ok: true,
      status,
      challenger,
      opponent,
      updatedAt,
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
