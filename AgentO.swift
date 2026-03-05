import AppKit
import Foundation
import Carbon.HIToolbox

// MARK: - Skins

enum AgentSkin: String, CaseIterable {
    case robot = "Robot"
    case cat = "Cat"
    case skull = "Skull"
    case clippy = "Clippy"

    var idle: [[String]] {
        switch self {
        case .robot: return [AgentArt.Robot.idle1, AgentArt.Robot.idle2]
        case .cat: return [AgentArt.Cat.idle1, AgentArt.Cat.idle2]
        case .skull: return [AgentArt.Skull.idle1, AgentArt.Skull.idle2]
        case .clippy: return [AgentArt.Clippy.idle1, AgentArt.Clippy.idle2]
        }
    }
    var thinking: [[String]] { // returns array of frame-lines
        switch self {
        case .robot: return [AgentArt.Robot.think1, AgentArt.Robot.think2]
        case .cat: return [AgentArt.Cat.think1, AgentArt.Cat.think2]
        case .skull: return [AgentArt.Skull.think1, AgentArt.Skull.think2]
        case .clippy: return [AgentArt.Clippy.think1, AgentArt.Clippy.think2]
        }
    }
    var happy: [String] {
        switch self {
        case .robot: return AgentArt.Robot.happy
        case .cat: return AgentArt.Cat.happy
        case .skull: return AgentArt.Skull.happy
        case .clippy: return AgentArt.Clippy.happy
        }
    }
    var sleeping: [[String]] {
        switch self {
        case .robot: return [AgentArt.Robot.sleep1, AgentArt.Robot.sleep2]
        case .cat: return [AgentArt.Cat.sleep1, AgentArt.Cat.sleep2]
        case .skull: return [AgentArt.Skull.sleep1, AgentArt.Skull.sleep2]
        case .clippy: return [AgentArt.Clippy.sleep1, AgentArt.Clippy.sleep2]
        }
    }
    var error: [String] {
        switch self {
        case .robot: return AgentArt.Robot.error
        case .cat: return AgentArt.Cat.error
        case .skull: return AgentArt.Skull.error
        case .clippy: return AgentArt.Clippy.error
        }
    }
    var typing: [[String]] {
        switch self {
        case .robot: return [AgentArt.Robot.type1, AgentArt.Robot.type2]
        case .cat: return [AgentArt.Cat.type1, AgentArt.Cat.type2]
        case .skull: return [AgentArt.Skull.type1, AgentArt.Skull.type2]
        case .clippy: return [AgentArt.Clippy.type1, AgentArt.Clippy.type2]
        }
    }
    var dance: [[String]] {
        switch self {
        case .robot: return [AgentArt.Robot.dance1, AgentArt.Robot.dance2, AgentArt.Robot.dance3]
        case .cat: return [AgentArt.Cat.dance1, AgentArt.Cat.dance2, AgentArt.Cat.dance3]
        case .skull: return [AgentArt.Skull.dance1, AgentArt.Skull.dance2, AgentArt.Skull.dance3]
        case .clippy: return [AgentArt.Clippy.dance1, AgentArt.Clippy.dance2, AgentArt.Clippy.dance3]
        }
    }
    var mini: String {
        switch self {
        case .robot: return "[◉‿◉]"
        case .cat: return "[=^.^=]"
        case .skull: return "[☠]"
        case .clippy: return "[📎]"
        }
    }
}

// MARK: - ASCII Art Library

struct AgentArt {
    struct Robot {
        static let idle1 = [
            "   ╭─────────╮   ",
            "   │  ◉   ◉  │   ",
            "   │    ▽    │   ",
            "   │  ╰───╯  │   ",
            "   ╰────┬────╯   ",
            "        │        ",
            "   ╭────┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let idle2 = [
            "   ╭─────────╮   ",
            "   │  ◉   ◉  │   ",
            "   │    ▽    │   ",
            "   │  ╰───╯  │   ",
            "   ╰────┬────╯   ",
            "        │        ",
            "   ╭────┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      ╵   │      ",
            "      │   ╵      ",
        ]
        static let think1 = [
            "   ╭─────────╮   ",
            "   │  ◑   ◑  │   ",
            "   │    ▽    │   ",
            "   │  ╰~~~╯  │   ",
            "   ╰────┬────╯   ",
            "   ○    │        ",
            "  ○╭────┴────╮   ",
            " ○ │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let think2 = [
            "   ╭─────────╮   ",
            "   │  ◑   ◑  │   ",
            "   │    ▽    │   ",
            "   │  ╰~~~╯  │   ",
            "   ╰────┬────╯   ",
            "    ○   │        ",
            "   ○────┴────╮   ",
            "  ○│ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let happy = [
            "   ╭─────────╮   ",
            "   │  ◉   ◉  │   ",
            "   │    ▽    │   ",
            "   │  ╰▽▽▽╯  │   ",
            "   ╰────┬────╯   ",
            "   \\    │   /   ",
            "   ╭────┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let sleep1 = [
            "   ╭─────────╮   ",
            "   │  ─   ─  │ z ",
            "   │    ▽    │z  ",
            "   │  ╰───╯  │   ",
            "   ╰────┬────╯   ",
            "        │        ",
            "   ╭────┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let sleep2 = [
            "   ╭─────────╮ Z ",
            "   │  ─   ─  │   ",
            "   │    ▽    │ z ",
            "   │  ╰───╯  │   ",
            "   ╰────┬────╯   ",
            "        │        ",
            "   ╭────┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let error = [
            "   ╭─────────╮   ",
            "   │  ✖   ✖  │   ",
            "   │    ▽    │   ",
            "   │  ╰═══╯  │   ",
            "   ╰────┬────╯   ",
            "    !   │   !    ",
            "   ╭────┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let type1 = [
            "   ╭─────────╮   ",
            "   │  ◉   ◉  │   ",
            "   │    ▽    │   ",
            "   │  ╰───╯  │   ",
            "   ╰────┬────╯   ",
            "     ╲  │        ",
            "   ╭──╲─┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "    ⌨️  │   │      ",
            "      ╵   ╵      ",
        ]
        static let type2 = [
            "   ╭─────────╮   ",
            "   │  ◉   ◉  │   ",
            "   │    ▽    │   ",
            "   │  ╰───╯  │   ",
            "   ╰────┬────╯   ",
            "        │  ╱     ",
            "   ╭────┴╱──╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   ⌨️      ",
            "      ╵   ╵      ",
        ]
        static let dance1 = [
            "   ╭─────────╮   ",
            "   │  ◉   ◉  │   ",
            "   │    ▽    │   ",
            "   │  ╰▽▽▽╯  │   ",
            "   ╰────┬────╯   ",
            "   ╱    │        ",
            "  ╱╭────┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "     ╱│   │      ",
            "    ╱ ╵   ╵      ",
        ]
        static let dance2 = [
            "   ╭─────────╮   ",
            "   │  ◉   ◉  │   ",
            "   │    ▽    │   ",
            "   │  ╰▽▽▽╯  │   ",
            "   ╰────┬────╯   ",
            "        │    ╲   ",
            "   ╭────┴────╮╲  ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "      │   │╲     ",
            "      ╵   ╵ ╲    ",
        ]
        static let dance3 = [
            "   ╭─────────╮   ",
            "   │  ◉   ◉  │   ",
            "   │    ▽    │   ",
            "   │  ╰▽▽▽╯  │   ",
            "   ╰────┬────╯   ",
            "   \\    │   /   ",
            "   ╭────┴────╮   ",
            "   │ AGENT-O │   ",
            "   ╰─────────╯   ",
            "     /│   │\\     ",
            "    / ╵   ╵ \\    ",
        ]
    }

    struct Cat {
        static let idle1 = [
            "    /\\_____/\\    ",
            "   /  ◉   ◉  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰───╯  /   ",
            "    \\_______/    ",
            "     |     |     ",
            "    ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ||     ",
            "     ╰╯ ╰─╯     ",
        ]
        static let idle2 = [
            "    /\\_____/\\    ",
            "   /  ◉   ◉  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰───╯  /   ",
            "    \\_______/    ",
            "     |     |     ",
            "    ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     |│   ||     ",
            "     ╰╯   ╰╯~   ",
        ]
        static let think1 = [
            "    /\\_____/\\    ",
            "   /  ◑   ◑  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰~~~╯  /   ",
            "    \\_______/ ○  ",
            "     |     | ○   ",
            "    ╭┴─────┴╮○   ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ||     ",
            "     ╰╯ ╰─╯     ",
        ]
        static let think2 = [
            "    /\\_____/\\    ",
            "   /  ◑   ◑  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰~~~╯  / ○",
            "    \\_______/  ○ ",
            "     |     |  ○  ",
            "    ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ||     ",
            "     ╰╯ ╰─╯     ",
        ]
        static let happy = [
            "    /\\_____/\\    ",
            "   /  ^   ^  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰▽▽▽╯  /   ",
            "    \\_______/    ",
            "    \\|     |/    ",
            "    ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ||     ",
            "     ╰╯ ╰─╯     ",
        ]
        static let sleep1 = [
            "    /\\_____/\\  z ",
            "   /  ─   ─  \\ z ",
            "  (     ▼     )  ",
            "   \\  ╰───╯  /   ",
            "    \\_______/    ",
            "     |     |     ",
            "    ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ||     ",
            "     ╰╯ ╰─╯     ",
        ]
        static let sleep2 = [
            "    /\\_____/\\ Z  ",
            "   /  ─   ─  \\   ",
            "  (     ▼     )z ",
            "   \\  ╰───╯  /   ",
            "    \\_______/    ",
            "     |     |     ",
            "    ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ||     ",
            "     ╰╯ ╰─╯     ",
        ]
        static let error = [
            "    /\\_____/\\    ",
            "   /  ✖   ✖  \\   ",
            "  (     ▼     )  ",
            "   \\  >═══<  /   ",
            "    \\_______/    ",
            "   ! |     | !   ",
            "    ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ||     ",
            "     ╰╯ ╰─╯     ",
        ]
        static let type1 = [
            "    /\\_____/\\    ",
            "   /  ◉   ◉  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰───╯  /   ",
            "    \\_______/    ",
            "     \\ |   |     ",
            "    ╭─\\────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "    ⌨  | | ||    ",
            "     ╰╯ ╰─╯     ",
        ]
        static let type2 = [
            "    /\\_____/\\    ",
            "   /  ◉   ◉  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰───╯  /   ",
            "    \\_______/    ",
            "     |   | /     ",
            "    ╭┴───/─╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ⌨     ",
            "     ╰╯ ╰─╯     ",
        ]
        static let dance1 = [
            "    /\\_____/\\    ",
            "   /  ^   ^  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰▽▽▽╯  /   ",
            "    \\_______/    ",
            "   / |     |     ",
            "  / ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "    /|| | ||     ",
            "   / ╰╯ ╰─╯     ",
        ]
        static let dance2 = [
            "    /\\_____/\\    ",
            "   /  ^   ^  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰▽▽▽╯  /   ",
            "    \\_______/    ",
            "     |     | \\   ",
            "    ╭┴─────┴╮ \\  ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "     || | ||\\    ",
            "     ╰╯ ╰─╯ \\   ",
        ]
        static let dance3 = [
            "    /\\_____/\\    ",
            "   /  ^   ^  \\   ",
            "  (     ▼     )  ",
            "   \\  ╰▽▽▽╯  /   ",
            "    \\_______/    ",
            "    \\|     |/    ",
            "    ╭┴─────┴╮    ",
            "    │ MEOW-O│    ",
            "    ╰───────╯    ",
            "    /|| | ||\\    ",
            "   / ╰╯ ╰─╯ \\   ",
        ]
    }

