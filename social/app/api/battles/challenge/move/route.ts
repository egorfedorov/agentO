import { NextRequest, NextResponse } from 'next/server'
import { kv } from '@vercel/kv'

export const dynamic = 'force-dynamic'

const ACTIVE_LOCK_TTL_SEC = 20 * 60

type ChallengeStatus = 'pending' | 'accepted' | 'declined'
type BattleStage = 'pick_phase' | 'resolved'
type HitZone = 'head' | 'body' | 'legs'

interface ChallengeRecord {
  challenger: string
  opponent: string
  status: ChallengeStatus
  createdAt: string
  expiresAt: string
  updatedAt: string
  battlePayload?: string
}

interface SideStats {
  username: string
  level: number
  hunger: number
  happiness: number
  energy: number
  streak: number
  achievements: number
  power: number
}

interface BattleMove {
  attack: HitZone
  defense: HitZone
  submittedAt: string
}

interface BattlePayload {
  id: string
  createdAt: string
  status: BattleStage
  challenger: SideStats
  opponent: SideStats
  challengerMove?: BattleMove
  opponentMove?: BattleMove
  challengerScore?: number
  opponentScore?: number
  winner?: string
  resolutionNote?: string
}

function challengeKey(challenger: string, opponent: string): string {
  return `battle:challenge:${challenger}:${opponent}`
}

function activeLockKey(username: string): string {
  return `battle:active:${username}`
}

function isZone(zone: string): zone is HitZone {
  return zone === 'head' || zone === 'body' || zone === 'legs'
}

function parseBattlePayload(raw: unknown): BattlePayload | null {
  if (!raw) return null
  if (typeof raw === 'object') return raw as BattlePayload
  if (typeof raw === 'string') {
    try {
      return JSON.parse(raw) as BattlePayload
    } catch {
      return null
    }
  }
  return null
}

function seededUnit(seed: string): number {
  let hash = 2166136261
  for (let i = 0; i < seed.length; i += 1) {
    hash ^= seed.charCodeAt(i)
    hash = Math.imul(hash, 16777619)
  }
  return (hash >>> 0) / 4294967295
}

function clamp(value: number, min: number, max: number): number {
  return Math.max(min, Math.min(max, value))
}

function computeScore(
  side: SideStats,
  opponent: SideStats,
  move: BattleMove,
  oppMove: BattleMove,
  seed: string,
): number {
  const attackWeight: Record<HitZone, number> = {
    head: 16,
    body: 12,
    legs: 10,
  }

  const base = clamp(Math.round(side.power / 150), 4, 24)
  const attackLanded = move.attack !== oppMove.defense
  const attackPoints = attackLanded ? attackWeight[move.attack] : 4
  const blockPoints = oppMove.attack === move.defense ? 11 : 0
  const counterBonus = attackLanded && oppMove.attack === move.defense ? 7 : 0
  const pressureBonus = side.level < opponent.level && attackLanded ? 2 : 0
  const luck = Math.round((seededUnit(seed) - 0.5) * 8)
  return clamp(base + attackPoints + blockPoints + counterBonus + pressureBonus + luck, 0, 99)
}

function resolveBattle(payload: BattlePayload): BattlePayload {
  if (!payload.challengerMove || !payload.opponentMove) return payload

  const seedBase = `${payload.id}|${payload.createdAt}`
  const challengerScore = computeScore(
    payload.challenger,
    payload.opponent,
    payload.challengerMove,
    payload.opponentMove,
    `${seedBase}|challenger`,
  )
  const opponentScore = computeScore(
    payload.opponent,
    payload.challenger,
    payload.opponentMove,
    payload.challengerMove,
    `${seedBase}|opponent`,
  )

  const scoreDelta = challengerScore - opponentScore
  const winner =
    Math.abs(scoreDelta) <= 2
      ? 'draw'
      : scoreDelta > 0
        ? payload.challenger.username
        : payload.opponent.username

  let resolutionNote = 'Both fighters traded clean hits.'
  if (payload.challengerMove.attack === payload.opponentMove.defense) {
    resolutionNote = `${payload.opponent.username} blocked a key hit.`
  }
  if (payload.opponentMove.attack === payload.challengerMove.defense) {
    resolutionNote = `${payload.challenger.username} defended at the right moment.`
  }
  if (
    payload.challengerMove.attack === payload.opponentMove.defense &&
    payload.opponentMove.attack === payload.challengerMove.defense
  ) {
    resolutionNote = 'Both players read each other perfectly.'
  }

  return {
    ...payload,
    status: 'resolved',
    challengerScore,
    opponentScore,
    winner,
    resolutionNote,
  }
}

async function clearActiveLock(username: string, expectedValue: string) {
  const key = activeLockKey(username)
  const current = await kv.get<string>(key)
  if (current === expectedValue) {
    await kv.del(key)
  }
}

