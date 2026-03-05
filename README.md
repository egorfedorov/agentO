# Agent-O

**Your ASCII desktop companion for Claude CLI & Codex CLI.**

A native macOS floating Tamagotchi that helps you code, learns, evolves, and keeps you company. Zero dependencies — just Swift.

![Agent-O](https://img.shields.io/badge/macOS-12%2B-blue) ![Swift](https://img.shields.io/badge/Swift-5-orange) ![Dependencies](https://img.shields.io/badge/dependencies-0-green) ![License](https://img.shields.io/badge/license-MIT-purple)

```
   ╭─────────╮
   │  ◉   ◉  │
   │    ▽    │
   │  ╰───╯  │
   ╰────┬────╯
        │
   ╭────┴────╮
   │ AGENT-O │
   ╰─────────╯
      │   │
      ╵   ╵
```

## Quick Start

```bash
git clone https://github.com/user/agentO.git
cd agentO
./run.sh
```

**Requirements:** macOS 12+, Swift (comes with Xcode Command Line Tools), Claude CLI or Codex CLI.

## Features

### CLI Integration
- Send prompts to **Claude CLI** or **Codex CLI** directly
- Real-time streaming output with syntax highlighting
- Clipboard analysis (`!paste`)
- Drag & drop files for instant analysis

### Tamagotchi Pet
- **Food / Joy / Energy** stats that decay over time
- **XP & Levels** — every command earns XP
- **5 Evolution stages:** Baby → Evolved → Epic → Mythic → Cosmic
- **Daily streak** bonus XP
- Pet complains when hungry, sad, or tired
- Stats persist across sessions (`~/.agento_pet.json`)

### 23 Achievements
Unlock badges for milestones — first command, 100 commands, commits, streaks, mini-games, coding at night, and more. Each achievement = +30 XP.

### Mini-Games
- `!game` — Number guessing (1-100)
- `!trivia` — Dev trivia questions

### Pomodoro Timer
- `!pomo` — 25 min focus timer
- `!pomo10` — 10 min quick session
- `!break` — 5 min break
- +40 XP per completed pomodoro

### Customization
- **4 Skins:** Robot, Cat, Skull, Clippy
- **5 Themes:** Matrix, Cyberpunk, Sunset, Ocean, Hacker
- **8 Animation states:** idle, thinking, typing, happy, sleeping, error, dancing, eating

### UX
- **Cmd+Shift+O** — global hotkey to show/hide
- **Menu bar** icon with all actions
- **Minimizes** to tiny floating ASCII icon
- **Up/Down arrows** for command history
- **Git status** auto-detected in UI
- **Quick action buttons:** Commit, Tests, Explain, Review
- **macOS notifications** for achievements and pomodoro

## All Commands

| Command | Description |
|---------|-------------|
| `text` | Send to Claude |
| `!claude <p>` | Explicitly to Claude CLI |
| `!codex <p>` | Explicitly to Codex CLI |
| `!paste` | Analyze clipboard |
| `!feed` | Feed Agent-O (+Food) |
| `!play` | Play with Agent-O (+Joy) |
| `!rest` | Let Agent-O rest (+Energy) |
| `!stats` | Full pet stats |
| `!evo` | Evolution info |
| `!ach` | Achievements list |
| `!game` | Number guessing game |
| `!trivia` | Dev trivia quiz |
| `!dance` | Dance! |
| `!pomo` | 25 min pomodoro |
| `!pomo10` | 10 min pomodoro |
| `!break` | 5 min break |
| `!stoppomo` | Stop timer |
| `!skin <name>` | robot/cat/skull/clippy |
| `!theme <name>` | matrix/cyberpunk/sunset/ocean/hacker |
| `!git` | Git project status |
| `!ps` | Monitor processes |
| `!tip` | Random tip |
| `!history` | Command history |
| `!clear` | Clear output |
| `!help` | Help |

## Tech

- **Language:** Swift 5
- **Framework:** AppKit (native macOS)
- **Binary size:** ~50KB
- **Dependencies:** 0
- **Persistence:** JSON file at `~/.agento_pet.json`

## License

MIT
