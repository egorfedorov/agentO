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

export async function GET(req: NextRequest) {
  try {
    const username = req.nextUrl.searchParams.get('username')?.trim() || ''
    const token = req.nextUrl.searchParams.get('token')?.trim() || ''
    if (!username) {
      return NextResponse.json({ error: 'Missing username' }, { status: 400 })
    }
    const playerData = (await kv.hgetall(`player:${username}`)) as Record<string, unknown> | null
    if (!playerData) {
      return NextResponse.json({ error: 'Player not found' }, { status: 404 })
    }
    const ownerToken = String(playerData.ownerToken || '')
    if (ownerToken && token != ownerToken) {
      return NextResponse.json({ error: 'Invalid player token' }, { status: 403 })
    }

    const challengers = await kv.zrange<string[]>(inboxKey(username), 0, 49)
    const nowMs = Date.now()
    const challenges: Array<{ challenger: string; createdAt?: string; expiresAt?: string }> = []

    for (const challenger of challengers) {
      const challenge = (await kv.hgetall(challengeKey(challenger, username))) as Partial<ChallengeRecord> | null
      if (!challenge || challenge.status !== 'pending') {
        await kv.zrem(inboxKey(username), challenger)
        const expectedChallengeKey = challengeKey(challenger, username)
        await Promise.all([
          clearActiveLock(challenger, expectedChallengeKey),
          clearActiveLock(username, expectedChallengeKey),
        ])
        continue
      }

      const expiresMs = challenge.expiresAt ? Date.parse(challenge.expiresAt) : 0
      if (expiresMs > 0 && expiresMs < nowMs) {
        const expectedChallengeKey = challengeKey(challenger, username)
        await Promise.all([
          kv.zrem(inboxKey(username), challenger),
          kv.del(expectedChallengeKey),
          clearActiveLock(challenger, expectedChallengeKey),
          clearActiveLock(username, expectedChallengeKey),
        ])
        continue
      }

      challenges.push({
        challenger,
        createdAt: challenge.createdAt,
        expiresAt: challenge.expiresAt,
      })
    }

    return NextResponse.json({ challenges })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