    struct Skull {
        static let idle1 = [
            "     ╭───────╮   ",
            "    ╱ ◉     ◉ ╲  ",
            "   │    ▼▼    │  ",
            "   │  ┬┬┬┬┬┬  │  ",
            "    ╲_________╱  ",
            "        │        ",
            "   ╭────┴────╮   ",
            "   │ SKULL-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let idle2 = [
            "     ╭───────╮   ",
            "    ╱ ◉     ◉ ╲  ",
            "   │    ▼▼    │  ",
            "   │  ┬┬┬┬┬┬  │  ",
            "    ╲_________╱  ",
            "        │        ",
            "   ╭────┴────╮   ",
            "   │ SKULL-O │   ",
            "   ╰─────────╯   ",
            "      ╵   │      ",
            "      │   ╵      ",
        ]
        static let think1 = [
            "     ╭───────╮   ",
            "    ╱ ◑     ◑ ╲  ",
            "   │    ▼▼    │  ",
            "   │  ┬┬┬┬┬┬  │  ",
            "    ╲_________╱○ ",
            "        │     ○  ",
            "   ╭────┴────╮○  ",
            "   │ SKULL-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let think2 = [
            "     ╭───────╮   ",
            "    ╱ ◑     ◑ ╲ ○",
            "   │    ▼▼    │○ ",
            "   │  ┬┬┬┬┬┬  │  ",
            "    ╲_________╱  ",
            "        │     ○  ",
            "   ╭────┴────╮   ",
            "   │ SKULL-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let happy = [
            "     ╭───────╮   ",
            "    ╱ ◉     ◉ ╲  ",
            "   │    ▼▼    │  ",
            "   │  ╰▽▽▽▽╯  │  ",
            "    ╲_________╱  ",
            "   \\    │    /   ",
            "   ╭────┴────╮   ",
            "   │ SKULL-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let sleep1 = [
            "     ╭───────╮ z ",
            "    ╱ ─     ─ ╲z ",
            "   │    ▼▼    │  ",
            "   │  ┬┬┬┬┬┬  │  ",
            "    ╲_________╱  ",
            "        │        ",
            "   ╭────┴────╮   ",
            "   │ SKULL-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let sleep2 = [
            "     ╭───────╮Z  ",
            "    ╱ ─     ─ ╲  ",
            "   │    ▼▼    │z ",
            "   │  ┬┬┬┬┬┬  │  ",
            "    ╲_________╱  ",
            "        │        ",
            "   ╭────┴────╮   ",
            "   │ SKULL-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let error = [
            "     ╭───────╮   ",
            "    ╱ ✖     ✖ ╲  ",
            "   │    ▼▼    │  ",
            "   │  ════════ │  ",
            "    ╲_________╱  ",
            "    !   │   !    ",
            "   ╭────┴────╮   ",
            "   │ SKULL-O │   ",
            "   ╰─────────╯   ",
            "      │   │      ",
            "      ╵   ╵      ",
        ]
        static let type1 = Robot.type1
        static let type2 = Robot.type2
        static let dance1 = Robot.dance1
        static let dance2 = Robot.dance2
        static let dance3 = Robot.dance3
    }

    struct Clippy {
        static let idle1 = [
            "    ╭───╮        ",
            "    │ ● │        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ╭─┴─╮        ",
            "    │◉ ◉│        ",
            "    │ ▽ │        ",
            "    │╰─╯│        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ──┴──        ",
        ]
        static let idle2 = [
            "    ╭───╮        ",
            "    │ ● │        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ╭─┴─╮        ",
            "    │◉ ◉│        ",
            "    │ ▽ │        ",
            "    │╰─╯│        ",
            "    ╰─┬─╯        ",
            "     ╱            ",
            "    ──┴──        ",
        ]
        static let think1 = [
            "    ╭───╮        ",
            "    │ ● │  ○     ",
            "    ╰─┬─╯ ○      ",
            "      │  ○       ",
            "    ╭─┴─╮        ",
            "    │◑ ◑│        ",
            "    │ ▽ │        ",
            "    │╰~╯│        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ──┴──        ",
        ]
        static let think2 = [
            "    ╭───╮ ○      ",
            "    │ ● │○       ",
            "    ╰─┬─╯        ",
            "      │ ○        ",
            "    ╭─┴─╮        ",
            "    │◑ ◑│        ",
            "    │ ▽ │        ",
            "    │╰~╯│        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ──┴──        ",
        ]
        static let happy = [
            "    ╭───╮        ",
            "    │ ● │        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ╭─┴─╮        ",
            "    │^ ^│        ",
            "    │ ▽ │        ",
            "    │╰▽╯│        ",
            "    ╰─┬─╯        ",
            "     \\│/         ",
            "    ──┴──        ",
        ]
        static let sleep1 = [
            "    ╭───╮   z    ",
            "    │ ● │  z     ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ╭─┴─╮        ",
            "    │─ ─│        ",
            "    │ ▽ │        ",
            "    │╰─╯│        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ──┴──        ",
        ]
        static let sleep2 = [
            "    ╭───╮  Z     ",
            "    │ ● │        ",
            "    ╰─┬─╯  z    ",
            "      │          ",
            "    ╭─┴─╮        ",
            "    │─ ─│        ",
            "    │ ▽ │        ",
            "    │╰─╯│        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ──┴──        ",
        ]
        static let error = [
            "    ╭───╮        ",
            "    │ ● │  !     ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ╭─┴─╮        ",
            "    │✖ ✖│        ",
            "    │ ▽ │        ",
            "    │╰═╯│        ",
            "    ╰─┬─╯        ",
            "      │          ",
            "    ──┴──        ",
        ]
        static let type1 = idle1
        static let type2 = idle2
        static let dance1 = [
            "    ╭───╮        ",
            "    │ ● │        ",
            "    ╰─┬─╯        ",
            "     ╱           ",
            "    ╭─┴─╮        ",
            "    │^ ^│        ",
            "    │ ▽ │        ",
            "    │╰▽╯│        ",
            "    ╰─┬─╯        ",
            "     ╱           ",
            "    ──┴──        ",
        ]
        static let dance2 = [
            "    ╭───╮        ",
            "    │ ● │        ",
            "    ╰─┬─╯        ",
            "      ╲          ",
            "    ╭─┴─╮        ",
            "    │^ ^│        ",
            "    │ ▽ │        ",
            "    │╰▽╯│        ",
            "    ╰─┬─╯        ",
            "      ╲          ",
            "    ──┴──        ",
        ]
        static let dance3 = happy
    }

    static let tips = [
        "Try: claude 'explain this code'",
        "Tip: codex --model o4-mini 'task'",
        "Hint: claude --dangerously-skip-permissions",
        "Tip: /compact in claude to compress context",
        "Try: claude --resume to continue session",
        "Hint: claude commit for auto-commit",
        "Tip: claude -p 'prompt' for pipe mode",
        "Try: codex -q for quiet mode",
        "Hint: CLAUDE.md file for project instructions",
        "Tip: /cost in claude to check spending",
        "Try: Cmd+Shift+O to show/hide window",
        "Hint: drag & drop a file for analysis!",
        "Tip: up/down arrows for command history",
        "Try: !dance to see a dance!",
        "Hint: !skin cat to change skin",
        "Tip: !git to show project status",
        "Try: !ps to monitor processes",
    ]
}

// MARK: - Speech Bubble

func speechBubble(_ text: String, maxWidth: Int = 36) -> String {
    let words = text.split(separator: " ", omittingEmptySubsequences: true)
    var lines: [String] = []
    var current = ""
    for word in words {
        if current.isEmpty {
            current = String(word)
        } else if current.count + 1 + word.count <= maxWidth {
            current += " " + word
        } else {
            lines.append(current)
            current = String(word)
        }
    }
    if !current.isEmpty { lines.append(current) }
    if lines.isEmpty { lines = [" "] }

    let width = max(lines.map { $0.count }.max() ?? 0, 10)
    var bubble = " ╭" + String(repeating: "─", count: width + 2) + "╮\n"
    for line in lines {
        bubble += " │ " + line.padding(toLength: width, withPad: " ", startingAt: 0) + " │\n"
    }
    bubble += " ╰" + String(repeating: "─", count: width + 2) + "╯"
    return bubble
}

// MARK: - Agent State

enum AgentState {
    case idle, thinking, typing, happy, sleeping, error, dancing, eating
}

// MARK: - Themes

struct Theme {
    let name: String
    let agentColor: NSColor
    let bubbleColor: NSColor
    let accentColor: NSColor
    let bgAlpha: CGFloat

    static let matrix = Theme(
        name: "Matrix",
        agentColor: NSColor(red: 0.3, green: 0.8, blue: 1.0, alpha: 1.0),
        bubbleColor: NSColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0),
        accentColor: NSColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0),
        bgAlpha: 0.95
    )
    static let cyberpunk = Theme(
        name: "Cyberpunk",
        agentColor: NSColor(red: 1.0, green: 0.0, blue: 0.8, alpha: 1.0),
        bubbleColor: NSColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0),
        accentColor: NSColor(red: 1.0, green: 0.2, blue: 0.6, alpha: 1.0),
        bgAlpha: 0.92
    )
    static let sunset = Theme(
        name: "Sunset",
        agentColor: NSColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0),
        bubbleColor: NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0),
        accentColor: NSColor(red: 1.0, green: 0.4, blue: 0.3, alpha: 1.0),
        bgAlpha: 0.93
    )
    static let ocean = Theme(
        name: "Ocean",
        agentColor: NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0),
        bubbleColor: NSColor(red: 0.3, green: 0.9, blue: 0.8, alpha: 1.0),
        accentColor: NSColor(red: 0.1, green: 0.5, blue: 0.9, alpha: 1.0),
        bgAlpha: 0.94
    )
    static let hacker = Theme(
        name: "Hacker",
        agentColor: NSColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0),
        bubbleColor: NSColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0),
        accentColor: NSColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0),
        bgAlpha: 0.97
    )

    static let all: [Theme] = [matrix, cyberpunk, sunset, ocean, hacker]
}

// MARK: - Achievements

struct Achievement {
    let id: String
    let name: String
    let desc: String
    let icon: String

