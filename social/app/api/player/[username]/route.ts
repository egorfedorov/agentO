import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export async function GET(
  req: NextRequest,
  { params }: { params: { username: string } }
) {
  try {
    const { username } = params
    const data = await kv.hgetall(`player:${username}`)

    if (!data) {
      return NextResponse.json({ error: 'Player not found' }, { status: 404 })
    }

    const score = await kv.zscore('leaderboard', username)
    const rank = await kv.zrevrank('leaderboard', username)

    const { ownerToken, ...safeData } = (data || {}) as Record<string, unknown>

    return NextResponse.json({
      username,
      ...safeData,
      score: score || 0,
      rank: rank !== null ? rank + 1 : -1,
    })
  } catch (e) {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
