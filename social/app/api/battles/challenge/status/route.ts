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

export async function GET(req: NextRequest) {
  try {
    const challenger = req.nextUrl.searchParams.get('challenger')?.trim() || ''
    const opponent = req.nextUrl.searchParams.get('opponent')?.trim() || ''
    const token = req.nextUrl.searchParams.get('token')?.trim() || ''

    if (!challenger || !opponent) {
      return NextResponse.json({ error: 'Missing challenger or opponent' }, { status: 400 })
    }

    const [challengerData, opponentData] = await Promise.all([
      kv.hgetall(`player:${challenger}`),
      kv.hgetall(`player:${opponent}`),
    ])
    const challengerToken = String((challengerData as Record<string, unknown> | null)?.ownerToken || '')
    const opponentToken = String((opponentData as Record<string, unknown> | null)?.ownerToken || '')
    if (challengerToken || opponentToken) {
      if (!token || (token !== challengerToken && token !== opponentToken)) {
        return NextResponse.json({ error: 'Invalid token' }, { status: 403 })
      }
    }

    const key = challengeKey(challenger, opponent)
    const challenge = (await kv.hgetall(key)) as Partial<ChallengeRecord> | null
    if (!challenge) {
      return NextResponse.json({ status: 'not_found' })
    }

    const expiresMs = challenge.expiresAt ? Date.parse(challenge.expiresAt) : 0
    if (challenge.status === 'pending' && expiresMs > 0 && expiresMs < Date.now()) {
      await Promise.all([
        kv.del(key),
        kv.zrem(inboxKey(opponent), challenger),
        clearActiveLock(challenger, key),
        clearActiveLock(opponent, key),
      ])
      return NextResponse.json({ status: 'expired' })
    }

    return NextResponse.json({
      status: challenge.status || 'pending',
      challenger,
      opponent,
      createdAt: challenge.createdAt,
      expiresAt: challenge.expiresAt,
      updatedAt: challenge.updatedAt,
      battle: parseBattlePayload(challenge.battlePayload),
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