    static let all: [Achievement] = [
        Achievement(id: "first_cmd", name: "Hello World", desc: "Run your first command", icon: "🌟"),
        Achievement(id: "cmd_10", name: "Getting Started", desc: "Run 10 commands", icon: "⚡"),
        Achievement(id: "cmd_50", name: "Power User", desc: "Run 50 commands", icon: "🔥"),
        Achievement(id: "cmd_100", name: "Centurion", desc: "Run 100 commands", icon: "💯"),
        Achievement(id: "cmd_500", name: "CLI Master", desc: "Run 500 commands", icon: "👑"),
        Achievement(id: "commit_1", name: "First Blood", desc: "Make your first commit", icon: "🎯"),
        Achievement(id: "commit_10", name: "Committer", desc: "Make 10 commits", icon: "📦"),
        Achievement(id: "commit_50", name: "Ship It!", desc: "Make 50 commits", icon: "🚀"),
        Achievement(id: "level_5", name: "Evolved", desc: "Reach level 5", icon: "🧬"),
        Achievement(id: "level_10", name: "Ascended", desc: "Reach level 10", icon: "✨"),
        Achievement(id: "level_20", name: "Legendary", desc: "Reach level 20", icon: "🏆"),
        Achievement(id: "streak_3", name: "Consistent", desc: "3-day streak", icon: "📅"),
        Achievement(id: "streak_7", name: "Dedicated", desc: "7-day streak", icon: "🗓"),
        Achievement(id: "streak_30", name: "Unstoppable", desc: "30-day streak", icon: "💎"),
        Achievement(id: "feed_pet", name: "Caretaker", desc: "Feed Agent-O for the first time", icon: "🍔"),
        Achievement(id: "play_pet", name: "Fun Times", desc: "Play with Agent-O", icon: "🎮"),
        Achievement(id: "all_skins", name: "Fashionista", desc: "Try all 4 skins", icon: "👗"),
        Achievement(id: "dance", name: "Dancer", desc: "Make Agent-O dance", icon: "💃"),
        Achievement(id: "drop_file", name: "Drag Master", desc: "Drag & drop a file", icon: "📎"),
        Achievement(id: "night_owl", name: "Night Owl", desc: "Use Agent-O after midnight", icon: "🦉"),
        Achievement(id: "early_bird", name: "Early Bird", desc: "Use Agent-O before 7am", icon: "🐦"),
        Achievement(id: "pomo_done", name: "Focused", desc: "Complete a pomodoro", icon: "🍅"),
        Achievement(id: "game_win", name: "Gamer", desc: "Win a mini-game", icon: "🎲"),
    ]
}

// MARK: - Evolution Stages

struct Evolution {
    static func stage(for level: Int) -> String {
        if level >= 20 { return "Cosmic" }
        if level >= 15 { return "Mythic" }
        if level >= 10 { return "Epic" }
        if level >= 5 { return "Evolved" }
        return "Baby"
    }

    static func accessory(for level: Int) -> [String] {
        // Returns overlay lines to add flair to the agent
        if level >= 20 {
            return ["     ·411·      ", "    ★ ★ ★ ★     ", "   ~ COSMIC ~   "]
        }
        if level >= 15 {
            return ["      ⚡⚡⚡       ", "    ~ MYTHIC ~  ", ""]
        }
        if level >= 10 {
            return ["      ✦✦✦       ", "    ~ EPIC ~    ", ""]
        }
        if level >= 5 {
            return ["      ◆◆◆       ", "   ~ EVOLVED ~  ", ""]
        }
        return ["", "", ""]
    }

    static func title(for level: Int) -> String {
        if level >= 20 { return "Cosmic Agent" }
        if level >= 15 { return "Mythic Agent" }
        if level >= 10 { return "Epic Agent" }
        if level >= 5 { return "Evolved Agent" }
        return "Baby Agent"
    }
}

// MARK: - Pomodoro Timer

class PomodoroTimer {
    var isRunning = false
    var secondsRemaining = 25 * 60
    var totalSeconds = 25 * 60
    var isBreak = false
    var completedCount = 0
    var timer: Timer?

    var onTick: ((String) -> Void)?
    var onComplete: (() -> Void)?

    var displayString: String {
        let m = secondsRemaining / 60
        let s = secondsRemaining % 60
        let bar = PetStats().statsBar(secondsRemaining * 100 / max(totalSeconds, 1), width: 15)
        let label = isBreak ? "BREAK" : "FOCUS"
        return "🍅 \(label) \(String(format: "%02d:%02d", m, s)) \(bar)"
    }

    func start(minutes: Int = 25) {
        stop()
        isRunning = true
        isBreak = false
        totalSeconds = minutes * 60
        secondsRemaining = totalSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func startBreak(minutes: Int = 5) {
        stop()
        isRunning = true
        isBreak = true
        totalSeconds = minutes * 60
        secondsRemaining = totalSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    func tick() {
        secondsRemaining -= 1
        onTick?(displayString)
        if secondsRemaining <= 0 {
            if !isBreak { completedCount += 1 }
            stop()
            onComplete?()
        }
    }
}

// MARK: - Mini Games

struct MiniGame {
    static func generateNumberGame() -> (answer: Int, hint: String) {
        let answer = Int.random(in: 1...100)
        return (answer, "I'm thinking of a number between 1 and 100. Type !guess <number>")
    }

    static func generateTrivia() -> (question: String, answer: String, choices: [String]) {
        let questions: [(String, String, [String])] = [
            ("What does CLI stand for?", "Command Line Interface",
             ["Command Line Interface", "Code Level Integration", "Central Logic Input"]),
            ("What year was Git created?", "2005",
             ["2003", "2005", "2007"]),
            ("Who created Linux?", "Linus Torvalds",
             ["Linus Torvalds", "Dennis Ritchie", "Ken Thompson"]),
            ("What does API stand for?", "Application Programming Interface",
             ["Application Programming Interface", "Automated Process Integration", "Advanced Protocol Interface"]),
            ("What language is the Linux kernel written in?", "C",
             ["C", "C++", "Rust"]),
            ("What does SSH stand for?", "Secure Shell",
             ["Secure Shell", "System Shell Handler", "Safe Session Host"]),
            ("What port does HTTPS use?", "443",
             ["80", "443", "8080"]),
            ("What does JSON stand for?", "JavaScript Object Notation",
             ["JavaScript Object Notation", "Java Standard Object Naming", "Joint System Object Network"]),
            ("What year was Python first released?", "1991",
             ["1989", "1991", "1995"]),
            ("What does RAM stand for?", "Random Access Memory",
             ["Random Access Memory", "Read And Modify", "Rapid Application Memory"]),
        ]
        let q = questions.randomElement()!
        return (q.0, q.1, q.2)
    }
}

// MARK: - Tamagotchi Pet Stats

class PetStats {
    var hunger: Int = 80      // 0-100 (100 = full)
    var happiness: Int = 80   // 0-100
    var energy: Int = 80      // 0-100
    var xp: Int = 0
    var level: Int = 1
    var totalCommands: Int = 0
    var totalCommits: Int = 0
    var streak: Int = 0       // consecutive days used
    var lastFed: Date = Date()
    var lastPlayed: Date = Date()
    var lastUsedDay: String = ""
    var unlockedAchievements: [String] = []
    var triedSkins: [String] = ["Robot"]
    var gamesWon: Int = 0
    var pomodorosCompleted: Int = 0

    var xpForNextLevel: Int { level * 100 }

    var mood: String {
        let avg = (hunger + happiness + energy) / 3
        if avg > 80 { return "Thriving!" }
        if avg > 60 { return "Happy" }
        if avg > 40 { return "Okay..." }
        if avg > 20 { return "Sad" }
        return "Critical!"
    }

    var moodEmoji: String {
        let avg = (hunger + happiness + energy) / 3
        if avg > 80 { return "★" }
        if avg > 60 { return "●" }
        if avg > 40 { return "◐" }
        if avg > 20 { return "○" }
        return "✖"
    }

    func statsBar(_ value: Int, width: Int = 10) -> String {
        let filled = (value * width) / 100
        let empty = width - filled
        return "[" + String(repeating: "█", count: filled) + String(repeating: "░", count: empty) + "]"
    }

    func gainXP(_ amount: Int) {
        xp += amount
        while xp >= xpForNextLevel {
            xp -= xpForNextLevel
            level += 1
        }
    }

    func feed() {
        hunger = min(100, hunger + 25)
        happiness = min(100, happiness + 5)
        lastFed = Date()
    }

    func play() {
        happiness = min(100, happiness + 20)
        energy = max(0, energy - 10)
        lastPlayed = Date()
    }

    func rest() {
        energy = min(100, energy + 30)
        hunger = max(0, hunger - 5)
    }

    func onCommandRun() {
        totalCommands += 1
        gainXP(10)
        happiness = min(100, happiness + 3)
        energy = max(0, energy - 5)
        hunger = max(0, hunger - 3)
    }

    func onCommandSuccess() {
        gainXP(15)
        happiness = min(100, happiness + 5)
    }

    func onCommit() {
        totalCommits += 1
        gainXP(25)
        happiness = min(100, happiness + 10)
    }

    func decay() {
        hunger = max(0, hunger - 2)
        happiness = max(0, happiness - 1)
        energy = max(0, energy - 1)
    }

    func updateStreak() {
        let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        if lastUsedDay != today {
            if lastUsedDay.isEmpty {
                streak = 1
            } else {
                streak += 1
            }
            lastUsedDay = today
            gainXP(20) // daily login bonus
        }
    }

    // MARK: - Persistence

    static let savePath = NSHomeDirectory() + "/.agento_pet.json"

    func hasAchievement(_ id: String) -> Bool { unlockedAchievements.contains(id) }

    func unlock(_ id: String) -> Achievement? {
        guard !hasAchievement(id),
              let achievement = Achievement.all.first(where: { $0.id == id }) else { return nil }
        unlockedAchievements.append(id)
        gainXP(30)
        return achievement
    }

    func checkAchievements() -> [Achievement] {
        var newOnes: [Achievement] = []
        let checks: [(String, Bool)] = [
            ("first_cmd", totalCommands >= 1),
            ("cmd_10", totalCommands >= 10),
            ("cmd_50", totalCommands >= 50),
            ("cmd_100", totalCommands >= 100),
            ("cmd_500", totalCommands >= 500),
            ("commit_1", totalCommits >= 1),
            ("commit_10", totalCommits >= 10),
            ("commit_50", totalCommits >= 50),
            ("level_5", level >= 5),
            ("level_10", level >= 10),
            ("level_20", level >= 20),
            ("streak_3", streak >= 3),
            ("streak_7", streak >= 7),
            ("streak_30", streak >= 30),
            ("all_skins", triedSkins.count >= 4),
        ]
        for (id, condition) in checks {
            if condition, let a = unlock(id) { newOnes.append(a) }
        }
        return newOnes
    }

    func save() {
        let data: [String: Any] = [
            "hunger": hunger, "happiness": happiness, "energy": energy,
            "xp": xp, "level": level, "totalCommands": totalCommands,
            "totalCommits": totalCommits, "streak": streak,
            "lastFed": lastFed.timeIntervalSince1970,
            "lastPlayed": lastPlayed.timeIntervalSince1970,
            "lastUsedDay": lastUsedDay,
            "unlockedAchievements": unlockedAchievements,
            "triedSkins": triedSkins,
            "gamesWon": gamesWon,
            "pomodorosCompleted": pomodorosCompleted
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: data),
           let json = String(data: jsonData, encoding: .utf8) {
            try? json.write(toFile: PetStats.savePath, atomically: true, encoding: .utf8)
        }
    }

    static func load() -> PetStats {
        let stats = PetStats()
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: savePath)),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return stats
        }
        stats.hunger = dict["hunger"] as? Int ?? 80
        stats.happiness = dict["happiness"] as? Int ?? 80
        stats.energy = dict["energy"] as? Int ?? 80
        stats.xp = dict["xp"] as? Int ?? 0
        stats.level = dict["level"] as? Int ?? 1
        stats.totalCommands = dict["totalCommands"] as? Int ?? 0
        stats.totalCommits = dict["totalCommits"] as? Int ?? 0
        stats.streak = dict["streak"] as? Int ?? 0
        if let ts = dict["lastFed"] as? TimeInterval { stats.lastFed = Date(timeIntervalSince1970: ts) }
        if let ts = dict["lastPlayed"] as? TimeInterval { stats.lastPlayed = Date(timeIntervalSince1970: ts) }
        stats.lastUsedDay = dict["lastUsedDay"] as? String ?? ""
        stats.unlockedAchievements = dict["unlockedAchievements"] as? [String] ?? []
        stats.triedSkins = dict["triedSkins"] as? [String] ?? ["Robot"]
        stats.gamesWon = dict["gamesWon"] as? Int ?? 0
        stats.pomodorosCompleted = dict["pomodorosCompleted"] as? Int ?? 0

