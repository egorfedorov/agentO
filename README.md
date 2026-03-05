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
  <a href="https://social-coral-five.vercel.app/">Leaderboard</a> &middot;
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

**Option 3: Download .app** from [Releases](https://github.com/egorfedorov/agentO/releases)
```bash
# After downloading, remove quarantine flag:
xattr -cr ~/Downloads/AgentO.app
# Then open AgentO.app
```

**Requirements:** macOS 12+, Swift (comes with Xcode Command Line Tools), Claude CLI or Codex CLI.

**Important command format:** all built-in commands use `/` prefix.
- Correct: `/update`, `/battle user`, `/rent publish 50 7 CyberCat`
- Incorrect: `update`, `!update`
- Friendly aliases supported: `/help all commands`, `/quests daily quests`
- Input box supports direct paste (Cmd+V / right-click Paste)

## New in v6.2.0

### Tactical PvP Duels
- Challenge flow is now explicit: invite -> accept/decline -> both submit move.
- Moves use zone strategy (`head`, `body`, `legs`) for both attack and defense.
- Commands:
  - `/battle <username>`
  - `/accept <username>` / `/decline <username>`
  - `/move <attackZone> <defenseZone>`

### Pet Marketplace (Rentals)
- Publish your pet as a rental listing directly from Agent-O.
- Rent other players' pets and track rental lifecycle/history.
- Commands:
  - `/market`
  - `/rent publish <pricePerDay> <maxDays> <title>`
  - `/rent take <owner> <days>`
  - `/rent my [owner|renter|both]`
  - `/rent end <rentalId>`
- Web landing:
  - Leaderboard: https://social-coral-five.vercel.app/
  - Marketplace: https://social-coral-five.vercel.app/marketplace

### Pet Training Loop
- New training dashboard and memory-training command for your pet.
- Commands:
  - `/training` — training quality dashboard
  - `/train <fact>` — train pet memory (+XP)
  - `/promptcoach [N]` — prompt quality coaching

### Landing & Docs Refresh
- Landing page now highlights tactical duels, marketplace rentals, and training.
- README includes slash-command rule and pre-release checks for `/update`.

## Features

### Guided Onboarding
- First launch walks you through: Feed → Play → Ask Claude
- Teaches core mechanics step by step
- Unlocks daily quests after completion

### Claude & Codex Integration
- Send prompts to **Claude CLI** or **Codex CLI** directly
- Real-time streaming output with syntax highlighting
- Clipboard analysis (`/paste`)
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

### Daily Quests
- 3 random quests each day (e.g., "Run 3 commands", "Win a battle", "Feed your pet")
- Bonus XP for completing all 3
- `/quests` to check progress

### Inventory
- Unlock items for milestones: crowns, halos, frames, badges, wings
- 10 collectible items tied to achievements and stats
- `/inventory` to browse your collection

### Mini-Games
- `/game` — Number guessing (1-100)
- `/trivia` — Dev trivia questions
- `/typing` — Typing speed test (WPM + accuracy)

### Pomodoro Timer
- `/pomo` — 25 min focus timer
- `/pomo10` — 10 min quick session
- `/break` — 5 min break
- +40 XP per completed pomodoro

### Instant Translation
- Type `EN текст` to translate to English
- Type `RU text` to translate to Russian
- **18 languages** supported: EN, RU, ES, FR, DE, IT, PT, JA, KO, ZH, AR, HI, TR, PL, NL, UK, CS, SV
- Translation auto-copied to clipboard
- Powered by Google Translate (no API key needed)

### Clipboard Watcher
- `/watch` — Agent-O monitors your clipboard every 2 seconds
- Auto-detects **code** and **errors/stack traces**
- Suggests `explain` for code, `fix` for errors
- `/unwatch` to stop

### Code Snippets
- `/save` — save the last Claude response as a snippet
- `/snippets` — browse all saved snippets
- `/search <query>` — fuzzy search through your knowledge base

### Share Card
- `/share` — export a beautiful SVG pet card to your Desktop
- Shows level, evolution stage, stats, achievements, streak
- Share on Twitter/Discord to flex your Agent-O

### Smart Dev Tools
- `/screenshot` — capture screen area and analyze with Claude
- `/diff` — send git diff to Claude for AI code review
- `/commit` — auto-generate commit message from staged changes
- `/ask <file>` — send any file to Claude for analysis

### Multiple Chats
- `/chat new` — start a fresh conversation
- `/chat list` — see all your chat sessions
- `/chat <N>` — switch between chats

### Auto-Commit Detection
- Agent-O monitors your git repo in the background
- Nudges you when you have 10+ uncommitted changes
- Suggests `/commit` to auto-generate a message

### Pet Brain (AI Intelligence)
- Pet gets **smarter as it levels up**
- **Lv.5+** — detects your languages & frameworks, adds context to prompts
- **Lv.10+** — remembers your preferences (`/teach I prefer tabs`)
- **Lv.15+** — tracks recent topics for continuity
- **Lv.20+** — full prompt engineering, expert-level assistance
- `/teach <fact>` — teach your pet something
- `/train <fact>` — training alias (+XP)
- `/training` — learning quality dashboard
- `/memory` — see what your pet knows
- `/brain` — export brain as JSON (share/sell/trade!)
- `/forget <fact>` — make pet forget

### Pet Marketplace (Rentals)
- `/market` — view pet rental market snapshot
- `/rent publish <pricePerDay> <maxDays> <title>` — list your pet
- `/rent take <owner> <days>` — rent someone else's pet
- `/rent my [owner|renter|both]` — show rental history
- `/rent end <rentalId>` — finish active rental (owner side)
- Web view: [Marketplace](https://social-coral-five.vercel.app/marketplace)

### Pet Battles
- `/battle <username>` — send challenge (battle starts only after accept)
- `/challenges` — show incoming challenges
- `/accept <username>` / `/decline <username>` — respond to challenge
- Stats comparison: Level, Food, Joy, Energy, Streak, Badges
- Power score with weighted randomness (skill + luck)
- Winner gets bonus XP, loser gets consolation XP
- Animated round-by-round battle sequence

### Leaderboard & Social
- `/name <username>` — set your display name
- `/leaderboard` — publish stats to [global leaderboard](https://social-coral-five.vercel.app/)
- Rankings by level, XP, streak, achievements
- Compete with other Agent-O users worldwide

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
| `/claude <p>` | Explicitly to Claude CLI |
| `/codex <p>` | Explicitly to Codex CLI |
| `/paste` | Analyze clipboard |
| `/feed` | Feed Agent-O (+Food) |
| `/play` | Play with Agent-O (+Joy) |
| `/rest` | Let Agent-O rest (+Energy) |
| `/stats` | Full pet stats |
| `/evo` | Evolution info |
| `/ach` | Achievements list |
| `/game` | Number guessing game |
| `/trivia` | Dev trivia quiz |
| `/dance` | Dance! |
| `/pomo` | 25 min pomodoro |
| `/pomo10` | 10 min pomodoro |
| `/break` | 5 min break |
| `/stoppomo` | Stop timer |
| `/skin <name>` | robot/cat/skull/clippy |
| `/theme <name>` | matrix/cyberpunk/sunset/ocean/hacker |
| `EN <text>` | Translate to English |
| `RU <text>` | Translate to Russian |
| `XX <text>` | Translate to any of 18 languages |
| `/watch` | Clipboard watcher on |
| `/unwatch` | Clipboard watcher off |
| `/save` | Save last response as snippet |
| `/snippets` | List saved snippets |
| `/search <q>` | Search snippets |
| `/share` | Export pet share card (SVG) |
| `/screenshot` | Capture & analyze screen area |
| `/diff` | AI code review of git changes |
| `/commit` | Auto-generate commit message |
| `/ask <file>` | Analyze a file with Claude |
| `/chat new` | Start new chat |
| `/chat list` | List all chats |
| `/chat <N>` | Switch to chat N |
| `/remind <t> <text>` | Set reminder (30m/2h) |
| `/reminders` | List active reminders |
| `/standup` | Daily standup from git |
| `/sh <desc>` | Natural language → shell |
| `/clipboard` | Clipboard history |
| `/calc <expr>` | Currency/unit/timezone calc |
| `/regex <desc>` | AI regex builder |
| `/daily` | Daily activity summary |
| `/training` | Pet training dashboard |
| `/train <fact>` | Train pet memory (+XP) |
| `/teach <fact>` | Teach your pet |
| `/memory` | What your pet knows |
| `/brain` | Export pet brain JSON |
| `/forget <fact>` | Make pet forget |
| `/name <name>` | Set leaderboard name |
| `/leaderboard` | Publish to leaderboard |
| `/market` | Marketplace snapshot |
| `/rent publish <price> <days> <title>` | Publish pet rental listing |
| `/rent take <owner> <days>` | Rent a pet |
| `/rent my [role]` | My rentals (owner/renter/both) |
| `/rent end <rentalId>` | Finish owner rental |
| `/battle <user>` | Battle another pet! |
| `/challenges` | Incoming battle challenges |
| `/accept <user>` | Accept battle challenge |
| `/decline <user>` | Decline battle challenge |
| `/battles` | Battle history |
| `/quests` | Daily quests |
| `/inventory` | Your items |
| `/typing` | Typing speed test |
| `/compact` | Minimal UI mode |
| `/full` | Full UI mode |
| `/update` | Check for updates |
| `/version` | Current version |
| `/git` | Git project status |
| `/ps` | Monitor processes |
| `/tip` | Random tip |
| `/history` | Command history |
| `/clear` | Clear output |
| `/help` | Help |

## Pre-Release Checklist

- Verify slash commands: `/version`, `/update`, `/leaderboard`, `/battle`, `/market`
- Run social build: `cd social && npm run build`
- Verify app command text/docs use `/update` (not `update` or `!update`)
- Publish social to Vercel and check:
  - `https://social-coral-five.vercel.app/`
  - `https://social-coral-five.vercel.app/marketplace`

## Tech

- **Language:** Swift 5
- **Framework:** AppKit (native macOS)
- **Binary size:** ~50KB
- **Dependencies:** 0
- **Persistence:** `~/.agento_pet.json`, `~/.agento_brain.json`

## License

MIT
