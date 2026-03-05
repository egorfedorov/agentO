import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

interface BattleEntry {
  id: string
  playerA: string
  playerB: string
  winner: string
  result: string
  playerALevel: number
  playerBLevel: number
  playerAPower: number
  playerBPower: number
  playerAAttack?: string | null
  playerADefense?: string | null
  playerBAttack?: string | null
  playerBDefense?: string | null
  playerAScore?: number
  playerBScore?: number
  battleType?: string
  createdAt: string
}

function parseEntry(raw: unknown): BattleEntry | null {
  if (!raw) return null
  if (typeof raw === 'string') {
    try {
      return JSON.parse(raw) as BattleEntry
    } catch {
      return null
    }
  }
  if (typeof raw === 'object') {
    return raw as BattleEntry
  }
  return null
}

export async function GET(req: NextRequest) {
  try {
    const player = req.nextUrl.searchParams.get('player')?.trim() || ''
    const limitRaw = Number(req.nextUrl.searchParams.get('limit') || '20')
    const limit = Number.isFinite(limitRaw) ? Math.max(1, Math.min(100, limitRaw)) : 20
    const key = player ? `battle:player:${player}` : 'battle:feed'
    const rawEntries = await kv.lrange(key, 0, limit - 1)
    const battles = (rawEntries as unknown[]).map(parseEntry).filter((e): e is BattleEntry => Boolean(e))

    return NextResponse.json({ battles })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