        // Apply time-based decay (1 point per 30 min away)
        let minutesAway = Date().timeIntervalSince(stats.lastFed) / 60
        let decayTicks = Int(minutesAway / 30)
        for _ in 0..<min(decayTicks, 20) {
            stats.decay()
        }
        return stats
    }
}

// MARK: - Drop View

class DropView: NSView {
    var onDrop: (([String]) -> Void)?

    override init(frame: NSRect) {
        super.init(frame: frame)
        registerForDraggedTypes([.fileURL, .string])
    }
    required init?(coder: NSCoder) { fatalError() }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation { .copy }
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let items = sender.draggingPasteboard.pasteboardItems else { return false }
        var paths: [String] = []
        for item in items {
            if let urlStr = item.string(forType: .fileURL),
               let url = URL(string: urlStr) {
                paths.append(url.path)
            } else if let str = item.string(forType: .string) {
                paths.append(str)
            }
        }
        if !paths.isEmpty { onDrop?(paths) }
        return !paths.isEmpty
    }
}

// MARK: - Main App Delegate

class AgentODelegate: NSObject, NSApplicationDelegate, NSTextFieldDelegate {
    // UI
    var window: NSPanel!
    var miniWindow: NSPanel!
    var agentLabel: NSTextField!
    var bubbleLabel: NSTextField!
    var inputField: NSTextField!
    var outputScroll: NSScrollView!
    var outputText: NSTextView!
    var gitStatusLabel: NSTextField!
    var statusBarItem: NSStatusItem!

    // Quick action buttons
    var commitBtn: NSButton!
    var testBtn: NSButton!
    var explainBtn: NSButton!
    var reviewBtn: NSButton!
    var statsLabel: NSTextField!

    // State
    var animTimer: Timer?
    var tipTimer: Timer?
    var sleepTimer: Timer?
    var animFrame = 0
    var state: AgentState = .idle
    var currentProcess: Process?
    var currentSkin: AgentSkin = .robot
    var commandHistory: [String] = []
    var historyIndex = -1
    var lastInteraction = Date()
    var isWindowVisible = true
    var globalMonitor: Any?
    var localMonitor: Any?
    var pet = PetStats.load()
    var decayTimer: Timer?
    var currentTheme = Theme.matrix
    var pomodoro = PomodoroTimer()
    var pomoLabel: NSTextField!

    // Mini-game state
    var gameActive = false
    var gameAnswer = 0
    var gameGuesses = 0
    var triviaAnswer = ""
    var triviaActive = false

