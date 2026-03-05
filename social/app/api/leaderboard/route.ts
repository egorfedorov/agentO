import { NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

type LeaderboardPlayer = Record<string, unknown> & { username: string }

let lastSnapshot: LeaderboardPlayer[] = []
let lastSnapshotAt = 0

function fallbackResponse(reason: string) {
  const ageMs = lastSnapshotAt > 0 ? Date.now() - lastSnapshotAt : null
  return NextResponse.json({
    players: lastSnapshot,
    stale: true,
    staleReason: reason,
    staleAgeMs: ageMs,
  })
}

export async function GET() {
  const result: LeaderboardPlayer[] = []
  let hadLookupErrors = false

  try {
    const players = await kv.zrange<string[]>('leaderboard', 0, 99, { rev: true })

    for (const username of players) {
      try {
        const data = await kv.hgetall(`player:${username}`)
        if (data) {
          const { ownerToken, ...safeData } = data as Record<string, unknown>
          result.push({ username, ...safeData })
        }
      } catch {
        hadLookupErrors = true
      }
    }

    if (result.length === 0 && players.length > 0 && lastSnapshot.length > 0) {
      return fallbackResponse('empty-after-lookup')
    }

    if (result.length > 0 || players.length === 0) {
      lastSnapshot = result
      lastSnapshotAt = Date.now()
    }

    return NextResponse.json({
      players: result,
      stale: false,
      partial: hadLookupErrors,
    })
  } catch {
    if (lastSnapshot.length > 0) {
      return fallbackResponse('zrange-error')
    }
    return NextResponse.json({
      players: [],
      stale: true,
      staleReason: 'cold-start-error',
    })
  }
}
