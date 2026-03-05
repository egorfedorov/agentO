import { NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

export async function GET() {
  try {
    const players = await kv.zrange('leaderboard', 0, 99, { rev: true })

    const result = []
    for (const username of players) {
      const data = await kv.hgetall(`player:${username}`)
      if (data) {
        result.push({ username, ...data })
      }
    }

    return NextResponse.json({ players: result })
  } catch (e) {
    // Fallback: return empty if KV not configured
    return NextResponse.json({ players: [] })
  }
}