    // Colors
    let cGreen = NSColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0)
    let cCyan = NSColor(red: 0.3, green: 0.8, blue: 1.0, alpha: 1.0)
    let cRed = NSColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0)
    let cYellow = NSColor(red: 1.0, green: 0.85, blue: 0.2, alpha: 1.0)
    let cPurple = NSColor(red: 0.7, green: 0.4, blue: 1.0, alpha: 1.0)
    let cGray = NSColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
    let cDimGray = NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    let cOrange = NSColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)
    let bgColor = NSColor(red: 0.08, green: 0.08, blue: 0.12, alpha: 0.95)
    let monoFont = NSFont.monospacedSystemFont(ofSize: 11, weight: .regular)
    let monoBold = NSFont.monospacedSystemFont(ofSize: 11, weight: .bold)

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        pet.updateStreak()
        setupMenuBar()
        setupMainWindow()
        setupMiniWindow()
        setupGlobalHotkey()
        startTimers()
        showWelcome()
        refreshGitStatus()
        playSound("Funk")
    }

    // MARK: - Menu Bar

    func setupMenuBar() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem.button?.title = "◉ Agent-O"
        statusBarItem.button?.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .medium)

        let menu = NSMenu()
        menu.addItem(withTitle: "Show/Hide (⌘⇧O)", action: #selector(toggleWindow), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())

        let skinMenu = NSMenu()
        for skin in AgentSkin.allCases {
            let item = NSMenuItem(title: "\(skin.mini) \(skin.rawValue)", action: #selector(changeSkinMenu(_:)), keyEquivalent: "")
            item.representedObject = skin
            skinMenu.addItem(item)
        }
        let skinItem = NSMenuItem(title: "Skins", action: nil, keyEquivalent: "")
        skinItem.submenu = skinMenu
        menu.addItem(skinItem)

        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quick: Commit", action: #selector(quickCommit), keyEquivalent: "")
        menu.addItem(withTitle: "Quick: Tests", action: #selector(quickTest), keyEquivalent: "")
        menu.addItem(withTitle: "Quick: Git Status", action: #selector(quickGit), keyEquivalent: "")
        menu.addItem(withTitle: "Quick: Explain Error", action: #selector(quickExplain), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Feed Agent-O", action: #selector(feedPet), keyEquivalent: "")
        menu.addItem(withTitle: "Play with Agent-O", action: #selector(playPet), keyEquivalent: "")
        menu.addItem(withTitle: "Rest Agent-O", action: #selector(restPet), keyEquivalent: "")
        menu.addItem(withTitle: "Pet Stats", action: #selector(showPetStats), keyEquivalent: "")
        menu.addItem(withTitle: "Achievements", action: #selector(showAchievements), keyEquivalent: "")

        let themeMenu = NSMenu()
        for (i, theme) in Theme.all.enumerated() {
            let item = NSMenuItem(title: theme.name, action: #selector(changeThemeMenu(_:)), keyEquivalent: "")
            item.tag = i
            themeMenu.addItem(item)
        }
        let themeItem = NSMenuItem(title: "Themes", action: nil, keyEquivalent: "")
        themeItem.submenu = themeMenu
        menu.addItem(themeItem)

        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Pomodoro (25 min)", action: #selector(startPomodoro), keyEquivalent: "")
        menu.addItem(withTitle: "Mini-Game", action: #selector(startGame), keyEquivalent: "")
        menu.addItem(withTitle: "Dance!", action: #selector(doDance), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit Agent-O", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")

        statusBarItem.menu = menu
    }

    @objc func changeSkinMenu(_ sender: NSMenuItem) {
        guard let skin = sender.representedObject as? AgentSkin else { return }
        currentSkin = skin
        updateAgentDisplay()
        bubbleLabel.stringValue = speechBubble("Skin: \(skin.rawValue) \(skin.mini)")
        playSound("Pop")
    }

    // MARK: - Main Window

    func setupMainWindow() {
        let screen = NSScreen.main!.visibleFrame
        let w: CGFloat = 440
        let h: CGFloat = 760
        let x = screen.maxX - w - 16
        let y = screen.minY + 16

        window = NSPanel(
            contentRect: NSRect(x: x, y: y, width: w, height: h),
            styleMask: [.titled, .closable, .resizable, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        window.title = "Agent-O v2"
        window.isFloatingPanel = true
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.isMovableByWindowBackground = true
        window.titlebarAppearsTransparent = true
        window.isOpaque = false
        window.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.14, alpha: 1.0)
        window.minSize = NSSize(width: 360, height: 500)

        // Drop-aware container
        let dropContainer = DropView(frame: NSRect(x: 0, y: 0, width: w, height: h))
        dropContainer.autoresizingMask = [.width, .height]
        dropContainer.onDrop = { [weak self] paths in self?.handleFileDrop(paths) }
        window.contentView = dropContainer

        var yPos = h - 30

        // Speech bubble
        yPos -= 75
        bubbleLabel = NSTextField(labelWithString: "")
        bubbleLabel.frame = NSRect(x: 10, y: yPos, width: w - 20, height: 75)
        bubbleLabel.font = monoFont
        bubbleLabel.textColor = cGreen
        bubbleLabel.maximumNumberOfLines = 5
        bubbleLabel.lineBreakMode = .byWordWrapping
        bubbleLabel.autoresizingMask = [.width, .minYMargin]
        dropContainer.addSubview(bubbleLabel)

        // ASCII agent
        yPos -= 150
        agentLabel = NSTextField(labelWithString: "")
        agentLabel.frame = NSRect(x: 10, y: yPos, width: w - 20, height: 150)
        agentLabel.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .medium)
        agentLabel.textColor = cCyan
        agentLabel.alignment = .center
        agentLabel.autoresizingMask = [.width, .minYMargin]
        dropContainer.addSubview(agentLabel)

        // Pet stats bar
        yPos -= 48
        statsLabel = NSTextField(labelWithString: "")
        statsLabel.frame = NSRect(x: 10, y: yPos, width: w - 20, height: 44)
        statsLabel.font = NSFont.monospacedSystemFont(ofSize: 10, weight: .regular)
        statsLabel.textColor = cYellow
        statsLabel.maximumNumberOfLines = 4
        statsLabel.autoresizingMask = [.width, .minYMargin]
        dropContainer.addSubview(statsLabel)
        refreshStatsDisplay()

        // Git status bar
        yPos -= 16
        gitStatusLabel = NSTextField(labelWithString: "")
        gitStatusLabel.frame = NSRect(x: 10, y: yPos, width: w - 20, height: 14)
        gitStatusLabel.font = NSFont.monospacedSystemFont(ofSize: 10, weight: .regular)
        gitStatusLabel.textColor = cDimGray
        gitStatusLabel.autoresizingMask = [.width, .minYMargin]
        dropContainer.addSubview(gitStatusLabel)

        // Divider
        yPos -= 6
        let divider = NSBox(frame: NSRect(x: 16, y: yPos, width: w - 32, height: 1))
        divider.boxType = .separator
        divider.autoresizingMask = [.width, .minYMargin]
        dropContainer.addSubview(divider)

        // Quick action buttons row
        yPos -= 28
        let btnW: CGFloat = 95
        let btnGap: CGFloat = 6
        let btnY = yPos

        commitBtn = makeQuickButton("Commit", x: 10, y: btnY, w: btnW, action: #selector(quickCommit))
        testBtn = makeQuickButton("Tests", x: 10 + btnW + btnGap, y: btnY, w: btnW, action: #selector(quickTest))
        explainBtn = makeQuickButton("Explain", x: 10 + (btnW + btnGap)*2, y: btnY, w: btnW, action: #selector(quickExplain))
        reviewBtn = makeQuickButton("Review", x: 10 + (btnW + btnGap)*3, y: btnY, w: btnW, action: #selector(quickReview))

        for btn in [commitBtn!, testBtn!, explainBtn!, reviewBtn!] {
            btn.autoresizingMask = [.minYMargin]
            dropContainer.addSubview(btn)
        }

        // Output scroll view
        yPos -= 6
        let outputH = yPos - 48
        outputScroll = NSScrollView(frame: NSRect(x: 10, y: 48, width: w - 20, height: outputH))
        outputScroll.hasVerticalScroller = true
        outputScroll.autohidesScrollers = true
        outputScroll.borderType = .noBorder
        outputScroll.backgroundColor = .clear
        outputScroll.drawsBackground = false
        outputScroll.autoresizingMask = [.width, .height]

        outputText = NSTextView(frame: NSRect(x: 0, y: 0, width: w - 30, height: outputH))
        outputText.isEditable = false
        outputText.isSelectable = true
        outputText.backgroundColor = .clear
        outputText.drawsBackground = false
        outputText.font = monoFont
        outputText.textColor = cGray
        outputText.textContainerInset = NSSize(width: 5, height: 5)
        outputText.isAutomaticLinkDetectionEnabled = true
        outputScroll.documentView = outputText
        dropContainer.addSubview(outputScroll)

        // Pomodoro bar (hidden by default)
        pomoLabel = NSTextField(labelWithString: "")
        pomoLabel.frame = NSRect(x: 10, y: 44, width: w - 20, height: 14)
        pomoLabel.font = NSFont.monospacedSystemFont(ofSize: 10, weight: .medium)
        pomoLabel.textColor = cRed
        pomoLabel.isHidden = true
        pomoLabel.autoresizingMask = [.width, .maxYMargin]
        dropContainer.addSubview(pomoLabel)

        // Input field
        inputField = NSTextField(frame: NSRect(x: 10, y: 12, width: w - 80, height: 28))
        inputField.placeholderString = "Ask Agent-O anything... (Cmd+Shift+O toggle)"
        inputField.font = monoFont
        inputField.textColor = .white
        inputField.backgroundColor = NSColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 1.0)
        inputField.isBordered = true
        inputField.bezelStyle = .roundedBezel
        inputField.focusRingType = .none
        inputField.delegate = self
        inputField.autoresizingMask = [.width, .maxYMargin]
        dropContainer.addSubview(inputField)

        // Send button
        let sendBtn = NSButton(frame: NSRect(x: w - 65, y: 10, width: 55, height: 30))
        sendBtn.title = "▶ Go"
        sendBtn.bezelStyle = .rounded
        sendBtn.target = self
        sendBtn.action = #selector(sendPrompt)
        sendBtn.font = monoBold
        sendBtn.autoresizingMask = [.minXMargin, .maxYMargin]
        dropContainer.addSubview(sendBtn)

        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    func makeQuickButton(_ title: String, x: CGFloat, y: CGFloat, w: CGFloat, action: Selector) -> NSButton {
        let btn = NSButton(frame: NSRect(x: x, y: y, width: w, height: 22))
        btn.title = title
        btn.bezelStyle = .rounded
        btn.controlSize = .small
        btn.font = NSFont.monospacedSystemFont(ofSize: 10, weight: .medium)
        btn.target = self
        btn.action = action
        return btn
    }

    // MARK: - Mini Window (Minimized Mode)

    func setupMiniWindow() {
        let screen = NSScreen.main!.visibleFrame
        miniWindow = NSPanel(
            contentRect: NSRect(x: screen.maxX - 80, y: screen.minY + 16, width: 70, height: 30),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        miniWindow.isFloatingPanel = true
        miniWindow.level = .floating
        miniWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        miniWindow.isMovableByWindowBackground = true
        miniWindow.backgroundColor = bgColor
        miniWindow.hasShadow = true
        miniWindow.isOpaque = false

        let miniLabel = NSTextField(labelWithString: currentSkin.mini)
        miniLabel.frame = NSRect(x: 0, y: 0, width: 70, height: 30)
        miniLabel.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .bold)
        miniLabel.textColor = cCyan
        miniLabel.alignment = .center

        let clickArea = NSButton(frame: NSRect(x: 0, y: 0, width: 70, height: 30))
        clickArea.isTransparent = true
        clickArea.target = self
        clickArea.action = #selector(toggleWindow)

        miniWindow.contentView?.addSubview(miniLabel)
        miniWindow.contentView?.addSubview(clickArea)
    }

    // MARK: - Global Hotkey (Cmd+Shift+O)

    func setupGlobalHotkey() {
        globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.modifierFlags.contains([.command, .shift]) && event.keyCode == 31 { // O key
                DispatchQueue.main.async { self?.toggleWindow() }
            }
        }
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.modifierFlags.contains([.command, .shift]) && event.keyCode == 31 {
                DispatchQueue.main.async { self?.toggleWindow() }
                return nil
            }
            return event
        }
    }

    @objc func toggleWindow() {
        if isWindowVisible {
            window.orderOut(nil)
            miniWindow.makeKeyAndOrderFront(nil)
        } else {
            miniWindow.orderOut(nil)
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            window.makeFirstResponder(inputField)
        }
        isWindowVisible.toggle()
    }

    // MARK: - Timers

    func startTimers() {
        animTimer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { [weak self] _ in
            self?.animate()
        }
        tipTimer = Timer.scheduledTimer(withTimeInterval: 45.0, repeats: true) { [weak self] _ in
            guard let self = self, self.state == .idle || self.state == .sleeping else { return }
            let tip = AgentArt.tips.randomElement()!
            self.bubbleLabel.stringValue = speechBubble(tip)
        }
        sleepTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.state == .idle && Date().timeIntervalSince(self.lastInteraction) > 120 {
                self.state = .sleeping
                self.bubbleLabel.stringValue = speechBubble("Zzz... wake me up with a task...")
            }
        }
        // Pet stats decay every 5 minutes
        decayTimer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.pet.decay()
            self.pet.save()
            self.refreshStatsDisplay()
            // Complain if hungry
            if self.pet.hunger < 20 && self.state == .idle {
                self.bubbleLabel.stringValue = speechBubble("I'm hungry! Type !feed to feed me!")
            } else if self.pet.happiness < 20 && self.state == .idle {
                self.bubbleLabel.stringValue = speechBubble("I'm sad... Type !play to cheer me up!")
            } else if self.pet.energy < 20 && self.state == .idle {
                self.bubbleLabel.stringValue = speechBubble("So tired... Type !rest to let me rest!")
            }
        }
    }

    func animate() {
        let frames: [[String]]
        switch state {
        case .idle: frames = currentSkin.idle
        case .thinking: frames = currentSkin.thinking
        case .typing: frames = currentSkin.typing
        case .sleeping: frames = currentSkin.sleeping
        case .dancing: frames = currentSkin.dance
        case .eating: frames = currentSkin.idle
        case .happy:
            agentLabel.stringValue = currentSkin.happy.joined(separator: "\n")
            return
        case .error:
            agentLabel.stringValue = currentSkin.error.joined(separator: "\n")
            return
        }
        animFrame = (animFrame + 1) % frames.count
        agentLabel.stringValue = frames[animFrame].joined(separator: "\n")
    }

    func updateAgentDisplay() {
        let frames = currentSkin.idle
        agentLabel.stringValue = frames[0].joined(separator: "\n")
    }

    func setState(_ newState: AgentState, duration: TimeInterval? = nil) {
        state = newState
        animate()
        if let d = duration {
            DispatchQueue.main.asyncAfter(deadline: .now() + d) { [weak self] in
                self?.state = .idle
            }
        }
    }

    // MARK: - Tamagotchi Actions

    func refreshStatsDisplay() {
        let p = pet
        let lvlBar = "Lv.\(p.level) \(p.moodEmoji) \(p.mood)"
        let hBar = "Food \(p.statsBar(p.hunger)) \(p.hunger)%"
        let jBar = "Joy  \(p.statsBar(p.happiness)) \(p.happiness)%"
        let eBar = "Nrg  \(p.statsBar(p.energy)) \(p.energy)%"
        statsLabel.stringValue = "\(lvlBar)  XP:\(p.xp)/\(p.xpForNextLevel)  Streak:\(p.streak)d\n\(hBar)  \(jBar)  \(eBar)"
        statusBarItem.button?.title = "\(currentSkin.mini) Lv.\(p.level) \(p.moodEmoji)"
    }

    @objc func feedPet() {
        pet.feed()
        pet.save()
        setState(.happy, duration: 2)
        bubbleLabel.stringValue = speechBubble("Yum! That was delicious! +25 Food")
        appendColored("🍔 Fed Agent-O! Food: \(pet.hunger)%\n\n", color: cGreen)
        playSound("Pop")
        if let a = pet.unlock("feed_pet") {
            appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n\n", color: cYellow, bold: true)
        }
        refreshStatsDisplay()
        processAchievements()
    }

    @objc func playPet() {
        pet.play()
        pet.save()
        setState(.dancing, duration: 3)
        bubbleLabel.stringValue = speechBubble("Wheee! So fun! +20 Joy")
        appendColored("🎮 Played with Agent-O! Joy: \(pet.happiness)%\n\n", color: cPurple)
        playSound("Funk")
        if let a = pet.unlock("play_pet") {
            appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n\n", color: cYellow, bold: true)
        }
        refreshStatsDisplay()
        processAchievements()
    }

    @objc func restPet() {
        pet.rest()
        pet.save()
        setState(.sleeping, duration: 3)
        bubbleLabel.stringValue = speechBubble("Zzz... recharging... +30 Energy")
        appendColored("💤 Agent-O is resting! Energy: \(pet.energy)%\n\n", color: cCyan)
        playSound("Purr")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.state = .idle
        }
        refreshStatsDisplay()
    }

    @objc func showPetStats() {
        let p = pet
        appendColored("╭── Agent-O Stats ────────────────────╮\n", color: cCyan)
        appendColored("  Level: \(p.level)  XP: \(p.xp)/\(p.xpForNextLevel)\n", color: cYellow, bold: true)
        appendColored("  Mood:  \(p.mood) \(p.moodEmoji)\n", color: cGray)
        appendColored("  Food:  \(p.statsBar(p.hunger)) \(p.hunger)%\n", color: cGreen)
        appendColored("  Joy:   \(p.statsBar(p.happiness)) \(p.happiness)%\n", color: cPurple)
        appendColored("  Energy:\(p.statsBar(p.energy)) \(p.energy)%\n", color: cCyan)
        appendColored("  ──────────────────────────────\n", color: cDimGray)
        appendColored("  Commands run: \(p.totalCommands)\n", color: cGray)
        appendColored("  Commits made: \(p.totalCommits)\n", color: cGray)
        appendColored("  Daily streak: \(p.streak) days\n", color: cOrange)
        appendColored("╰────────────────────────────────────╯\n\n", color: cCyan)
    }

    func checkLevelUp(oldLevel: Int) {
        if pet.level > oldLevel {
            appendColored("🎉 LEVEL UP! Agent-O is now Level \(pet.level)!\n\n", color: cYellow, bold: true)
            bubbleLabel.stringValue = speechBubble("LEVEL UP! I'm Level \(pet.level) now!")
            setState(.dancing, duration: 3)
            playSound("Funk")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.state = .idle
            }
        }
    }

    // MARK: - Achievements

    func processAchievements() {
        let newOnes = pet.checkAchievements()
        for a in newOnes {
            appendColored("\n🏆 ACHIEVEMENT UNLOCKED: \(a.icon) \(a.name)\n", color: cYellow, bold: true)
            appendColored("   \(a.desc) (+30 XP)\n\n", color: cGray)
            sendNotification(title: "Achievement Unlocked!", body: "\(a.icon) \(a.name): \(a.desc)")
        }
        if !newOnes.isEmpty {
            playSound("Hero")
            pet.save()
            refreshStatsDisplay()
        }
    }

    @objc func showAchievements() {
        appendColored("╭── Achievements ─────────────────────╮\n", color: cYellow)
        appendColored("  \(pet.unlockedAchievements.count)/\(Achievement.all.count) unlocked\n\n", color: cGray)
        for a in Achievement.all {
            let unlocked = pet.hasAchievement(a.id)
            let icon = unlocked ? a.icon : "🔒"
            let color = unlocked ? cYellow : cDimGray
            appendColored("  \(icon) \(a.name.padding(toLength: 16, withPad: " ", startingAt: 0))", color: color, bold: unlocked)
            appendColored(" \(a.desc)\n", color: unlocked ? cGray : cDimGray)
        }
        appendColored("╰────────────────────────────────────╯\n\n", color: cYellow)
    }

    // MARK: - Themes

    @objc func changeThemeMenu(_ sender: NSMenuItem) {
        let idx = sender.tag
        guard idx < Theme.all.count else { return }
        currentTheme = Theme.all[idx]
        applyTheme()
        appendColored("🎨 Theme: \(currentTheme.name)\n\n", color: currentTheme.accentColor, bold: true)
        playSound("Pop")
    }

    func applyTheme() {
        agentLabel.textColor = currentTheme.agentColor
        bubbleLabel.textColor = currentTheme.bubbleColor
        window.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.14, alpha: 1.0)
    }

    // MARK: - Evolution Display

    func getEvolvedArt() -> String {
        let base = currentSkin.idle[0].joined(separator: "\n")
        let acc = Evolution.accessory(for: pet.level)
        let title = Evolution.title(for: pet.level)
        if pet.level >= 5 {
            return acc.joined(separator: "\n") + "\n" + base + "\n   « \(title) »"
        }
        return base
    }

    // MARK: - Pomodoro

    @objc func startPomodoro() {
        pomoStartWith(minutes: 25)
    }

    func pomoStartWith(minutes: Int) {
        pomodoro.start(minutes: minutes)
        pomoLabel.isHidden = false
        pomoLabel.stringValue = pomodoro.displayString

        pomodoro.onTick = { [weak self] display in
            DispatchQueue.main.async {
                self?.pomoLabel.stringValue = display
            }
        }
        pomodoro.onComplete = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.pet.pomodorosCompleted += 1
                self.pet.gainXP(40)
                self.pet.happiness = min(100, self.pet.happiness + 15)
                self.pet.save()
                self.refreshStatsDisplay()

                if let a = self.pet.unlock("pomo_done") {
                    self.appendColored("\n🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n\n", color: self.cYellow, bold: true)
                }
                self.processAchievements()

                self.appendColored("🍅 Pomodoro complete! +40 XP\n", color: self.cRed, bold: true)
                self.appendColored("   Take a break! Type !break for 5 min break\n\n", color: self.cGray)
                self.bubbleLabel.stringValue = speechBubble("Pomodoro done! Great focus! +40 XP")
                self.sendNotification(title: "Pomodoro Complete!", body: "Time for a break! +40 XP")
                self.playSound("Glass")
                self.setState(.happy, duration: 3)
                self.pomoLabel.stringValue = "🍅 DONE! Type !break for 5 min break"
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.pomoLabel.isHidden = true
                }
            }
        }

        appendColored("🍅 Pomodoro started! \(minutes) min focus time\n\n", color: cRed, bold: true)
        bubbleLabel.stringValue = speechBubble("Focus mode! \(minutes) min on the clock!")
    }

    // MARK: - Mini Games

    @objc func startGame() {
        startNumberGame()
    }

    func startNumberGame() {
        let game = MiniGame.generateNumberGame()
        gameActive = true
        gameAnswer = game.answer
        gameGuesses = 0
        appendColored("🎲 NUMBER GAME\n", color: cPurple, bold: true)
        appendColored("   \(game.hint)\n\n", color: cGray)
        bubbleLabel.stringValue = speechBubble("Let's play! Guess my number 1-100!")
        setState(.happy, duration: 2)
    }

    func startTriviaGame() {
        let trivia = MiniGame.generateTrivia()
        triviaActive = true
        triviaAnswer = trivia.answer
        appendColored("🧠 TRIVIA TIME\n", color: cPurple, bold: true)
        appendColored("   \(trivia.question)\n", color: cGray)
        for (i, choice) in trivia.choices.enumerated() {
            appendColored("   \(i+1). \(choice)\n", color: cYellow)
        }
        appendColored("   Type !answer <number or text>\n\n", color: cDimGray)
        bubbleLabel.stringValue = speechBubble("Trivia time! Pick the right answer!")
    }

    func handleGuess(_ input: String) -> Bool {
        guard gameActive, let guess = Int(input) else { return false }
        gameGuesses += 1
        if guess == gameAnswer {
            gameActive = false
            let xpBonus = max(50 - gameGuesses * 5, 10)
            pet.gamesWon += 1
            pet.gainXP(xpBonus)
            pet.happiness = min(100, pet.happiness + 10)
            pet.save()
            if let a = pet.unlock("game_win") {
                appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n", color: cYellow, bold: true)
            }
            processAchievements()
            refreshStatsDisplay()
            appendColored("🎉 Correct! You got it in \(gameGuesses) guesses! +\(xpBonus) XP\n\n", color: cGreen, bold: true)
            bubbleLabel.stringValue = speechBubble("You win! \(gameGuesses) guesses! +\(xpBonus) XP")
            setState(.dancing, duration: 3)
            playSound("Funk")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.state = .idle
            }
            return true
        } else if guess < gameAnswer {
            appendColored("   ⬆️ Higher! (guess #\(gameGuesses))\n", color: cYellow)
            bubbleLabel.stringValue = speechBubble("Higher! Try again!")
        } else {
            appendColored("   ⬇️ Lower! (guess #\(gameGuesses))\n", color: cYellow)
            bubbleLabel.stringValue = speechBubble("Lower! Try again!")
        }
        return true
    }

    func handleTriviaAnswer(_ input: String) -> Bool {
        guard triviaActive else { return false }
        triviaActive = false
        if input.lowercased().trimmingCharacters(in: .whitespaces) == triviaAnswer.lowercased() ||
           triviaAnswer.lowercased().contains(input.lowercased().trimmingCharacters(in: .whitespaces)) {
            pet.gamesWon += 1
            pet.gainXP(30)
            pet.happiness = min(100, pet.happiness + 10)
            pet.save()
            refreshStatsDisplay()
            processAchievements()
            appendColored("🎉 Correct! +30 XP\n\n", color: cGreen, bold: true)
            bubbleLabel.stringValue = speechBubble("Big brain! Correct!")
            playSound("Glass")
        } else {
            appendColored("❌ Wrong! Answer was: \(triviaAnswer)\n\n", color: cRed)
            bubbleLabel.stringValue = speechBubble("Not quite! Answer: \(triviaAnswer)")
            playSound("Basso")
        }
        return true
    }

    // MARK: - Notifications

    func sendNotification(title: String, body: String) {
        // Use osascript for notifications (no bundle ID needed)
        let script = "display notification \"\(body.replacingOccurrences(of: "\"", with: "\\\""))\" with title \"\(title.replacingOccurrences(of: "\"", with: "\\\""))\""
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
        process.arguments = ["-e", script]
        try? process.run()
    }

    // MARK: - Clipboard Analysis

    func analyzeClipboard() {
        guard let clipboard = NSPasteboard.general.string(forType: .string) else {
            appendColored("📋 Clipboard is empty\n\n", color: cDimGray)
            return
        }
        let preview = String(clipboard.prefix(200))
        appendColored("📋 Clipboard content:\n", color: cCyan, bold: true)
        appendColored("   \(preview)\(clipboard.count > 200 ? "..." : "")\n", color: cGray)
        appendColored("   (\(clipboard.count) chars)\n\n", color: cDimGray)

        let prompt = "Analyze this code/text and explain what it does. Be brief:\n\(clipboard)"
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Analyzing clipboard...")
        let oldLevel = pet.level
        pet.onCommandRun()
        pet.save()
        refreshStatsDisplay()

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: prompt, oldLevel: oldLevel)
        }
    }

    // MARK: - Time-based Achievements

    func checkTimeAchievements() {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 0 && hour < 5 {
            if let a = pet.unlock("night_owl") {
                appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name) — Coding at night!\n\n", color: cYellow, bold: true)
            }
        }
        if hour >= 5 && hour < 7 {
            if let a = pet.unlock("early_bird") {
                appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name) — Early riser!\n\n", color: cYellow, bold: true)
            }
        }
    }

    // MARK: - Sound

    func playSound(_ name: String) {
        NSSound(named: NSSound.Name(name))?.play()
    }

    // MARK: - Text Output with Syntax Highlighting

    func appendOutput(_ text: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let storage = self.outputText.textStorage!
            let highlighted = self.highlightText(text)
            storage.append(highlighted)
            self.outputText.scrollToEndOfDocument(nil)
        }
    }

    func appendColored(_ text: String, color: NSColor, bold: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let storage = self.outputText.textStorage!
            let attrs: [NSAttributedString.Key: Any] = [
                .font: bold ? self.monoBold : self.monoFont,
                .foregroundColor: color
            ]
            storage.append(NSAttributedString(string: text, attributes: attrs))
            self.outputText.scrollToEndOfDocument(nil)
        }
    }

    func highlightText(_ text: String) -> NSAttributedString {
        let result = NSMutableAttributedString()

        let lines = text.components(separatedBy: "\n")
        for (i, line) in lines.enumerated() {
            let suffix = i < lines.count - 1 ? "\n" : ""
            let fullLine = line + suffix

            if line.hasPrefix("```") {
                // Code block marker
                result.append(NSAttributedString(string: fullLine, attributes: [
                    .font: monoFont,
                    .foregroundColor: cDimGray
                ]))
            } else if line.hasPrefix("#") {
                // Heading
                result.append(NSAttributedString(string: fullLine, attributes: [
                    .font: monoBold,
                    .foregroundColor: cCyan
                ]))
            } else if line.hasPrefix("- ") || line.hasPrefix("* ") || line.hasPrefix("  - ") {
                // List item
                result.append(NSAttributedString(string: fullLine, attributes: [
                    .font: monoFont,
                    .foregroundColor: cGreen
                ]))
            } else if line.contains("```") || line.hasPrefix("    ") || line.hasPrefix("\t") {
                // Indented code
                result.append(NSAttributedString(string: fullLine, attributes: [
                    .font: monoFont,
                    .foregroundColor: cOrange
                ]))
            } else if line.hasPrefix("error") || line.hasPrefix("Error") || line.lowercased().contains("failed") {
                result.append(NSAttributedString(string: fullLine, attributes: [
                    .font: monoBold,
                    .foregroundColor: cRed
                ]))
            } else if line.hasPrefix(">") {
                result.append(NSAttributedString(string: fullLine, attributes: [
                    .font: monoFont,
                    .foregroundColor: cPurple
                ]))
            } else {
                // Inline code highlighting with backticks
                let attrLine = highlightInlineCode(fullLine)
                result.append(attrLine)
            }
        }
        return result
    }

    func highlightInlineCode(_ text: String) -> NSAttributedString {
        let result = NSMutableAttributedString()
        let baseAttrs: [NSAttributedString.Key: Any] = [.font: monoFont, .foregroundColor: cGray]
        let codeAttrs: [NSAttributedString.Key: Any] = [
            .font: monoFont,
            .foregroundColor: cOrange,
            .backgroundColor: NSColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 0.5)
        ]

        var remaining = text
        while let start = remaining.range(of: "`") {
            // Text before backtick
            let before = String(remaining[remaining.startIndex..<start.lowerBound])
            if !before.isEmpty {
                result.append(NSAttributedString(string: before, attributes: baseAttrs))
            }
            remaining = String(remaining[start.upperBound...])

            if let end = remaining.range(of: "`") {
                let code = String(remaining[remaining.startIndex..<end.lowerBound])
                result.append(NSAttributedString(string: code, attributes: codeAttrs))
                remaining = String(remaining[end.upperBound...])
            } else {
                result.append(NSAttributedString(string: "`" + remaining, attributes: baseAttrs))
                remaining = ""
            }
        }
        if !remaining.isEmpty {
            result.append(NSAttributedString(string: remaining, attributes: baseAttrs))
        }
        return result
    }

    // MARK: - Command History & Input Handling

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            sendPrompt()
            return true
        }
        if commandSelector == #selector(NSResponder.moveUp(_:)) {
            navigateHistory(direction: -1)
            return true
        }
        if commandSelector == #selector(NSResponder.moveDown(_:)) {
            navigateHistory(direction: 1)
            return true
        }
        return false
    }

    func navigateHistory(direction: Int) {
        guard !commandHistory.isEmpty else { return }
        historyIndex += direction
        if historyIndex < 0 { historyIndex = 0 }
        if historyIndex >= commandHistory.count {
            historyIndex = commandHistory.count
            inputField.stringValue = ""
            return
        }
        inputField.stringValue = commandHistory[historyIndex]
    }

    // MARK: - Git Status

    func refreshGitStatus() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let result = self?.shell("cd ~ && git rev-parse --is-inside-work-tree 2>/dev/null && git -C \"$(git rev-parse --show-toplevel 2>/dev/null)\" branch --show-current 2>/dev/null && git -C \"$(git rev-parse --show-toplevel 2>/dev/null)\" status --porcelain 2>/dev/null | wc -l")
            DispatchQueue.main.async {
                guard let self = self, let r = result else {
                    self?.gitStatusLabel.stringValue = "  No git repo detected"
                    return
                }
                let parts = r.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
                if parts.count >= 2 {
                    let branch = parts.count > 0 ? parts[0] : "?"
                    let branchName = parts.count > 1 ? parts[1] : "?"
                    let changes = parts.count > 2 ? (parts[2].trimmingCharacters(in: .whitespaces)) : "0"
                    if branch == "true" {
                        self.gitStatusLabel.stringValue = "  git: \(branchName) | \(changes) changes"
                        self.gitStatusLabel.textColor = changes == "0" ? self.cDimGray : self.cYellow
                    } else {
                        self.gitStatusLabel.stringValue = "  No git repo"
                    }
                }
            }
        }
    }

    // MARK: - File Drop

    func handleFileDrop(_ paths: [String]) {
        lastInteraction = Date()
        if state == .sleeping { state = .idle }
        playSound("Pop")
        if let a = pet.unlock("drop_file") {
            appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n\n", color: cYellow, bold: true)
            pet.save()
        }

        for path in paths {
            let filename = (path as NSString).lastPathComponent
            appendColored("📎 File: \(filename)\n", color: cCyan, bold: true)
            bubbleLabel.stringValue = speechBubble("Analyzing \(filename)...")

            let prompt = "Analyze this file and give a brief summary of its contents: \(path)"
            setState(.thinking)
            appendOutput("⏳ Analyzing file via claude...\n")

            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.runCLI(cli: "claude", prompt: prompt)
            }
        }
    }

    // MARK: - Process Monitor

    func monitorProcesses() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let result = self?.shell("ps aux | grep -E '(claude|codex)' | grep -v grep | awk '{print $11, $12, $13}' 2>/dev/null") ?? ""
            DispatchQueue.main.async {
                let lines = result.trimmingCharacters(in: .whitespacesAndNewlines)
                if lines.isEmpty {
                    self?.appendColored("📊 No running claude/codex processes\n\n", color: self!.cDimGray)
                } else {
                    self?.appendColored("📊 Running processes:\n", color: self!.cCyan, bold: true)
                    for line in lines.components(separatedBy: "\n") {
                        self?.appendColored("  → \(line)\n", color: self!.cGray)
                    }
                    self?.appendOutput("\n")
                }
            }
        }
    }

    // MARK: - Send Prompt

    @objc func sendPrompt() {
        let prompt = inputField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }
        inputField.stringValue = ""
        lastInteraction = Date()
        if state == .sleeping { state = .idle }

        // Add to history
        commandHistory.append(prompt)
        historyIndex = commandHistory.count

        appendColored("❯ \(prompt)\n", color: cCyan, bold: true)

        // Built-in commands
        if handleBuiltinCommand(prompt) { return }

        // Determine CLI
        var cli = "claude"
        var actualPrompt = prompt

        if prompt.hasPrefix("!codex ") {
            cli = "codex"
            actualPrompt = String(prompt.dropFirst(7))
        } else if prompt.hasPrefix("!claude ") {
            actualPrompt = String(prompt.dropFirst(8))
        }

        let oldLevel = pet.level
        pet.onCommandRun()
        pet.save()
        refreshStatsDisplay()
        checkTimeAchievements()
        processAchievements()

        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Thinking: \(actualPrompt.prefix(28))...")
        appendColored("⏳ → \(cli)...\n", color: cDimGray)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: cli, prompt: actualPrompt, oldLevel: oldLevel)
        }
    }

    func handleBuiltinCommand(_ cmd: String) -> Bool {
        switch cmd {
        case "!clear":
            outputText.textStorage?.setAttributedString(NSAttributedString(string: ""))
            bubbleLabel.stringValue = speechBubble("Cleared!")
            playSound("Pop")
            return true

        case "!tip":
            let tip = AgentArt.tips.randomElement()!
            bubbleLabel.stringValue = speechBubble(tip)
            appendColored("💡 \(tip)\n\n", color: cYellow)
            return true

        case "!feed":
            feedPet()
            return true

        case "!play":
            playPet()
            return true

        case "!rest":
            restPet()
            return true

        case "!stats":
            showPetStats()
            return true

        case "!dance":
            doDance()
            if let a = pet.unlock("dance") {
                appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n\n", color: cYellow, bold: true)
            }
            return true

        case "!achievements", "!ach":
            showAchievements()
            return true

        case "!pomo", "!pomodoro":
            pomoStartWith(minutes: 25)
            return true

        case "!pomo10":
            pomoStartWith(minutes: 10)
            return true

        case "!break":
            pomodoro.startBreak(minutes: 5)
            pomoLabel.isHidden = false
            pomoLabel.stringValue = pomodoro.displayString
            pomodoro.onTick = { [weak self] display in
                DispatchQueue.main.async { self?.pomoLabel.stringValue = display }
            }
            pomodoro.onComplete = { [weak self] in
                DispatchQueue.main.async {
                    self?.pomoLabel.stringValue = "☕ Break over! Back to work!"
                    self?.bubbleLabel.stringValue = speechBubble("Break's over! Let's go!")
                    self?.playSound("Glass")
                    self?.sendNotification(title: "Break Over!", body: "Time to get back to work!")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        self?.pomoLabel.isHidden = true
                    }
                }
            }
            appendColored("☕ 5 min break started! Relax!\n\n", color: cCyan)
            bubbleLabel.stringValue = speechBubble("Break time! You earned it!")
            return true

        case "!stoptime", "!stoppomo":
            pomodoro.stop()
            pomoLabel.isHidden = true
            appendColored("🍅 Pomodoro stopped\n\n", color: cDimGray)
            return true

        case "!game":
            startNumberGame()
            return true

        case "!trivia":
            startTriviaGame()
            return true

        case "!paste":
            analyzeClipboard()
            return true

        case "!evo", "!evolution":
            let stage = Evolution.stage(for: pet.level)
            let title = Evolution.title(for: pet.level)
            appendColored("╭── Evolution ────────────────────────╮\n", color: cPurple)
            appendColored("  Current: \(title) (Stage: \(stage))\n", color: cCyan, bold: true)
            appendColored("  Level \(pet.level) → ", color: cGray)
            if pet.level < 5 {
                appendColored("Evolves at Lv.5\n", color: cYellow)
            } else if pet.level < 10 {
                appendColored("Next evolution at Lv.10\n", color: cYellow)
            } else if pet.level < 15 {
                appendColored("Next evolution at Lv.15\n", color: cYellow)
            } else if pet.level < 20 {
                appendColored("Next evolution at Lv.20\n", color: cYellow)
            } else {
                appendColored("MAX EVOLUTION!\n", color: cGreen, bold: true)
            }
            appendColored("  Stages: Baby → Evolved → Epic → Mythic → Cosmic\n", color: cDimGray)
            appendColored("╰────────────────────────────────────╯\n\n", color: cPurple)
            return true

        case "!git":
            quickGit()
            return true

        case "!ps":
            monitorProcesses()
            return true

        case "!help":
            showHelp()
            return true

        case "!history":
            appendColored("📜 Command history:\n", color: cCyan, bold: true)
            for (i, cmd) in commandHistory.dropLast().enumerated() {
                appendColored("  \(i+1). \(cmd)\n", color: cGray)
            }
            appendOutput("\n")
            return true

        default:
            // Skin change
            if cmd.hasPrefix("!skin ") {
                let skinName = String(cmd.dropFirst(6)).lowercased()
                if let skin = AgentSkin.allCases.first(where: { $0.rawValue.lowercased() == skinName }) {
                    currentSkin = skin
                    if !pet.triedSkins.contains(skin.rawValue) {
                        pet.triedSkins.append(skin.rawValue)
                    }
                    updateAgentDisplay()
                    bubbleLabel.stringValue = speechBubble("Skin: \(skin.rawValue) \(skin.mini)")
                    playSound("Pop")
                    appendColored("🎨 Skin changed to \(skin.rawValue)\n\n", color: cPurple)
                    processAchievements()
                    pet.save()
                } else {
                    appendColored("❌ Skins: robot, cat, skull, clippy\n\n", color: cRed)
                }
                return true
            }
            // Theme change
            if cmd.hasPrefix("!theme ") {
                let themeName = String(cmd.dropFirst(7)).lowercased()
                if let theme = Theme.all.first(where: { $0.name.lowercased() == themeName }) {
                    currentTheme = theme
                    applyTheme()
                    appendColored("🎨 Theme: \(theme.name)\n\n", color: theme.accentColor, bold: true)
                    playSound("Pop")
                } else {
                    appendColored("❌ Themes: matrix, cyberpunk, sunset, ocean, hacker\n\n", color: cRed)
                }
                return true
            }
            // Number game guess
            if cmd.hasPrefix("!guess ") {
                let num = String(cmd.dropFirst(7)).trimmingCharacters(in: .whitespaces)
                if handleGuess(num) { return true }
            }
            // Trivia answer
            if cmd.hasPrefix("!answer ") {
                let ans = String(cmd.dropFirst(8)).trimmingCharacters(in: .whitespaces)
                if handleTriviaAnswer(ans) { return true }
            }
            // Bare number during game
            if gameActive, let _ = Int(cmd) {
                if handleGuess(cmd) { return true }
            }
            return false
        }
    }

    // MARK: - Quick Actions

    @objc func quickCommit() {
        lastInteraction = Date()
        pet.onCommit()
        pet.save()
        refreshStatsDisplay()
        appendColored("❯ !commit\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Preparing commit...")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: "Look at git diff and git status, suggest a commit with a good message. If everything looks good, make the commit.")
        }
    }

    @objc func quickTest() {
        lastInteraction = Date()
        appendColored("❯ !test\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Running tests...")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: "Find and run tests in the current project. Show the results.")
        }
    }

    @objc func quickExplain() {
        lastInteraction = Date()
        appendColored("❯ !explain\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Looking for errors...")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: "Look at recent errors in the terminal or project logs and explain what went wrong and how to fix it.")
        }
    }

    @objc func quickReview() {
        lastInteraction = Date()
        appendColored("❯ !review\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Running code review...")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: "Do a code review of recent changes (git diff). Point out issues, improvements, and bugs.")
        }
    }

    @objc func quickGit() {
        lastInteraction = Date()
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let status = self?.shell("cd ~ && git status 2>/dev/null || echo 'Not a git repository'") ?? "N/A"
            let branch = self?.shell("cd ~ && git branch --show-current 2>/dev/null") ?? "N/A"
            let log = self?.shell("cd ~ && git log --oneline -5 2>/dev/null") ?? "N/A"
            DispatchQueue.main.async {
                self?.appendColored("📂 Git Status\n", color: self!.cCyan, bold: true)
                self?.appendColored("Branch: \(branch.trimmingCharacters(in: .whitespacesAndNewlines))\n", color: self!.cYellow)
                self?.appendOutput(status)
                self?.appendColored("\n📜 Recent commits:\n", color: self!.cCyan, bold: true)
                self?.appendOutput(log + "\n\n")
                self?.refreshGitStatus()
            }
        }
    }

    @objc func doDance() {
        setState(.dancing)
        bubbleLabel.stringValue = speechBubble("Dancing! Yooo!")
        playSound("Funk")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.state = .idle
            self?.bubbleLabel.stringValue = speechBubble("Phew! That was fun!")
        }
    }

    // MARK: - Run CLI

    func runCLI(cli: String, prompt: String, oldLevel: Int = 0) {
        let process = Process()
        let pipe = Pipe()

        // Use shell to get proper PATH
        process.executableURL = URL(fileURLWithPath: "/bin/zsh")
        let escapedPrompt = prompt
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
            .replacingOccurrences(of: "$", with: "\\$")
            .replacingOccurrences(of: "`", with: "\\`")

        if cli == "codex" {
            process.arguments = ["-l", "-c", "codex -q \"\(escapedPrompt)\""]
        } else {
            process.arguments = ["-l", "-c", "claude -p \"\(escapedPrompt)\""]
        }

        process.standardOutput = pipe
        process.standardError = pipe
        var env = ProcessInfo.processInfo.environment
        env.removeValue(forKey: "CLAUDECODE")
        process.environment = env
        currentProcess = process

        do {
            try process.run()
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.appendColored("❌ Error: \(error.localizedDescription)\n\n", color: self!.cRed)
                self?.setState(.error, duration: 3)
                self?.bubbleLabel.stringValue = speechBubble("Oops, can't launch \(cli)!")
                self?.playSound("Basso")
            }
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.setState(.typing)
        }

        let fileHandle = pipe.fileHandleForReading
        fileHandle.readabilityHandler = { [weak self] handle in
            let data = handle.availableData
            if data.isEmpty {
                handle.readabilityHandler = nil
                return
            }
            if let str = String(data: data, encoding: .utf8) {
                self?.appendOutput(str)
            }
        }

        process.waitUntilExit()
        currentProcess = nil

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.appendOutput("\n")
            if process.terminationStatus == 0 {
                self.pet.onCommandSuccess()
                self.pet.save()
                self.refreshStatsDisplay()
                self.checkLevelUp(oldLevel: oldLevel)
                self.setState(.happy, duration: 3)
                self.bubbleLabel.stringValue = speechBubble("Done! +XP! What's next?")
                self.playSound("Glass")
            } else {
                self.setState(.error, duration: 3)
                self.bubbleLabel.stringValue = speechBubble("Execution error. Try a different approach?")
                self.playSound("Basso")
            }
            self.refreshGitStatus()
        }
    }

    // MARK: - Shell Helper

    func shell(_ command: String) -> String? {
        let process = Process()
        let pipe = Pipe()
        process.executableURL = URL(fileURLWithPath: "/bin/zsh")
        process.arguments = ["-l", "-c", command]
        process.standardOutput = pipe
        process.standardError = pipe
        var env = ProcessInfo.processInfo.environment
        env.removeValue(forKey: "CLAUDECODE")
        process.environment = env
        do {
            try process.run()
            process.waitUntilExit()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }

    // MARK: - Welcome & Help

    func showWelcome() {
        bubbleLabel.stringValue = speechBubble("Hey! I'm Agent-O v2! Cmd+Shift+O toggle!")
        updateAgentDisplay()

        appendColored("╔═══════════════════════════════════════╗\n", color: cCyan)
        appendColored("║      Agent-O v2.0  Terminal           ║\n", color: cCyan)
        appendColored("║  Claude/Codex Assistant + Tamagotchi  ║\n", color: cCyan)
        appendColored("╚═══════════════════════════════════════╝\n\n", color: cCyan)
        if pet.streak > 1 {
            appendColored("🔥 Welcome back! Streak: \(pet.streak) days! +20 XP\n\n", color: cOrange, bold: true)
        }
        appendColored("  ⌘⇧O   ", color: cYellow, bold: true)
        appendOutput("show/hide window\n")
        appendColored("  ↑↓    ", color: cYellow, bold: true)
        appendOutput("command history\n")
        appendColored("  D&D   ", color: cYellow, bold: true)
        appendOutput("drag & drop file to analyze\n\n")
        appendColored("  !help ", color: cGreen, bold: true)
        appendOutput("all commands\n\n")
    }

    func showHelp() {
        appendColored("╭── Commands ─────────────────────────╮\n", color: cCyan)
        appendColored("  CLI\n", color: cPurple, bold: true)
        let cliCmds: [(String, String)] = [
            ("text", "→ send to Claude"),
            ("!claude <p>", "→ explicitly to Claude CLI"),
            ("!codex <p>", "→ explicitly to Codex CLI"),
            ("!paste", "→ analyze clipboard content"),
        ]
        for (cmd, desc) in cliCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Tamagotchi\n", color: cPurple, bold: true)
        let petCmds: [(String, String)] = [
            ("!feed", "→ feed Agent-O (+Food)"),
            ("!play", "→ play with Agent-O (+Joy)"),
            ("!rest", "→ let Agent-O rest (+Energy)"),
            ("!stats", "→ full pet stats"),
            ("!evo", "→ evolution stage info"),
            ("!ach", "→ achievements list"),
        ]
        for (cmd, desc) in petCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Fun & Focus\n", color: cPurple, bold: true)
        let funCmds: [(String, String)] = [
            ("!game", "→ number guessing game"),
            ("!trivia", "→ dev trivia quiz"),
            ("!dance", "→ let's dance!"),
            ("!pomo", "→ 25 min pomodoro timer"),
            ("!pomo10", "→ 10 min pomodoro"),
            ("!break", "→ 5 min break timer"),
            ("!stoppomo", "→ stop timer"),
        ]
        for (cmd, desc) in funCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Customization\n", color: cPurple, bold: true)
        let custCmds: [(String, String)] = [
            ("!skin <name>", "→ robot/cat/skull/clippy"),
            ("!theme <name>", "→ matrix/cyberpunk/sunset/ocean/hacker"),
        ]
        for (cmd, desc) in custCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Tools\n", color: cPurple, bold: true)
        let toolCmds: [(String, String)] = [
            ("!git", "→ git project status"),
            ("!ps", "→ monitor processes"),
            ("!tip", "→ random tip"),
            ("!history", "→ command history"),
            ("!clear", "→ clear output"),
        ]
        for (cmd, desc) in toolCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("╰─────────────────────────────────────╯\n", color: cCyan)
        appendColored("\nButtons: ", color: cPurple, bold: true)
        appendOutput("Commit · Tests · Explain · Review\n")
        appendColored("Hotkey: ", color: cPurple, bold: true)
        appendOutput("⌘⇧O toggle, ↑↓ history, Drag&Drop files\n\n")
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false // keep running in menu bar
    }
}

// MARK: - Main

let app = NSApplication.shared
let delegate = AgentODelegate()
app.delegate = delegate
app.run()
