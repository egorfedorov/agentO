# Agent-O

<p align="center">
  <img src="assets/agent-o-banner.svg" alt="Agent-O Banner" width="800"/>
</p>

<p align="center">
  <strong>Your ASCII desktop companion for Claude CLI & Codex CLI.</strong><br>
  A native macOS floating Tamagotchi that helps you code, learns, evolves, and keeps you company.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-12%2B-blue?style=flat-square" alt="macOS">
  <img src="https://img.shields.io/badge/Swift-5-orange?style=flat-square" alt="Swift">
  <img src="https://img.shields.io/badge/dependencies-0-green?style=flat-square" alt="Dependencies">
  <img src="https://img.shields.io/badge/binary-~50KB-cyan?style=flat-square" alt="Binary Size">
  <img src="https://img.shields.io/badge/license-MIT-purple?style=flat-square" alt="License">
</p>

<p align="center">
  <a href="https://egorfedorov.github.io/agentO/">Website</a> &middot;
  <a href="#quick-start">Quick Start</a> &middot;
  <a href="#features">Features</a> &middot;
  <a href="#all-commands">Commands</a>
</p>

---

<p align="center">
  <img src="assets/demo.svg" alt="Agent-O Demo" width="800"/>
</p>

---

## Quick Start

**Option 1: Clone & Run**
```bash
git clone https://github.com/egorfedorov/agentO.git
cd agentO
./run.sh
```

**Option 2: Homebrew** *(coming soon)*
```bash
brew tap egorfedorov/agentO
brew install agento
agento
```

**Requirements:** macOS 12+, Swift (comes with Xcode Command Line Tools), Claude CLI or Codex CLI.

## Features

### Claude & Codex Integration
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

### Instant Translation
- Type `EN текст` to translate to English
- Type `RU text` to translate to Russian
- **18 languages** supported: EN, RU, ES, FR, DE, IT, PT, JA, KO, ZH, AR, HI, TR, PL, NL, UK, CS, SV
- Translation auto-copied to clipboard
- Powered by Google Translate (no API key needed)

### Clipboard Watcher
- `!watch` — Agent-O monitors your clipboard every 2 seconds
- Auto-detects **code** and **errors/stack traces**
- Suggests `explain` for code, `fix` for errors
- `!unwatch` to stop

### Code Snippets
- `!save` — save the last Claude response as a snippet
- `!snippets` — browse all saved snippets
- `!search <query>` — fuzzy search through your knowledge base

### Share Card
- `!share` — export a beautiful SVG pet card to your Desktop
- Shows level, evolution stage, stats, achievements, streak
- Share on Twitter/Discord to flex your Agent-O

### Smart Dev Tools
- `!screenshot` — capture screen area and analyze with Claude
- `!diff` — send git diff to Claude for AI code review
- `!commit` — auto-generate commit message from staged changes
- `!ask <file>` — send any file to Claude for analysis

### Multiple Chats
- `!chat new` — start a fresh conversation
- `!chat list` — see all your chat sessions
- `!chat <N>` — switch between chats

### Auto-Commit Detection
- Agent-O monitors your git repo in the background
- Nudges you when you have 10+ uncommitted changes
- Suggests `!commit` to auto-generate a message

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
| `EN <text>` | Translate to English |
| `RU <text>` | Translate to Russian |
| `XX <text>` | Translate to any of 18 languages |
| `!watch` | Clipboard watcher on |
| `!unwatch` | Clipboard watcher off |
| `!save` | Save last response as snippet |
| `!snippets` | List saved snippets |
| `!search <q>` | Search snippets |
| `!share` | Export pet share card (SVG) |
| `!screenshot` | Capture & analyze screen area |
| `!diff` | AI code review of git changes |
| `!commit` | Auto-generate commit message |
| `!ask <file>` | Analyze a file with Claude |
| `!chat new` | Start new chat |
| `!chat list` | List all chats |
| `!chat <N>` | Switch to chat N |
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
