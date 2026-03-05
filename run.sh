#!/bin/bash
# Agent-O: ASCII помощник для Claude/Codex CLI
# Сборка и запуск

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BIN="$DIR/agento"

echo "🔨 Компилирую Agent-O..."
swiftc "$DIR/AgentO.swift" \
    -framework AppKit \
    -framework Foundation \
    -o "$BIN" \
    -swift-version 5 \
    2>&1

echo "🚀 Запускаю Agent-O..."
"$BIN"
