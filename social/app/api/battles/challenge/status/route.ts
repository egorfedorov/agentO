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

export async function GET(req: NextRequest) {
  try {
    const challenger = req.nextUrl.searchParams.get('challenger')?.trim() || ''
    const opponent = req.nextUrl.searchParams.get('opponent')?.trim() || ''

    if (!challenger || !opponent) {
      return NextResponse.json({ error: 'Missing challenger or opponent' }, { status: 400 })
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

    return NextResponse.json({
      status: challenge.status || 'pending',
      challenger,
      opponent,
      createdAt: challenge.createdAt,
      expiresAt: challenge.expiresAt,
      updatedAt: challenge.updatedAt,
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
