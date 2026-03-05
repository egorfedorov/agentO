import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

interface BattleLogPayload {
  playerA: string
  playerB: string
  token?: string
  winner: string
  result?: string
  playerALevel?: number
  playerBLevel?: number
  playerAPower?: number
  playerBPower?: number
  playerAAttack?: string
  playerADefense?: string
  playerBAttack?: string
  playerBDefense?: string
  playerAScore?: number
  playerBScore?: number
  battleType?: string
  createdAt?: string
}

export async function POST(req: NextRequest) {
  try {
    const body = (await req.json()) as BattleLogPayload
    const playerA = String(body?.playerA || '').trim()
    const playerB = String(body?.playerB || '').trim()
    const token = String(body?.token || '').trim()
    const winner = String(body?.winner || '').trim()

    if (!playerA || !playerB || !winner) {
      return NextResponse.json({ error: 'Missing required battle fields' }, { status: 400 })
    }

    const playerAData = (await kv.hgetall(`player:${playerA}`)) as Record<string, unknown> | null
    if (!playerAData) {
      return NextResponse.json({ error: 'PlayerA not on leaderboard' }, { status: 404 })
    }
    const ownerToken = String(playerAData.ownerToken || '')
    if (ownerToken && token != ownerToken) {
      return NextResponse.json({ error: 'Invalid player token' }, { status: 403 })
    }

    const createdAt = body.createdAt || new Date().toISOString()
    const id = `battle_${Date.now()}_${Math.random().toString(36).slice(2, 8)}`
    const entry = {
      id,
      playerA,
      playerB,
      winner,
      result: body.result || 'draw',
      playerALevel: body.playerALevel || 0,
      playerBLevel: body.playerBLevel || 0,
      playerAPower: body.playerAPower || 0,
      playerBPower: body.playerBPower || 0,
      playerAAttack: body.playerAAttack || null,
      playerADefense: body.playerADefense || null,
      playerBAttack: body.playerBAttack || null,
      playerBDefense: body.playerBDefense || null,
      playerAScore: body.playerAScore || 0,
      playerBScore: body.playerBScore || 0,
      battleType: body.battleType || 'power',
      createdAt,
    }
    const serialized = JSON.stringify(entry)

    await Promise.all([
      kv.lpush('battle:feed', serialized),
      kv.ltrim('battle:feed', 0, 199),
      kv.lpush(`battle:player:${playerA}`, serialized),
      kv.ltrim(`battle:player:${playerA}`, 0, 99),
      kv.lpush(`battle:player:${playerB}`, serialized),
      kv.ltrim(`battle:player:${playerB}`, 0, 99),
    ])

    return NextResponse.json({ ok: true, id })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