async function pushBattleLog(payload: BattlePayload) {
  const entry = {
    id: payload.id,
    playerA: payload.challenger.username,
    playerB: payload.opponent.username,
    winner: payload.winner || 'draw',
    result:
      payload.winner === payload.challenger.username
        ? 'win'
        : payload.winner === payload.opponent.username
          ? 'loss'
          : 'draw',
    playerALevel: payload.challenger.level,
    playerBLevel: payload.opponent.level,
    playerAPower: payload.challenger.power,
    playerBPower: payload.opponent.power,
    playerAAttack: payload.challengerMove?.attack || null,
    playerADefense: payload.challengerMove?.defense || null,
    playerBAttack: payload.opponentMove?.attack || null,
    playerBDefense: payload.opponentMove?.defense || null,
    playerAScore: payload.challengerScore ?? 0,
    playerBScore: payload.opponentScore ?? 0,
    battleType: 'duel',
    createdAt: payload.createdAt,
  }
  const serialized = JSON.stringify(entry)
  await Promise.all([
    kv.lpush('battle:feed', serialized),
    kv.ltrim('battle:feed', 0, 199),
    kv.lpush(`battle:player:${payload.challenger.username}`, serialized),
    kv.ltrim(`battle:player:${payload.challenger.username}`, 0, 99),
    kv.lpush(`battle:player:${payload.opponent.username}`, serialized),
    kv.ltrim(`battle:player:${payload.opponent.username}`, 0, 99),
  ])
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json()
    const challenger = String(body?.challenger || '').trim()
    const opponent = String(body?.opponent || '').trim()
    const player = String(body?.player || '').trim()
    const token = String(body?.token || '').trim()
    const attack = String(body?.attack || '').trim().toLowerCase()
    const defense = String(body?.defense || '').trim().toLowerCase()

    if (!challenger || !opponent || !player || !attack || !defense) {
      return NextResponse.json({ error: 'Missing challenger/opponent/player/attack/defense' }, { status: 400 })
    }
    if (!isZone(attack) || !isZone(defense)) {
      return NextResponse.json({ error: 'Attack/defense must be one of: head, body, legs' }, { status: 400 })
    }
    if (player !== challenger && player !== opponent) {
      return NextResponse.json({ error: 'Player is not part of this battle' }, { status: 403 })
    }

    const [challengerData, opponentData] = (await Promise.all([
      kv.hgetall(`player:${challenger}`),
      kv.hgetall(`player:${opponent}`),
    ])) as [Record<string, unknown> | null, Record<string, unknown> | null]

    const actorData = player === challenger ? challengerData : opponentData
    if (!actorData) {
      return NextResponse.json({ error: 'Player not on leaderboard' }, { status: 404 })
    }
    const ownerToken = String(actorData.ownerToken || '')
    if (ownerToken && token !== ownerToken) {
      return NextResponse.json({ error: 'Invalid player token' }, { status: 403 })
    }

    const key = challengeKey(challenger, opponent)
    const challenge = (await kv.hgetall(key)) as Partial<ChallengeRecord> | null
    if (!challenge) {
      return NextResponse.json({ status: 'not_found' })
    }
    if (challenge.status !== 'accepted') {
      return NextResponse.json({ status: challenge.status || 'pending' })
    }

    const battlePayload = parseBattlePayload(challenge.battlePayload)
    if (!battlePayload) {
      return NextResponse.json({ error: 'Battle payload missing. Re-accept challenge.' }, { status: 409 })
    }
    if (battlePayload.status === 'resolved') {
      return NextResponse.json({ ok: true, status: 'accepted', battle: battlePayload, moveStatus: 'already_resolved' })
    }

    const move: BattleMove = {
      attack,
      defense,
      submittedAt: new Date().toISOString(),
    }

    let updatedBattle: BattlePayload = { ...battlePayload }
    if (player === challenger) {
      if (updatedBattle.challengerMove) {
        return NextResponse.json({
          ok: true,
          status: 'accepted',
          battle: updatedBattle,
          moveStatus: 'already_submitted',
        })
      }
      updatedBattle.challengerMove = move
    } else {
      if (updatedBattle.opponentMove) {
        return NextResponse.json({
          ok: true,
          status: 'accepted',
          battle: updatedBattle,
          moveStatus: 'already_submitted',
        })
      }
      updatedBattle.opponentMove = move
    }

    let shouldLogResult = false
    if (updatedBattle.challengerMove && updatedBattle.opponentMove) {
      updatedBattle = resolveBattle(updatedBattle)
      shouldLogResult = updatedBattle.status === 'resolved'
    }

    await Promise.all([
      kv.hset(key, {
        updatedAt: new Date().toISOString(),
        battlePayload: JSON.stringify(updatedBattle),
      }),
      kv.expire(key, 60 * 60 * 24),
      kv.set(activeLockKey(challenger), key, { ex: ACTIVE_LOCK_TTL_SEC }),
      kv.set(activeLockKey(opponent), key, { ex: ACTIVE_LOCK_TTL_SEC }),
      ...(shouldLogResult ? [pushBattleLog(updatedBattle)] : []),
    ])

    if (shouldLogResult) {
      await Promise.all([clearActiveLock(challenger, key), clearActiveLock(opponent, key)])
    }

    return NextResponse.json({
      ok: true,
      status: 'accepted',
      battle: updatedBattle,
      moveStatus: shouldLogResult ? 'resolved' : 'submitted',
    })
  } catch {
    return NextResponse.json({ error: 'Server error' }, { status: 500 })
  }
}
