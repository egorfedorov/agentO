import AppKit
import Foundation
import Carbon.HIToolbox

final class InputTextField: NSTextField {
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        if event.type == .keyDown,
           flags == .command,
           event.charactersIgnoringModifiers?.lowercased() == "a",
           let editor = window?.fieldEditor(true, for: self) as? NSTextView {
            editor.selectAll(nil)
            return true
        }
        return super.performKeyEquivalent(with: event)
    }
}

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
            "        ┌┤██├┐        ",
            "    ┌───┤ ▓▓ ├───┐    ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ●   ● ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ └───┘ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──────┘    ",
            "     ┌─────┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ ░░░░░░░░░ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐      ",
            "       █       █      ",
        ]
        static let idle2 = [
            "        ┌┤██├┐        ",
            "    ┌───┤ ▓▓ ├───┐    ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ●   ● ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ └───┘ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──────┘    ",
            "     ┌─────┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ ░░░░░░░░░ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐      ",
            "       █       █      ",
        ]
        static let think1 = [
            "        ┌┤██├┐  ○     ",
            "    ┌───┤ ▓▓ ├──○┐    ",
            "    │ ╔═══════╗○ │    ",
            "    │ ║ ◐   ◐ ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ └~~~┘ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──────┘    ",
            "     ┌─────┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ ░▒▓█▓▒░░░ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐      ",
            "       █       █      ",
        ]
        static let think2 = [
            "        ┌┤██├┐   ○    ",
            "    ┌───┤ ▓▓ ├───┐○   ",
            "    │ ╔═══════╗  │ ○  ",
            "    │ ║ ◐   ◐ ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ └~~~┘ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──────┘    ",
            "     ┌─────┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ ░░░▒▓█▓▒░ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐      ",
            "       █       █      ",
        ]
        static let happy = [
            "        ┌┤██├┐  *     ",
            "    ┌───┤ ▓▓ ├───┐ *  ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ^   ^ ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ ╰▽▽▽╯ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──┐   ┌──────┘    ",
            "     ┌─┴───┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ █████████ │    ",
            "     └─────┬─────┘    ",
            "      ╱┌───┴───┐╲    ",
            "     ╱  █       █ ╲   ",
        ]
        static let sleep1 = [
            "        ┌┤██├┐   z    ",
            "    ┌───┤ ▓▓ ├──z┐    ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ─   ─ ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ └───┘ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──────┘    ",
            "     ┌─────┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ ░░░░░░░░░ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐      ",
            "       █       █      ",
        ]
        static let sleep2 = [
            "        ┌┤██├┐  Z     ",
            "    ┌───┤ ▓▓ ├───┐    ",
            "    │ ╔═══════╗ z│    ",
            "    │ ║ ─   ─ ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ └───┘ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──────┘    ",
            "     ┌─────┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ ░░░░░░░░░ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐      ",
            "       █       █      ",
        ]
        static let error = [
            "        ┌┤██├┐  !     ",
            "    ┌───┤ ▓▓ ├───┐    ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ✖   ✖ ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ ╰═══╯ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──────┘    ",
            "     ┌─────┴─────┐    ",
            "     │! AGENT-O !│    ",
            "     │ ▓▓▓▓▓▓▓▓▓ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐      ",
            "       █       █      ",
        ]
        static let type1 = [
            "        ┌┤██├┐        ",
            "    ┌───┤ ▓▓ ├───┐    ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ●   ● ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ └───┘ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──┐───┬──────┘    ",
            "     ┌─┴───┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ ░▒▓░▒▓░▒░ │    ",
            "     └─────┬─────┘    ",
            "     ⌨ ┌───┴───┐      ",
            "       █       █      ",
        ]
        static let type2 = [
            "        ┌┤██├┐        ",
            "    ┌───┤ ▓▓ ├───┐    ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ●   ● ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ └───┘ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──┐───┘    ",
            "     ┌─────┴──┴──┐    ",
            "     │  AGENT-O  │    ",
            "     │ ░▒░▓▒░▓░░ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐ ⌨    ",
            "       █       █      ",
        ]
        static let dance1 = [
            "        ┌┤██├┐  *     ",
            "    ┌───┤ ▓▓ ├───┐    ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ^   ^ ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ ╰▽▽▽╯ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "   ╱└──────┬──────┘    ",
            "  ╱  ┌─────┴─────┐    ",
            "     │  AGENT-O  │    ",
            "     │ █████████ │    ",
            "     └─────┬─────┘    ",
            "      ╱┌───┴───┐      ",
            "     ╱  █       █      ",
        ]
        static let dance2 = [
            "     *  ┌┤██├┐        ",
            "    ┌───┤ ▓▓ ├───┐    ",
            "    │ ╔═══════╗  │    ",
            "    │ ║ ^   ^ ║  │    ",
            "    │ ║   ═   ║  │    ",
            "    │ ║ ╰▽▽▽╯ ║  │    ",
            "    │ ╚═══════╝  │    ",
            "    └──────┬──────┘╲   ",
            "     ┌─────┴─────┐  ╲  ",
            "     │  AGENT-O  │    ",
            "     │ █████████ │    ",
            "     └─────┬─────┘    ",
            "       ┌───┴───┐╲    ",
            "       █       █  ╲   ",
        ]
        static let dance3 = happy
    }

    struct Cat {
        static let idle1 = [
            "        ∧  ∧          ",
            "       (● ω ●)        ",
            "      ╭┤     ├╮       ",
            "      │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │MEOW-O│       ",
            "       │░░░░░░│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲         ",
            "       ╱     ╲        ",
            "      █       █       ",
            "              ∫       ",
            "              ∫~      ",
        ]
        static let idle2 = [
            "        ∧  ∧          ",
            "       (● ω ●)        ",
            "      ╭┤     ├╮       ",
            "      │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │MEOW-O│       ",
            "       │░░░░░░│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲         ",
            "       ╱     ╲        ",
            "      █       █       ",
            "              ∫~      ",
            "              ∫       ",
        ]
        static let think1 = [
            "        ∧  ∧    ○     ",
            "       (◐ ω ◐)  ○     ",
            "      ╭┤     ├╮○      ",
            "      │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │MEOW-O│       ",
            "       │▒▓▒▓▒▓│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲         ",
            "       ╱     ╲        ",
            "      █       █       ",
            "              ∫       ",
            "              ∫~      ",
        ]
        static let think2 = [
            "        ∧  ∧     ○    ",
            "       (◐ ω ◐)    ○   ",
            "      ╭┤     ├╮    ○  ",
            "      │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │MEOW-O│       ",
            "       │▓▒▓▒▓▒│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲         ",
            "       ╱     ╲        ",
            "      █       █       ",
            "              ∫~      ",
            "              ∫       ",
        ]
        static let happy = [
            "        ∧  ∧   *      ",
            "       (^ ω ^)  *     ",
            "      ╭┤     ├╮       ",
            "      │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "     ╱╰┬─────┬╯╲     ",
            "    ╱  │MEOW-O│  ╲    ",
            "       │██████│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲         ",
            "       ╱     ╲        ",
            "      █       █       ",
            "              ∫       ",
            "              ~∫~     ",
        ]
        static let sleep1 = [
            "        ∧  ∧   z      ",
            "       (─ ω ─) z      ",
            "      ╭┤     ├╮       ",
            "      │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │MEOW-O│       ",
            "       │░░░░░░│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲         ",
            "       ╱     ╲        ",
            "      █       █       ",
            "              ∫       ",
            "              ∫       ",
        ]
        static let sleep2 = [
            "        ∧  ∧  Z       ",
            "       (─ ω ─)  z     ",
            "      ╭┤     ├╮       ",
            "      │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │MEOW-O│       ",
            "       │░░░░░░│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲         ",
            "       ╱     ╲        ",
            "      █       █       ",
            "              ∫       ",
            "              ∫       ",
        ]
        static let error = [
            "        ∧  ∧   !      ",
            "       (✖ ω ✖)        ",
            "      ╭┤     ├╮       ",
            "      │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │!MEOW!│       ",
            "       │▓▓▓▓▓▓│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲         ",
            "       ╱     ╲        ",
            "      █       █       ",
            "              ∫       ",
            "             ~∫!      ",
        ]
        static let type1 = idle1
        static let type2 = idle2
        static let dance1 = [
            "        ∧  ∧   *      ",
            "       (^ ω ^)        ",
            "     ╱╭┤     ├╮       ",
            "    ╱ │ ╲   ╱ │       ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │MEOW-O│       ",
            "       │██████│       ",
            "       ╰──┬──╯        ",
            "       ╱╱   ╲         ",
            "      ╱╱     ╲        ",
            "      █       █       ",
            "              ∫       ",
            "             ~∫~      ",
        ]
        static let dance2 = [
            "     *  ∧  ∧          ",
            "       (^ ω ^)        ",
            "      ╭┤     ├╮╲     ",
            "      │ ╲   ╱ │ ╲    ",
            "      │  ═══  │       ",
            "      ╰┬─────┬╯       ",
            "       │MEOW-O│       ",
            "       │██████│       ",
            "       ╰──┬──╯        ",
            "        ╱   ╲╲       ",
            "       ╱     ╲╲      ",
            "      █       █       ",
            "              ∫       ",
            "             ~∫~      ",
        ]
        static let dance3 = happy
    }

    struct Skull {
        static let idle1 = [
            "      ╱ ▀▀▀▀▀ ╲      ",
            "     ╱ ░░░░░░░░ ╲     ",
            "    │  ◉      ◉  │    ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║█║█║█║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "      ╲▁▁▁▁▁▁▁▁╱     ",
            "     ┌────┴────┐      ",
            "     │ SKULL-O │      ",
            "     │ ▓▓▓▓▓▓▓ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐        ",
            "       █     █        ",
        ]
        static let idle2 = [
            "      ╱ ▀▀▀▀▀ ╲      ",
            "     ╱ ░░░░░░░░ ╲     ",
            "    │  ◉      ◉  │    ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║█║█║█║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "      ╲▁▁▁▁▁▁▁▁╱     ",
            "     ┌────┴────┐      ",
            "     │ SKULL-O │      ",
            "     │ ▓▓▓▓▓▓▓ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐        ",
            "       █     █        ",
        ]
        static let think1 = [
            "      ╱ ▀▀▀▀▀ ╲  ○   ",
            "     ╱ ░░░░░░░░ ╲○    ",
            "    │  ◐      ◐  │    ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║~║~║~║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "      ╲▁▁▁▁▁▁▁▁╱     ",
            "     ┌────┴────┐      ",
            "     │ SKULL-O │      ",
            "     │ ░▒▓█▓▒░ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐        ",
            "       █     █        ",
        ]
        static let think2 = [
            "      ╱ ▀▀▀▀▀ ╲   ○  ",
            "     ╱ ░░░░░░░░ ╲  ○  ",
            "    │  ◐      ◐  │ ○  ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║~║~║~║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "      ╲▁▁▁▁▁▁▁▁╱     ",
            "     ┌────┴────┐      ",
            "     │ SKULL-O │      ",
            "     │ ▓▒░▒▓█▒ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐        ",
            "       █     █        ",
        ]
        static let happy = [
            "      ╱ ▀▀▀▀▀ ╲  *   ",
            "     ╱ ░░░░░░░░ ╲     ",
            "    │  ^      ^  │    ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║▽║▽║▽║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "    ╱ ╲▁▁▁▁▁▁▁▁╱ ╲   ",
            "   ╱ ┌────┴────┐  ╲   ",
            "     │ SKULL-O │      ",
            "     │ ███████ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐        ",
            "       █     █        ",
        ]
        static let sleep1 = [
            "      ╱ ▀▀▀▀▀ ╲  z   ",
            "     ╱ ░░░░░░░░ ╲z    ",
            "    │  ─      ─  │    ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║█║█║█║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "      ╲▁▁▁▁▁▁▁▁╱     ",
            "     ┌────┴────┐      ",
            "     │ SKULL-O │      ",
            "     │ ░░░░░░░ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐        ",
            "       █     █        ",
        ]
        static let sleep2 = [
            "      ╱ ▀▀▀▀▀ ╲ Z    ",
            "     ╱ ░░░░░░░░ ╲     ",
            "    │  ─      ─  │ z  ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║█║█║█║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "      ╲▁▁▁▁▁▁▁▁╱     ",
            "     ┌────┴────┐      ",
            "     │ SKULL-O │      ",
            "     │ ░░░░░░░ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐        ",
            "       █     █        ",
        ]
        static let error = [
            "      ╱ ▀▀▀▀▀ ╲  !   ",
            "     ╱ ░░░░░░░░ ╲     ",
            "    │  ✖      ✖  │    ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║═║═║═║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "      ╲▁▁▁▁▁▁▁▁╱     ",
            "     ┌────┴────┐      ",
            "     │!SKULL-O!│      ",
            "     │ ▓▓▓▓▓▓▓ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐        ",
            "       █     █        ",
        ]
        static let type1 = idle1
        static let type2 = idle2
        static let dance1 = happy
        static let dance2 = [
            "   *  ╱ ▀▀▀▀▀ ╲      ",
            "     ╱ ░░░░░░░░ ╲     ",
            "    │  ^      ^  │    ",
            "    │      ▼      │    ",
            "    │   ╔═════╗   │    ",
            "    │   ║▽║▽║▽║   │    ",
            "     ╲  ╚═════╝  ╱    ",
            "      ╲▁▁▁▁▁▁▁▁╱ ╲   ",
            "     ┌────┴────┐  ╲   ",
            "     │ SKULL-O │      ",
            "     │ ███████ │      ",
            "     └────┬────┘      ",
            "       ┌──┴──┐ ╲     ",
            "       █     █   ╲   ",
        ]
        static let dance3 = happy
    }

    struct Clippy {
        static let idle1 = [
            "       ╭─────╮        ",
            "       │ ╭─╮ │        ",
            "       │ │●│ │        ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       │ ◉ ◉ │        ",
            "       │  ▽  │        ",
            "       │╰───╯│        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       ╰─────╯        ",
        ]
        static let idle2 = [
            "       ╭─────╮        ",
            "       │ ╭─╮ │        ",
            "       │ │●│ │        ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "         ╱            ",
            "       ╭─┴───╮        ",
            "       │ ◉ ◉ │        ",
            "       │  ▽  │        ",
            "       │╰───╯│        ",
            "       ╰──┬──╯        ",
            "         ╱            ",
            "       ╭─┴───╮        ",
            "       ╰─────╯        ",
        ]
        static let think1 = [
            "       ╭─────╮   ○    ",
            "       │ ╭─╮ │  ○     ",
            "       │ │●│ │ ○      ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       │ ◐ ◐ │        ",
            "       │  ▽  │        ",
            "       │╰~~~╯│        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       ╰─────╯        ",
        ]
        static let think2 = [
            "       ╭─────╮    ○   ",
            "       │ ╭─╮ │   ○    ",
            "       │ │●│ │  ○     ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       │ ◐ ◐ │        ",
            "       │  ▽  │        ",
            "       │╰~~~╯│        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       ╰─────╯        ",
        ]
        static let happy = [
            "       ╭─────╮  *     ",
            "       │ ╭─╮ │   *    ",
            "       │ │●│ │        ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       │ ^ ^ │        ",
            "       │  ▽  │        ",
            "       │╰▽▽▽╯│        ",
            "       ╰──┬──╯        ",
            "        ╲ │ ╱         ",
            "       ╭──┴──╮        ",
            "       ╰─────╯        ",
        ]
        static let sleep1 = [
            "       ╭─────╮  z     ",
            "       │ ╭─╮ │ z      ",
            "       │ │●│ │        ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       │ ─ ─ │        ",
            "       │  ▽  │        ",
            "       │╰───╯│        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       ╰─────╯        ",
        ]
        static let sleep2 = [
            "       ╭─────╮ Z      ",
            "       │ ╭─╮ │        ",
            "       │ │●│ │  z     ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       │ ─ ─ │        ",
            "       │  ▽  │        ",
            "       │╰───╯│        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       ╰─────╯        ",
        ]
        static let error = [
            "       ╭─────╮  !     ",
            "       │ ╭─╮ │        ",
            "       │ │●│ │  !     ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       │ ✖ ✖ │        ",
            "       │  ▽  │        ",
            "       │╰═══╯│        ",
            "       ╰──┬──╯        ",
            "          │           ",
            "       ╭──┴──╮        ",
            "       ╰─────╯        ",
        ]
        static let type1 = idle1
        static let type2 = idle2
        static let dance1 = [
            "       ╭─────╮  *     ",
            "       │ ╭─╮ │        ",
            "       │ │●│ │        ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "         ╱            ",
            "       ╭─┴───╮        ",
            "       │ ^ ^ │        ",
            "       │  ▽  │        ",
            "       │╰▽▽▽╯│        ",
            "       ╰──┬──╯        ",
            "         ╱            ",
            "       ╭─┴───╮        ",
            "       ╰─────╯        ",
        ]
        static let dance2 = [
            "     *  ╭─────╮       ",
            "       │ ╭─╮ │        ",
            "       │ │●│ │        ",
            "       │ ╰─╯ │        ",
            "       ╰──┬──╯        ",
            "           ╲          ",
            "       ╭───┴─╮        ",
            "       │ ^ ^ │        ",
            "       │  ▽  │        ",
            "       │╰▽▽▽╯│        ",
            "       ╰──┬──╯        ",
            "           ╲          ",
            "       ╭───┴─╮        ",
            "       ╰─────╯        ",
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
        "Try: codex exec for non-interactive mode",
        "Hint: CLAUDE.md file for project instructions",
        "Tip: /cost in claude to check spending",
        "Try: Cmd+Shift+O to show/hide window",
        "Hint: drag & drop a file for analysis!",
        "Tip: up/down arrows for command history",
        "Try: /dance to see a dance!",
        "Hint: /skin cat to change skin",
        "Tip: /git to show project status",
        "Try: /ps to monitor processes",
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

// MARK: - Localization

enum Lang: String {
    case en = "en"
    case ru = "ru"
}

class L10n {
    static var lang: Lang = .en

    static let strings: [String: [Lang: String]] = [
        // General
        "welcome":          [.en: "Hey! I'm Agent-O v2!", .ru: "Привет! Я Agent-O v2!"],
        "toggle_hint":      [.en: "Cmd+Shift+O toggle!", .ru: "Cmd+Shift+O показать/скрыть!"],
        "placeholder":      [.en: "Ask Agent-O anything... (Cmd+Shift+O toggle)", .ru: "Задай вопрос Agent-O... (Cmd+Shift+O toggle)"],
        "cleared":          [.en: "Cleared!", .ru: "Очищено!"],
        "done_xp":          [.en: "Done! +XP! What's next?", .ru: "Готово! +XP! Что дальше?"],
        "done":             [.en: "Done! What's next?", .ru: "Готово! Что дальше?"],
        "error_exec":       [.en: "Execution error. Try a different approach?", .ru: "Ошибка. Попробуем иначе?"],
        "error_launch":     [.en: "Oops, can't launch", .ru: "Упс, не могу запустить"],
        "thinking":         [.en: "Thinking:", .ru: "Думаю:"],

        // Pet
        "feed_msg":         [.en: "Yum! That was delicious! +25 Food", .ru: "Ням! Вкуснятина! +25 Еда"],
        "fed":              [.en: "Fed Agent-O! Food:", .ru: "Agent-O накормлен! Еда:"],
        "play_msg":         [.en: "Wheee! So fun! +20 Joy", .ru: "Ура! Весело! +20 Радость"],
        "played":           [.en: "Played with Agent-O! Joy:", .ru: "Поиграли с Agent-O! Радость:"],
        "rest_msg":         [.en: "Zzz... recharging... +30 Energy", .ru: "Zzz... заряжаюсь... +30 Энергия"],
        "resting":          [.en: "Agent-O is resting! Energy:", .ru: "Agent-O отдыхает! Энергия:"],
        "hungry":           [.en: "I'm hungry! Type /feed to feed me!", .ru: "Я голоден! Напиши /feed чтобы покормить!"],
        "sad":              [.en: "I'm sad... Type /play to cheer me up!", .ru: "Мне грустно... Напиши /play!"],
        "tired":            [.en: "So tired... Type /rest to let me rest!", .ru: "Устал... Напиши /rest чтобы отдохнуть!"],
        "sleep":            [.en: "Zzz... wake me up with a task...", .ru: "Zzz... разбуди меня задачей..."],

        // Quick actions
        "prep_commit":      [.en: "Preparing commit...", .ru: "Готовлю коммит..."],
        "run_tests":        [.en: "Running tests...", .ru: "Запускаю тесты..."],
        "find_errors":      [.en: "Looking for errors...", .ru: "Ищу ошибки..."],
        "code_review":      [.en: "Running code review...", .ru: "Делаю код-ревью..."],

        // Claude prompts
        "prompt_commit":    [.en: "Look at git diff and git status, suggest a commit with a good message. If everything looks good, make the commit.",
                             .ru: "Посмотри git diff и git status, предложи коммит с хорошим сообщением. Если всё хорошо — сделай коммит."],
        "prompt_test":      [.en: "Find and run tests in the current project. Show the results.",
                             .ru: "Найди и запусти тесты в текущем проекте. Покажи результат."],
        "prompt_explain":   [.en: "Look at recent errors in the terminal or project logs and explain what went wrong and how to fix it.",
                             .ru: "Посмотри последние ошибки в терминале или логах и объясни что пошло не так и как починить."],
        "prompt_review":    [.en: "Do a code review of recent changes (git diff). Point out issues, improvements, and bugs.",
                             .ru: "Сделай код-ревью последних изменений (git diff). Укажи проблемы, улучшения, баги."],
        "prompt_analyze":   [.en: "Analyze this file and give a brief summary of its contents:",
                             .ru: "Проанализируй этот файл и дай краткое описание:"],
        "prompt_clipboard": [.en: "Analyze this code/text and explain what it does. Be brief:",
                             .ru: "Проанализируй этот код/текст и объясни что он делает. Кратко:"],

        // Games
        "dance_msg":        [.en: "Dancing! Yooo!", .ru: "Танцую! Йоу!"],
        "dance_done":       [.en: "Phew! That was fun!", .ru: "Фух! Хорошо потанцевали!"],
        "game_guess":       [.en: "Let's play! Guess my number 1-100!", .ru: "Играем! Угадай число 1-100!"],
        "higher":           [.en: "Higher! Try again!", .ru: "Выше! Попробуй ещё!"],
        "lower":            [.en: "Lower! Try again!", .ru: "Ниже! Попробуй ещё!"],
        "correct":          [.en: "You win!", .ru: "Ты выиграл!"],
        "trivia_q":         [.en: "Trivia time! Pick the right answer!", .ru: "Викторина! Выбери правильный ответ!"],
        "big_brain":        [.en: "Big brain! Correct!", .ru: "Красавчик! Верно!"],

        // Pomodoro
        "pomo_start":       [.en: "Focus mode!", .ru: "Режим фокуса!"],
        "pomo_done":        [.en: "Pomodoro done! Great focus!", .ru: "Помодоро завершён! Отличный фокус!"],
        "break_over":       [.en: "Break's over! Let's go!", .ru: "Перерыв окончен! Поехали!"],
        "break_msg":        [.en: "Break time! You earned it!", .ru: "Перерыв! Ты заслужил!"],

        // Misc
        "analyzing":        [.en: "Analyzing", .ru: "Анализирую"],
        "analyzing_clip":   [.en: "Analyzing clipboard...", .ru: "Анализирую буфер..."],
        "no_processes":     [.en: "No running claude/codex processes", .ru: "Нет запущенных процессов claude/codex"],
        "running_proc":     [.en: "Running processes:", .ru: "Запущенные процессы:"],
        "cmd_history":      [.en: "Command history:", .ru: "История команд:"],
        "skin_changed":     [.en: "Skin changed to", .ru: "Скин изменён на"],
        "skins_list":       [.en: "Skins: robot, cat, skull, clippy", .ru: "Скины: robot, cat, skull, clippy"],
        "themes_list":      [.en: "Themes: matrix, cyberpunk, sunset, ocean, hacker", .ru: "Темы: matrix, cyberpunk, sunset, ocean, hacker"],
        "theme_changed":    [.en: "Theme:", .ru: "Тема:"],
        "levelup":          [.en: "LEVEL UP! I'm Level", .ru: "УРОВЕНЬ! Я теперь"],
        "streak_back":      [.en: "Welcome back! Streak:", .ru: "С возвращением! Стрик:"],
        "achievement":      [.en: "ACHIEVEMENT UNLOCKED:", .ru: "ДОСТИЖЕНИЕ РАЗБЛОКИРОВАНО:"],
        "ach_unlocked":     [.en: "unlocked", .ru: "открыто"],
        "lang_switched":    [.en: "Language: English", .ru: "Язык: Русский"],

        // Stats
        "s_food":           [.en: "Food", .ru: "Еда "],
        "s_joy":            [.en: "Joy ", .ru: "Рад."],
        "s_nrg":            [.en: "Nrg ", .ru: "Энр."],
        "s_thriving":       [.en: "Thriving!", .ru: "Процветает!"],
        "s_happy":          [.en: "Happy", .ru: "Доволен"],
        "s_okay":           [.en: "Okay...", .ru: "Норм..."],
        "s_sad":            [.en: "Sad", .ru: "Грустит"],
        "s_critical":       [.en: "Critical!", .ru: "Критично!"],
    ]

    static func t(_ key: String) -> String {
        return strings[key]?[lang] ?? strings[key]?[.en] ?? key
    }
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
        return (answer, "I'm thinking of a number between 1 and 100. Type /guess <number>")
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
    var language: String = "en"
    var battlesWon: Int = 0
    var battlesLost: Int = 0
    var battleHistory: [[String: Any]] = []  // last 20 battles
    var inventory: [String] = []  // unlocked items
    var dailyQuestsDate: String = ""
    var dailyQuestsProgress: [String: Int] = [:]  // quest_id -> progress
    var dailyQuestsCompleted: [String] = []
    var hasCompletedOnboarding: Bool = false
    var leaderboardUsername: String = ""
    var leaderboardToken: String = ""

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
            "pomodorosCompleted": pomodorosCompleted,
            "language": language,
            "battlesWon": battlesWon,
            "battlesLost": battlesLost,
            "battleHistory": battleHistory,
            "inventory": inventory,
            "dailyQuestsDate": dailyQuestsDate,
            "dailyQuestsProgress": dailyQuestsProgress,
            "dailyQuestsCompleted": dailyQuestsCompleted,
            "hasCompletedOnboarding": hasCompletedOnboarding,
            "leaderboardUsername": leaderboardUsername,
            "leaderboardToken": leaderboardToken
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
        stats.language = dict["language"] as? String ?? "en"
        stats.battlesWon = dict["battlesWon"] as? Int ?? 0
        stats.battlesLost = dict["battlesLost"] as? Int ?? 0
        stats.battleHistory = dict["battleHistory"] as? [[String: Any]] ?? []
        stats.inventory = dict["inventory"] as? [String] ?? []
        stats.dailyQuestsDate = dict["dailyQuestsDate"] as? String ?? ""
        stats.dailyQuestsProgress = dict["dailyQuestsProgress"] as? [String: Int] ?? [:]
        stats.dailyQuestsCompleted = dict["dailyQuestsCompleted"] as? [String] ?? []
        stats.hasCompletedOnboarding = dict["hasCompletedOnboarding"] as? Bool ?? false
        stats.leaderboardUsername = dict["leaderboardUsername"] as? String ?? ""
        stats.leaderboardToken = dict["leaderboardToken"] as? String ?? ""

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

// MARK: - Pet Brain

class PetBrain {
    static let savePath = NSHomeDirectory() + "/.agento_brain.json"

    var facts: [String] = []
    var languages: [String] = []
    var frameworks: [String] = []
    var patterns: [String: Int] = [:]
    var lastTopics: [String] = []

    func learn(from prompt: String) {
        let langMap: [(String, [String])] = [
            ("Swift", ["swift", ".swift", "swiftui", "uikit", "appkit"]),
            ("Python", ["python", ".py", "pip", "django", "flask", "pandas"]),
            ("JavaScript", ["javascript", "js", "node", "react", "vue", "angular", "npm"]),
            ("TypeScript", ["typescript", "ts", ".tsx", "angular", "next.js"]),
            ("Rust", ["rust", "cargo", ".rs", "tokio"]),
            ("Go", ["golang", "go mod", ".go", "goroutine"]),
            ("C++", ["c++", "cpp", "cmake", "iostream"]),
            ("Ruby", ["ruby", ".rb", "rails", "gem"]),
            ("Java", ["java", "spring", "gradle", "maven"]),
            ("Kotlin", ["kotlin", ".kt", "android"]),
        ]
        let lower = prompt.lowercased()
        for (lang, keywords) in langMap {
            if keywords.contains(where: { lower.contains($0) }) && !languages.contains(lang) {
                languages.append(lang)
            }
        }

        let fwMap: [(String, [String])] = [
            ("React", ["react", "jsx", "usestate", "useeffect"]),
            ("Next.js", ["next.js", "nextjs", "getserverside"]),
            ("SwiftUI", ["swiftui", "@state", "@binding"]),
            ("Django", ["django", "models.py", "views.py"]),
            ("Express", ["express", "app.get", "app.post"]),
            ("Docker", ["docker", "dockerfile", "container"]),
            ("Git", ["git", "commit", "branch", "merge"]),
        ]
        for (fw, keywords) in fwMap {
            if keywords.contains(where: { lower.contains($0) }) && !frameworks.contains(fw) {
                frameworks.append(fw)
            }
        }

        let topic = String(prompt.prefix(50))
        lastTopics.append(topic)
        if lastTopics.count > 10 { lastTopics.removeFirst() }

        let words = prompt.split(separator: " ").prefix(3).map { String($0).lowercased() }
        let pattern = words.joined(separator: " ")
        patterns[pattern, default: 0] += 1

        save()
    }

    func buildContext(level: Int) -> String? {
        guard level >= 5 else { return nil }

        var context: [String] = []

        if !languages.isEmpty {
            context.append("User's languages: \(languages.joined(separator: ", "))")
        }
        if !frameworks.isEmpty {
            context.append("User's frameworks: \(frameworks.joined(separator: ", "))")
        }

        if level >= 10 && !facts.isEmpty {
            context.append("User preferences: \(facts.joined(separator: "; "))")
        }

        if level >= 15 && !lastTopics.isEmpty {
            let recent = lastTopics.suffix(3).joined(separator: "; ")
            context.append("Recent topics: \(recent)")
        }

        if level >= 20 {
            context.append("You are an expert assistant. Be concise, provide code examples, and anticipate follow-up questions.")
        }

        guard !context.isEmpty else { return nil }
        return "[Context from Agent-O pet (Lv.\(level)): \(context.joined(separator: ". "))]"
    }

    func save() {
        let data: [String: Any] = [
            "facts": facts,
            "languages": languages,
            "frameworks": frameworks,
            "patterns": patterns,
            "lastTopics": lastTopics,
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: data),
           let json = String(data: jsonData, encoding: .utf8) {
            try? json.write(toFile: PetBrain.savePath, atomically: true, encoding: .utf8)
        }
    }

    static func load() -> PetBrain {
        let brain = PetBrain()
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: savePath)),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return brain
        }
        brain.facts = dict["facts"] as? [String] ?? []
        brain.languages = dict["languages"] as? [String] ?? []
        brain.frameworks = dict["frameworks"] as? [String] ?? []
        brain.patterns = dict["patterns"] as? [String: Int] ?? [:]
        brain.lastTopics = dict["lastTopics"] as? [String] ?? []
        return brain
    }
}

class PromptJournal {
    static let savePath = NSHomeDirectory() + "/.agento_prompts.json"

    var entries: [[String: Any]] = []

    private static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    func dayKey(for date: Date) -> String {
        return PromptJournal.dayFormatter.string(from: date)
    }

    func record(source: String, prompt: String) {
        let text = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        let words = text.split(whereSeparator: { $0.isWhitespace || $0.isNewline }).count
        let now = Date()
        let entry: [String: Any] = [
            "timestamp": now.timeIntervalSince1970,
            "day": dayKey(for: now),
            "source": source.lowercased(),
            "text": text,
            "chars": text.count,
            "words": words
        ]
        entries.append(entry)
        if entries.count > 2500 {
            entries = Array(entries.suffix(2500))
        }
        save()
    }

    func entries(forDay day: String) -> [[String: Any]] {
        return entries.filter { ($0["day"] as? String ?? "") == day }
    }

    func entries(forLastDays days: Int) -> [[String: Any]] {
        let safeDays = max(1, days)
        let calendar = Calendar.current
        let startToday = calendar.startOfDay(for: Date())
        guard let cutoff = calendar.date(byAdding: .day, value: -(safeDays - 1), to: startToday) else {
            return entries
        }
        let cutoffTS = cutoff.timeIntervalSince1970
        return entries.filter { ($0["timestamp"] as? TimeInterval ?? 0) >= cutoffTS }
    }

    func save() {
        if let jsonData = try? JSONSerialization.data(withJSONObject: entries),
           let json = String(data: jsonData, encoding: .utf8) {
            try? json.write(toFile: PromptJournal.savePath, atomically: true, encoding: .utf8)
        }
    }

    static func load() -> PromptJournal {
        let journal = PromptJournal()
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: savePath)),
              let raw = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return journal
        }
        journal.entries = raw
        if journal.entries.count > 2500 {
            journal.entries = Array(journal.entries.suffix(2500))
        }
        return journal
    }
}

struct BattleDuelContext {
    var challenger: String
    var opponent: String
    var battleId: String
    var moveSubmitted: Bool
}

// MARK: - Main App Delegate

class AgentODelegate: NSObject, NSApplicationDelegate, NSTextFieldDelegate {
    static let currentVersion = "6.1.1"
    // UI
    var window: NSPanel!
    var miniWindow: NSPanel!
    var miniLabel: NSTextField!
    var agentLabel: NSTextField!
    var bubbleLabel: NSTextField!
    var inputField: NSTextField!
    var outputScroll: NSScrollView!
    var outputText: NSTextView!
    var gitStatusLabel: NSTextField!
    var statusBarItem: NSStatusItem!

    // Quick action buttons (hidden — kept for compatibility)
    var commitBtn: NSButton!
    var testBtn: NSButton!
    var explainBtn: NSButton!
    var reviewBtn: NSButton!
    var statsLabel: NSTextField!
    var sideStatsLabel: NSTextField!

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
    var isCompactMode = false
    var dividerView: NSBox!
    var sendBtn: NSButton!
    var globalMonitor: Any?
    var localMonitor: Any?
    var pet = PetStats.load()
    var brain = PetBrain.load()
    var promptJournal = PromptJournal.load()
    var decayTimer: Timer?
    var currentTheme = Theme.matrix
    var pomodoro = PomodoroTimer()
    var pomoLabel: NSTextField!
    var bottomStatsLabel: NSTextField!

    // Mini-game state
    var gameActive = false
    var gameAnswer = 0
    var gameGuesses = 0
    var triviaAnswer = ""
    var triviaActive = false
    var battleActive = false
    var pendingBattlePollToken: UUID?
    var challengeInboxTimer: Timer?
    var knownIncomingChallengeKeys: Set<String> = []
    var activeDuel: BattleDuelContext?
    var duelStatusTimer: Timer?
    var duelLastStatusSignature: String = ""

    // Clipboard watcher state
    var lastClipboard: String = ""
    var lastClipboardCount: Int = 0
    var clipboardTimer: Timer?
    var isWatchingClipboard: Bool = false
    var autoTranslateLang: String? = nil

    // Snippets state
    var savedSnippets: [(title: String, content: String, date: Date)] = []
    var lastResponse: String = ""

    // Chat system
    var chatSessions: [[String]] = [[]]  // array of output histories
    var currentChat: Int = 0

    // Auto-commit detection
    var lastGitChangeCount: Int = 0

    // Leaderboard
    var playerUsername: String = ""
    var playerAuthToken: String = ""
    static let leaderboardURL = "https://social-coral-five.vercel.app"

    // Reminders
    var reminders: [(text: String, timer: Timer, fireDate: Date)] = []

    // Clipboard history
    var clipboardHistory: [(content: String, date: Date)] = []

    // Currency rate cache
    var cachedRates: [String: Double]? = nil
    var ratesCacheDate: Date? = nil

    // Daily tracking
    var todayCommands: Int = 0
    var todayXP: Int = 0
    var todayDate: String = ""
    var sessionStart: Date = Date()

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
        L10n.lang = Lang(rawValue: pet.language) ?? .en
        pet.updateStreak()
        playerUsername = UserDefaults.standard.string(forKey: "agento_username") ?? pet.leaderboardUsername
        playerAuthToken = UserDefaults.standard.string(forKey: "agento_player_token") ?? pet.leaderboardToken
        pet.leaderboardUsername = playerUsername
        pet.leaderboardToken = playerAuthToken
        pet.save()
        setupMenuBar()
        setupMainWindow()
        setupMiniWindow()
        setupGlobalHotkey()
        startTimers()
        showWelcome()
        refreshGitStatus()
        playSound("Funk")
        // Check for updates 5 seconds after launch
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.checkForUpdateSilent()
        }
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
        let h: CGFloat = 640
        let x = screen.maxX - w - 16
        let y = screen.minY + 16

        window = NSPanel(
            contentRect: NSRect(x: x, y: y, width: w, height: h),
            styleMask: [.titled, .closable, .resizable, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        window.title = "Agent-O"
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

        // ASCII agent (left) + side stats (right)
        yPos -= 150
        let agentW: CGFloat = (w - 20) * 0.55
        agentLabel = NSTextField(labelWithString: "")
        agentLabel.frame = NSRect(x: 10, y: yPos, width: agentW, height: 150)
        agentLabel.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .medium)
        agentLabel.textColor = cCyan
        agentLabel.alignment = .center
        agentLabel.autoresizingMask = [.width, .minYMargin]
        dropContainer.addSubview(agentLabel)

        // Side stats panel (right of agent)
        sideStatsLabel = NSTextField(labelWithString: "")
        sideStatsLabel.frame = NSRect(x: 10 + agentW + 4, y: yPos, width: w - agentW - 24, height: 150)
        sideStatsLabel.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .medium)
        sideStatsLabel.textColor = cGreen
        sideStatsLabel.alignment = .left
        sideStatsLabel.maximumNumberOfLines = 10
        sideStatsLabel.lineBreakMode = .byClipping
        sideStatsLabel.autoresizingMask = [.minXMargin, .minYMargin]
        dropContainer.addSubview(sideStatsLabel)

        // Hidden stats (kept for compatibility)
        statsLabel = NSTextField(labelWithString: "")
        statsLabel.frame = NSRect(x: 0, y: 0, width: 0, height: 0)
        statsLabel.isHidden = true
        dropContainer.addSubview(statsLabel)

        gitStatusLabel = NSTextField(labelWithString: "")
        gitStatusLabel.frame = NSRect(x: 0, y: 0, width: 0, height: 0)
        gitStatusLabel.isHidden = true
        dropContainer.addSubview(gitStatusLabel)

        dividerView = NSBox(frame: NSRect(x: 0, y: 0, width: 0, height: 0))
        dividerView.isHidden = true
        dropContainer.addSubview(dividerView)

        // Hidden buttons (kept for compatibility — actions via commands)
        commitBtn = makeQuickButton("Commit", x: 0, y: 0, w: 0, action: #selector(quickCommit))
        testBtn = makeQuickButton("Test", x: 0, y: 0, w: 0, action: #selector(quickTest))
        explainBtn = makeQuickButton("Explain", x: 0, y: 0, w: 0, action: #selector(quickExplain))
        reviewBtn = makeQuickButton("Review", x: 0, y: 0, w: 0, action: #selector(quickReview))
        for btn in [commitBtn!, testBtn!, explainBtn!, reviewBtn!] {
            btn.isHidden = true
            dropContainer.addSubview(btn)
        }

        refreshStatsDisplay()

        // Output scroll view (right after agent/stats area)
        let outputH = yPos - 44
        outputScroll = NSScrollView(frame: NSRect(x: 10, y: 44, width: w - 20, height: outputH))
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

        // Bottom stats bar (hidden — stats now shown next to agent)
        bottomStatsLabel = NSTextField(labelWithString: "")
        bottomStatsLabel.frame = NSRect(x: 0, y: 0, width: 0, height: 0)
        bottomStatsLabel.isHidden = true
        dropContainer.addSubview(bottomStatsLabel)

        // Input field
        inputField = InputTextField(frame: NSRect(x: 10, y: 12, width: w - 80, height: 28))
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
        sendBtn = NSButton(frame: NSRect(x: w - 65, y: 10, width: 55, height: 30))
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
        let mw: CGFloat = 52
        let mh: CGFloat = 52
        miniWindow = NSPanel(
            contentRect: NSRect(x: screen.maxX - mw - 16, y: screen.minY + 16, width: mw, height: mh),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        miniWindow.isFloatingPanel = true
        miniWindow.level = .floating
        miniWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        miniWindow.isMovableByWindowBackground = true
        miniWindow.backgroundColor = .clear
        miniWindow.hasShadow = true
        miniWindow.isOpaque = false

        // Rounded container
        let container = NSView(frame: NSRect(x: 0, y: 0, width: mw, height: mh))
        container.wantsLayer = true
        container.layer?.cornerRadius = 14
        container.layer?.backgroundColor = NSColor(red: 0.08, green: 0.08, blue: 0.12, alpha: 0.95).cgColor
        container.layer?.borderColor = NSColor(red: 0.3, green: 0.82, blue: 0.9, alpha: 0.4).cgColor
        container.layer?.borderWidth = 1.5

        miniLabel = NSTextField(labelWithString: currentSkin.mini)
        miniLabel.frame = NSRect(x: 0, y: 4, width: mw, height: mh - 4)
        miniLabel.font = NSFont.monospacedSystemFont(ofSize: 20, weight: .bold)
        miniLabel.textColor = cCyan
        miniLabel.alignment = .center

        let clickArea = NSButton(frame: NSRect(x: 0, y: 0, width: mw, height: mh))
        clickArea.isTransparent = true
        clickArea.target = self
        clickArea.action = #selector(toggleWindow)

        container.addSubview(miniLabel)
        container.addSubview(clickArea)
        miniWindow.contentView = container
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

    // MARK: - Compact / Full Mode

    func switchToCompactMode() {
        guard !isCompactMode else { return }
        isCompactMode = true

        // Hide elements
        bubbleLabel.isHidden = true
        sideStatsLabel.isHidden = true

        // Resize: ASCII (100) + output (flexible) + input (40) + padding
        let w: CGFloat = 380
        let h: CGFloat = 420
        let screen = NSScreen.main!.visibleFrame
        let x = screen.maxX - w - 16
        let y = screen.minY + 16

        window.setFrame(NSRect(x: x, y: y, width: w, height: h), display: true, animate: true)
        window.minSize = NSSize(width: 300, height: 300)

        // Reposition: agent label at top, full width
        agentLabel.frame = NSRect(x: 10, y: h - 30 - 100, width: w - 20, height: 100)
        agentLabel.font = NSFont.monospacedSystemFont(ofSize: 10, weight: .medium)

        // Output takes the middle
        let outputTop = h - 30 - 105
        outputScroll.frame = NSRect(x: 10, y: 44, width: w - 20, height: outputTop - 48)

        inputField.frame = NSRect(x: 10, y: 12, width: w - 80, height: 28)
        sendBtn.frame = NSRect(x: w - 65, y: 10, width: 55, height: 30)

        window.title = "Agent-O"
        appendColored("📐 Compact mode — type /full to expand\n\n", color: cGray)
        playSound("Pop")
    }

    func switchToFullMode() {
        guard isCompactMode else { return }
        isCompactMode = false

        // Show elements
        bubbleLabel.isHidden = false
        sideStatsLabel.isHidden = false

        // Resize back
        let w: CGFloat = 440
        let h: CGFloat = 640
        let screen = NSScreen.main!.visibleFrame
        let x = screen.maxX - w - 16
        let y = screen.minY + 16

        window.setFrame(NSRect(x: x, y: y, width: w, height: h), display: true, animate: true)
        window.minSize = NSSize(width: 360, height: 400)

        // Restore layout: bubble → agent(left)+stats(right) → output → input
        var yPos = h - 30
        yPos -= 75
        bubbleLabel.frame = NSRect(x: 10, y: yPos, width: w - 20, height: 75)
        yPos -= 150
        let agentW: CGFloat = (w - 20) * 0.55
        agentLabel.frame = NSRect(x: 10, y: yPos, width: agentW, height: 150)
        agentLabel.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .medium)
        sideStatsLabel.frame = NSRect(x: 10 + agentW + 4, y: yPos, width: w - agentW - 24, height: 150)

        let outputH = yPos - 44
        outputScroll.frame = NSRect(x: 10, y: 44, width: w - 20, height: outputH)
        inputField.frame = NSRect(x: 10, y: 12, width: w - 80, height: 28)
        sendBtn.frame = NSRect(x: w - 65, y: 10, width: 55, height: 30)

        window.title = "Agent-O"
        refreshSideStats()
        appendColored("📐 Full mode restored\n\n", color: cGray)
        playSound("Pop")
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
                self.bubbleLabel.stringValue = speechBubble(L10n.t("sleep"))
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
                self.bubbleLabel.stringValue = speechBubble(L10n.t("hungry"))
            } else if self.pet.happiness < 20 && self.state == .idle {
                self.bubbleLabel.stringValue = speechBubble(L10n.t("sad"))
            } else if self.pet.energy < 20 && self.state == .idle {
                self.bubbleLabel.stringValue = speechBubble(L10n.t("tired"))
            }
            // Auto-detect git changes
            self.checkGitChanges()
        }
        challengeInboxTimer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { [weak self] _ in
            self?.checkIncomingBattleChallenges(silent: true)
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
        let mood = localizedMood()
        let lvlBar = "Lv.\(p.level) \(p.moodEmoji) \(mood)"
        let hBar = "\(L10n.t("s_food")) \(p.statsBar(p.hunger)) \(p.hunger)%"
        let jBar = "\(L10n.t("s_joy")) \(p.statsBar(p.happiness)) \(p.happiness)%"
        let eBar = "\(L10n.t("s_nrg")) \(p.statsBar(p.energy)) \(p.energy)%"
        statsLabel.stringValue = "\(lvlBar)  XP:\(p.xp)/\(p.xpForNextLevel)  Streak:\(p.streak)d\n\(hBar)  \(jBar)  \(eBar)"
        statusBarItem.button?.title = "\(currentSkin.mini) Lv.\(p.level) \(p.moodEmoji)"
        refreshSideStats()
        refreshBottomStats()
    }

    func miniBar(_ value: Int, _ max: Int = 100, width: Int = 8) -> String {
        let filled = Int(Double(value) * Double(width) / Double(max))
        let empty = width - min(filled, width)
        return "[\(String(repeating: "█", count: min(filled, width)))\(String(repeating: "░", count: empty))]"
    }

    func refreshSideStats() {
        guard sideStatsLabel != nil else { return }
        let p = pet
        let evo = Evolution.stage(for: p.level)
        let xpPct = p.xpForNextLevel > 0 ? p.xp : 0
        var lines: [String] = []
        lines.append("Lv.\(p.level) \(p.moodEmoji) \(evo)")
        lines.append("")
        lines.append("Food \(miniBar(p.hunger)) \(p.hunger)%")
        lines.append("Joy  \(miniBar(p.happiness)) \(p.happiness)%")
        lines.append("Nrg  \(miniBar(p.energy)) \(p.energy)%")
        lines.append("")
        lines.append("XP   \(miniBar(xpPct, p.xpForNextLevel)) \(p.xp)/\(p.xpForNextLevel)")
        lines.append("Streak \(p.streak)d")
        sideStatsLabel.stringValue = lines.joined(separator: "\n")
    }

    func refreshBottomStats() {
        guard bottomStatsLabel != nil else { return }
        bottomStatsLabel.isHidden = true
    }

    func localizedMood() -> String {
        let avg = (pet.hunger + pet.happiness + pet.energy) / 3
        if avg > 80 { return L10n.t("s_thriving") }
        if avg > 60 { return L10n.t("s_happy") }
        if avg > 40 { return L10n.t("s_okay") }
        if avg > 20 { return L10n.t("s_sad") }
        return L10n.t("s_critical")
    }

    @objc func feedPet() {
        pet.feed()
        pet.save()
        setState(.happy, duration: 2)
        bubbleLabel.stringValue = speechBubble(L10n.t("feed_msg"))
        appendColored("🍔 \(L10n.t("fed")) \(pet.hunger)%\n\n", color: cGreen)
        playSound("Pop")
        if let a = pet.unlock("feed_pet") {
            appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n\n", color: cYellow, bold: true)
        }
        updateDailyQuest("feed_pet", by: 1)
        refreshStatsDisplay()
        processAchievements()
        checkInventoryUnlocks()
    }

    @objc func playPet() {
        pet.play()
        pet.save()
        setState(.dancing, duration: 3)
        bubbleLabel.stringValue = speechBubble(L10n.t("play_msg"))
        appendColored("🎮 \(L10n.t("played")) \(pet.happiness)%\n\n", color: cPurple)
        playSound("Funk")
        if let a = pet.unlock("play_pet") {
            appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n\n", color: cYellow, bold: true)
        }
        updateDailyQuest("play_pet", by: 1)
        refreshStatsDisplay()
        processAchievements()
        checkInventoryUnlocks()
    }

    @objc func restPet() {
        pet.rest()
        pet.save()
        setState(.sleeping, duration: 3)
        bubbleLabel.stringValue = speechBubble(L10n.t("rest_msg"))
        appendColored("💤 \(L10n.t("resting")) \(pet.energy)%\n\n", color: cCyan)
        playSound("Purr")
        updateDailyQuest("rest_pet", by: 1)
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
            let oldEvo = Evolution.stage(for: oldLevel)
            let newEvo = Evolution.stage(for: pet.level)
            appendColored("🎉 LEVEL UP! Agent-O is now Level \(pet.level)!\n", color: cYellow, bold: true)
            if oldEvo != newEvo {
                appendColored("🧬 EVOLUTION: \(oldEvo) → \(newEvo)!\n", color: cPurple, bold: true)
                playSound("Hero")
                sendNotification(title: "Evolution!", body: "\(oldEvo) → \(newEvo)! Level \(pet.level)")
            } else {
                playSound("Funk")
            }
            appendColored("\n", color: cGray)
            bubbleLabel.stringValue = speechBubble("LEVEL UP! I'm Level \(pet.level) now!")
            setState(.dancing, duration: 3)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.state = .idle
            }
            checkInventoryUnlocks()
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
                self.appendColored("   Take a break! Type /break for 5 min break\n\n", color: self.cGray)
                self.bubbleLabel.stringValue = speechBubble("Pomodoro done! Great focus! +40 XP")
                self.sendNotification(title: "Pomodoro Complete!", body: "Time for a break! +40 XP")
                self.playSound("Glass")
                self.setState(.happy, duration: 3)
                self.pomoLabel.stringValue = "🍅 DONE! Type /break for 5 min break"
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
        updateDailyQuest("game_play", by: 1)
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
        appendColored("   Type /answer <number or text>\n\n", color: cDimGray)
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

    func normalizeCommandPrefix(_ input: String) -> String {
        if input.hasPrefix("!") {
            return "/" + String(input.dropFirst())
        }
        return input
    }

    func commandText(_ command: String) -> String {
        return normalizeCommandPrefix(command)
    }

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            sendPrompt()
            return true
        }
        if commandSelector == #selector(NSResponder.selectAll(_:)) {
            textView.selectAll(nil)
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
        let parsedPrompt = normalizeCommandPrefix(prompt)
        inputField.stringValue = ""
        lastInteraction = Date()
        if state == .sleeping { state = .idle }

        // Add to history
        commandHistory.append(prompt)
        historyIndex = commandHistory.count

        appendColored("❯ \(prompt)\n", color: cCyan, bold: true)

        // Typing game input
        if typingGameActive {
            handleTypingInput(prompt)
            return
        }

        // Onboarding step tracking
        if onboardingStep > 0 {
            _ = handleOnboardingStep(parsedPrompt)
        }

        // Built-in commands
        if handleBuiltinCommand(parsedPrompt) { return }

        // Translation: EN <text>, RU <text>, etc.
        if let (targetLang, textToTranslate) = parseTranslateCommand(parsedPrompt) {
            translateText(textToTranslate, to: targetLang)
            updateDailyQuest("translate_1", by: 1)
            return
        }

        // Determine CLI
        var cli = "claude"
        var actualPrompt = parsedPrompt

        if parsedPrompt.hasPrefix("/codex ") {
            cli = "codex"
            actualPrompt = String(parsedPrompt.dropFirst(7))
        } else if parsedPrompt.hasPrefix("/claude ") {
            actualPrompt = String(parsedPrompt.dropFirst(8))
        }

        let oldLevel = pet.level
        pet.onCommandRun()
        pet.save()
        refreshStatsDisplay()
        checkTimeAchievements()
        processAchievements()
        updateDailyQuest("cmd_3", by: 1)
        updateDailyQuest("cmd_10", by: 1)
        checkInventoryUnlocks()

        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("\(L10n.t("thinking")) \(actualPrompt.prefix(28))...")
        appendColored("⏳ → \(cli)...\n", color: cDimGray)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: cli, prompt: actualPrompt, oldLevel: oldLevel)
        }
    }

    func handleBuiltinCommand(_ cmdInput: String) -> Bool {
        let cmd = normalizeCommandPrefix(cmdInput)
        switch cmd {
        case "/clear":
            outputText.textStorage?.setAttributedString(NSAttributedString(string: ""))
            bubbleLabel.stringValue = speechBubble(L10n.t("cleared"))
            playSound("Pop")
            return true

        case "/compact":
            switchToCompactMode()
            return true

        case "/full":
            switchToFullMode()
            return true

        case "/tip":
            let tip = AgentArt.tips.randomElement()!
            bubbleLabel.stringValue = speechBubble(tip)
            appendColored("💡 \(tip)\n\n", color: cYellow)
            return true

        case "/feed":
            feedPet()
            return true

        case "/play":
            playPet()
            return true

        case "/rest":
            restPet()
            return true

        case "/stats":
            showPetStats()
            return true

        case "/ru":
            L10n.lang = .ru
            pet.language = "ru"
            pet.save()
            inputField.placeholderString = L10n.t("placeholder")
            refreshStatsDisplay()
            appendColored("🌐 Язык: Русский\n\n", color: cPurple, bold: true)
            bubbleLabel.stringValue = speechBubble(L10n.t("lang_switched"))
            return true

        case "/en":
            L10n.lang = .en
            pet.language = "en"
            pet.save()
            inputField.placeholderString = L10n.t("placeholder")
            refreshStatsDisplay()
            appendColored("🌐 Language: English\n\n", color: cPurple, bold: true)
            bubbleLabel.stringValue = speechBubble(L10n.t("lang_switched"))
            return true

        case "/dance":
            doDance()
            if let a = pet.unlock("dance") {
                appendColored("🏆 ACHIEVEMENT: \(a.icon) \(a.name)\n\n", color: cYellow, bold: true)
            }
            return true

        case "/achievements", "/ach":
            showAchievements()
            return true

        case "/pomo", "/pomodoro":
            pomoStartWith(minutes: 25)
            return true

        case "/pomo10":
            pomoStartWith(minutes: 10)
            return true

        case "/break":
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

        case "/stoptime", "/stoppomo":
            pomodoro.stop()
            pomoLabel.isHidden = true
            appendColored("🍅 Pomodoro stopped\n\n", color: cDimGray)
            return true

        case "/game":
            startNumberGame()
            return true

        case "/trivia":
            startTriviaGame()
            return true

        case "/paste":
            analyzeClipboard()
            return true

        case "/evo", "/evolution":
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

        case "/git":
            quickGit()
            return true

        case "/ps":
            monitorProcesses()
            return true

        case "/help":
            showHelp()
            return true

        case "/memory":
            showBrainMemory()
            return true

        case "/brain":
            exportBrain()
            return true

        case "/update":
            checkForUpdate()
            return true

        case "/version":
            appendColored("Agent-O v\(AgentODelegate.currentVersion)\n\n", color: cCyan, bold: true)
            return true

        case "/battles":
            showBattleHistory()
            return true

        case "/challenges":
            listPendingBattleChallenges()
            return true

        case "/quests":
            showDailyQuests()
            return true

        case "/inventory":
            showInventory()
            return true

        case "/typing":
            startTypingGame()
            return true

        case "/leaderboard":
            submitToLeaderboard()
            return true

        case "/watch":
            startClipboardWatch()
            return true

        case "/unwatch":
            stopClipboardWatch()
            return true

        case "/save":
            saveSnippet()
            return true

        case "/snippets":
            listSnippets()
            return true

        case "/share":
            generateShareCard()
            return true

        case "/screenshot":
            captureScreenshot()
            return true

        case "/diff":
            reviewDiff()
            return true

        case "/commit":
            autoCommitMessage()
            return true

        case "/chat new":
            newChat()
            return true

        case "/chat list":
            listChats()
            return true

        case "/history":
            appendColored("📜 Command history:\n", color: cCyan, bold: true)
            for (i, cmd) in commandHistory.dropLast().enumerated() {
                appendColored("  \(i+1). \(cmd)\n", color: cGray)
            }
            appendOutput("\n")
            return true

        case "/reminders":
            listReminders()
            return true

        case "/standup":
            generateStandup()
            return true

        case "/daily":
            showDailySummary()
            return true

        case "/promptstats":
            showPromptStats(days: 1)
            return true

        case "/promptcoach":
            showPromptCoach(days: 1)
            return true

        case "/clipboard":
            showClipboardHistory("")
            return true

        default:
            // Teach the pet brain
            if cmd.hasPrefix("/teach ") {
                let fact = String(cmd.dropFirst(7)).trimmingCharacters(in: .whitespaces)
                if fact.isEmpty {
                    appendColored("Usage: /teach <fact>\n\n", color: cRed)
                } else {
                    brain.facts.append(fact)
                    brain.save()
                    appendColored("Learned: \"\(fact)\"\n", color: cGreen, bold: true)
                    appendColored("  \(brain.facts.count) fact(s) stored\n\n", color: cGray)
                    bubbleLabel.stringValue = speechBubble("I'll remember that!")
                    playSound("Pop")
                }
                return true
            }
            // Forget a fact
            if cmd.hasPrefix("/forget ") {
                let fact = String(cmd.dropFirst(8)).trimmingCharacters(in: .whitespaces)
                if let idx = brain.facts.firstIndex(of: fact) {
                    brain.facts.remove(at: idx)
                    brain.save()
                    appendColored("Forgot: \"\(fact)\"\n\n", color: cYellow)
                    bubbleLabel.stringValue = speechBubble("Forgotten!")
                    playSound("Pop")
                } else {
                    appendColored("I don't know that fact.\n", color: cRed)
                    if !brain.facts.isEmpty {
                        appendColored("  Known facts: \(brain.facts.joined(separator: ", "))\n\n", color: cGray)
                    } else {
                        appendOutput("\n")
                    }
                }
                return true
            }
            // Reminder
            if cmd.hasPrefix("/remind ") {
                let args = String(cmd.dropFirst(8))
                scheduleReminder(args)
                return true
            }
            // Natural language shell
            if cmd.hasPrefix("/sh ") {
                let desc = String(cmd.dropFirst(4)).trimmingCharacters(in: .whitespaces)
                naturalShell(desc)
                return true
            }
            // Clipboard history with args
            if cmd.hasPrefix("/clipboard ") {
                let args = String(cmd.dropFirst(11))
                showClipboardHistory(args)
                return true
            }
            // Ask about file
            if cmd.hasPrefix("/ask ") {
                let path = String(cmd.dropFirst(5)).trimmingCharacters(in: .whitespaces)
                askAboutFile(path)
                return true
            }
            // Switch chat
            if cmd.hasPrefix("/chat "), let num = Int(String(cmd.dropFirst(6))) {
                switchChat(to: num)
                return true
            }
            // Snippet search
            if cmd.hasPrefix("/search ") {
                let query = String(cmd.dropFirst(8)).trimmingCharacters(in: .whitespaces)
                searchSnippets(query)
                return true
            }
            if cmd.hasPrefix("/promptstats ") {
                let raw = String(cmd.dropFirst(13)).trimmingCharacters(in: .whitespaces)
                let days = Int(raw) ?? 1
                showPromptStats(days: days)
                return true
            }
            if cmd.hasPrefix("/promptcoach ") {
                let raw = String(cmd.dropFirst(13)).trimmingCharacters(in: .whitespaces)
                let days = Int(raw) ?? 1
                showPromptCoach(days: days)
                return true
            }
            if cmd.hasPrefix("/move ") {
                let args = String(cmd.dropFirst(6)).trimmingCharacters(in: .whitespaces)
                submitBattleMove(args: args)
                return true
            }
            // Pet battle
            if cmd.hasPrefix("/battle ") {
                let opponent = String(cmd.dropFirst(8)).trimmingCharacters(in: .whitespaces)
                startBattle(opponent: opponent)
                return true
            }
            if cmd.hasPrefix("/accept ") {
                let challenger = String(cmd.dropFirst(8)).trimmingCharacters(in: .whitespaces)
                respondToBattleChallenge(challenger: challenger, accept: true)
                return true
            }
            if cmd.hasPrefix("/decline ") {
                let challenger = String(cmd.dropFirst(9)).trimmingCharacters(in: .whitespaces)
                respondToBattleChallenge(challenger: challenger, accept: false)
                return true
            }
            // Set username for leaderboard
            if cmd.hasPrefix("/name ") {
                let name = String(cmd.dropFirst(6)).trimmingCharacters(in: .whitespaces)
                if name.isEmpty || name.count > 20 {
                    appendColored("❌ Name must be 1-20 characters\n\n", color: cRed)
                } else {
                    let oldName = playerUsername
                    playerUsername = name
                    UserDefaults.standard.set(name, forKey: "agento_username")
                    pet.leaderboardUsername = name
                    if !oldName.isEmpty && oldName.lowercased() != name.lowercased() {
                        playerAuthToken = ""
                        UserDefaults.standard.removeObject(forKey: "agento_player_token")
                        pet.leaderboardToken = ""
                        appendColored("🔐 Username changed: auth token reset for new owner binding\n", color: cDimGray)
                    }
                    pet.save()
                    appendColored("✅ Username set: \(name)\n", color: cGreen, bold: true)
                    appendColored("  Type /leaderboard to publish your stats\n\n", color: cGray)
                    bubbleLabel.stringValue = speechBubble("I'm \(name)!")
                }
                return true
            }
            // Auto-translate toggle: /translate ru, /translate en, /translate off
            if cmd.hasPrefix("/translate ") {
                let arg = String(cmd.dropFirst(11)).trimmingCharacters(in: .whitespaces).lowercased()
                if arg == "off" || arg == "stop" {
                    clearAutoTranslate()
                } else if AgentODelegate.translateLangs.contains(arg.uppercased()) {
                    setAutoTranslate(arg)
                } else {
                    appendColored("❌ Unknown language: \(arg)\n", color: cRed)
                    appendColored("  Supported: EN, RU, ES, FR, DE, IT, PT, JA, KO, ZH, AR, HI, TR, PL, NL, UK, CS, SV\n\n", color: cGray)
                }
                return true
            }
            // Skin change
            if cmd.hasPrefix("/skin ") {
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
            if cmd.hasPrefix("/theme ") {
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
            // Quick calc & conversions
            if cmd.hasPrefix("/calc ") {
                let args = String(cmd.dropFirst(6)).trimmingCharacters(in: .whitespaces)
                quickCalc(args)
                return true
            }
            // Regex builder
            if cmd.hasPrefix("/regex ") {
                let desc = String(cmd.dropFirst(7)).trimmingCharacters(in: .whitespaces)
                regexBuilder(desc)
                return true
            }
            // Number game guess
            if cmd.hasPrefix("/guess ") {
                let num = String(cmd.dropFirst(7)).trimmingCharacters(in: .whitespaces)
                if handleGuess(num) { return true }
            }
            // Trivia answer
            if cmd.hasPrefix("/answer ") {
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

    // MARK: - Reminders

    func scheduleReminder(_ args: String) {
        let parts = args.trimmingCharacters(in: .whitespaces).split(separator: " ", maxSplits: 1)
        guard parts.count >= 2 else {
            appendColored("❌ Usage: /remind <time> <text>\n", color: cRed)
            appendColored("  Example: /remind 30m check deploy\n", color: cGray)
            appendColored("  Example: /remind 2h call meeting\n\n", color: cGray)
            return
        }

        let timeStr = String(parts[0]).lowercased()
        let text = String(parts[1])
        var seconds: TimeInterval = 0

        if timeStr.hasSuffix("m"), let mins = Double(timeStr.dropLast()) {
            seconds = mins * 60
        } else if timeStr.hasSuffix("h"), let hrs = Double(timeStr.dropLast()) {
            seconds = hrs * 3600
        } else {
            appendColored("❌ Invalid time format. Use Xm (minutes) or Xh (hours)\n\n", color: cRed)
            return
        }

        guard seconds > 0 else {
            appendColored("❌ Time must be greater than 0\n\n", color: cRed)
            return
        }

        let fireDate = Date().addingTimeInterval(seconds)
        let timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { [weak self] _ in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.appendColored("⏰ REMINDER: \(text)\n\n", color: self.cYellow, bold: true)
                self.bubbleLabel.stringValue = speechBubble("Reminder: \(text)")
                self.setState(.happy, duration: 3)
                self.playSound("Glass")
                self.sendNotification(title: "Agent-O Reminder", body: text)
                self.reminders.removeAll { $0.text == text && $0.fireDate == fireDate }
            }
        }

        reminders.append((text: text, timer: timer, fireDate: fireDate))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        appendColored("⏰ Reminder set: \(text)\n", color: cGreen, bold: true)
        appendColored("  Fires at \(formatter.string(from: fireDate)) (\(timeStr))\n\n", color: cGray)
        bubbleLabel.stringValue = speechBubble("Reminder set!")
        playSound("Pop")
    }

    func listReminders() {
        let active = reminders.filter { $0.fireDate > Date() }
        guard !active.isEmpty else {
            appendColored("⏰ No active reminders\n\n", color: cDimGray)
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        appendColored("⏰ Active Reminders (\(active.count)):\n", color: cCyan, bold: true)
        for (i, r) in active.enumerated() {
            let remaining = Int(r.fireDate.timeIntervalSinceNow)
            let mins = remaining / 60
            let secs = remaining % 60
            appendColored("  \(i+1). ", color: cYellow)
            appendOutput("\(r.text) — at \(formatter.string(from: r.fireDate)) (in \(mins)m \(secs)s)\n")
        }
        appendOutput("\n")
    }

    // MARK: - Daily Standup

    func generateStandup() {
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Preparing standup...")
        appendColored("📋 Generating standup report...\n", color: cCyan, bold: true)

        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            let author = self.shell("git config user.name 2>/dev/null")?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let branch = self.shell("git branch --show-current 2>/dev/null")?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "N/A"
            let commits = self.shell("git log --oneline --since=\"yesterday\" --author=\"\(author)\" 2>/dev/null")?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let commitCount = commits.isEmpty ? 0 : commits.components(separatedBy: "\n").count
            let diffStat = self.shell("git diff --stat HEAD~\(max(commitCount, 1)) 2>/dev/null")?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            var report = "## Daily Standup — \(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none))\n\n"
            report += "**Branch:** \(branch)\n"
            report += "**Author:** \(author)\n\n"

            if commits.isEmpty {
                report += "### Done\n- No commits since yesterday\n\n"
            } else {
                report += "### Done (\(commitCount) commits)\n"
                for line in commits.components(separatedBy: "\n") where !line.isEmpty {
                    report += "- \(line)\n"
                }
                report += "\n"
            }

            if !diffStat.isEmpty {
                report += "### Files Changed\n```\n\(diffStat)\n```\n"
            }

            DispatchQueue.main.async {
                self.appendColored("╭── Standup Report ───────────────────╮\n", color: self.cCyan)
                self.appendColored("  Branch: \(branch)\n", color: self.cYellow)
                self.appendColored("  Author: \(author)\n\n", color: self.cGray)

                if commits.isEmpty {
                    self.appendColored("  No commits since yesterday\n", color: self.cDimGray)
                } else {
                    self.appendColored("  Commits (\(commitCount)):\n", color: self.cGreen, bold: true)
                    for line in commits.components(separatedBy: "\n") where !line.isEmpty {
                        self.appendColored("  - \(line)\n", color: self.cGray)
                    }
                }

                if !diffStat.isEmpty {
                    self.appendColored("\n  Files changed:\n", color: self.cPurple, bold: true)
                    for line in diffStat.components(separatedBy: "\n") where !line.isEmpty {
                        self.appendColored("  \(line)\n", color: self.cDimGray)
                    }
                }

                self.appendColored("╰────────────────────────────────────╯\n\n", color: self.cCyan)

                // Copy to clipboard
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(report, forType: .string)
                self.appendColored("📋 Standup copied to clipboard!\n\n", color: self.cGreen)
                self.bubbleLabel.stringValue = speechBubble("Standup ready!")
                self.setState(.happy, duration: 2)
                self.playSound("Pop")
            }
        }
    }

    // MARK: - Natural Language Shell

    func naturalShell(_ description: String) {
        let dangerous = ["rm -rf /", "sudo ", "mkfs", "dd if="]
        for d in dangerous {
            if description.lowercased().contains(d) {
                appendColored("❌ Refused: potentially dangerous command pattern detected\n\n", color: cRed)
                setState(.error, duration: 2)
                return
            }
        }

        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Converting to shell...")
        appendColored("🐚 NL → Shell: \(description)\n", color: cCyan, bold: true)
        appendColored("⏳ → claude...\n", color: cDimGray)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let prompt = "Convert this to a single shell command for macOS. Output ONLY the command, nothing else: \(description)"
            let escapedPrompt = prompt
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")
                .replacingOccurrences(of: "$", with: "\\$")
                .replacingOccurrences(of: "`", with: "\\`")
            let generated = self.shell("claude -p \"\(escapedPrompt)\"")?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            DispatchQueue.main.async {
                guard !generated.isEmpty else {
                    self.appendColored("❌ Could not generate command\n\n", color: self.cRed)
                    self.setState(.error, duration: 2)
                    return
                }

                // Safety check on generated command
                for d in dangerous {
                    if generated.lowercased().contains(d) {
                        self.appendColored("❌ Generated command refused (dangerous): \(generated)\n\n", color: self.cRed)
                        self.setState(.error, duration: 2)
                        return
                    }
                }

                self.appendColored("⚡ Command: ", color: self.cYellow, bold: true)
                self.appendOutput("\(generated)\n")
                self.appendColored("⏳ Executing...\n", color: self.cDimGray)

                DispatchQueue.global(qos: .userInitiated).async {
                    let output = self.shell(generated) ?? ""
                    DispatchQueue.main.async {
                        if !output.isEmpty {
                            self.appendOutput(output)
                            if !output.hasSuffix("\n") { self.appendOutput("\n") }
                        }
                        self.appendOutput("\n")
                        self.setState(.happy, duration: 2)
                        self.bubbleLabel.stringValue = speechBubble("Done!")
                        self.playSound("Glass")
                    }
                }
            }
        }
    }

    // MARK: - Clipboard History

    func showClipboardHistory(_ args: String) {
        let arg = args.trimmingCharacters(in: .whitespaces)

        // Search mode
        if arg.hasPrefix("search ") {
            let query = String(arg.dropFirst(7)).trimmingCharacters(in: .whitespaces).lowercased()
            let results = clipboardHistory.filter { $0.content.lowercased().contains(query) }
            guard !results.isEmpty else {
                appendColored("🔍 No clipboard entries matching \"\(query)\"\n\n", color: cDimGray)
                return
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            appendColored("🔍 Clipboard search: \"\(query)\" (\(results.count) results)\n", color: cCyan, bold: true)
            for (i, entry) in results.enumerated() {
                let preview = String(entry.content.prefix(60)).replacingOccurrences(of: "\n", with: " ")
                appendColored("  \(i+1). ", color: cYellow)
                appendColored("[\(formatter.string(from: entry.date))] ", color: cDimGray)
                appendOutput("\(preview)\(entry.content.count > 60 ? "..." : "")\n")
            }
            appendOutput("\n")
            return
        }

        // Copy back mode: /clipboard N
        if let num = Int(arg) {
            guard num >= 1 && num <= clipboardHistory.count else {
                appendColored("❌ Invalid entry number. Range: 1-\(clipboardHistory.count)\n\n", color: cRed)
                return
            }
            let entry = clipboardHistory[clipboardHistory.count - num]
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(entry.content, forType: .string)
            let preview = String(entry.content.prefix(60)).replacingOccurrences(of: "\n", with: " ")
            appendColored("📋 Copied entry #\(num) to clipboard: \(preview)\(entry.content.count > 60 ? "..." : "")\n\n", color: cGreen)
            playSound("Pop")
            return
        }

        // Default: show last 10
        guard !clipboardHistory.isEmpty else {
            appendColored("📋 Clipboard history is empty\n\n", color: cDimGray)
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let entries = clipboardHistory.suffix(10)
        appendColored("📋 Clipboard History (last \(entries.count)):\n", color: cCyan, bold: true)
        for (i, entry) in entries.enumerated() {
            let preview = String(entry.content.prefix(60)).replacingOccurrences(of: "\n", with: " ")
            appendColored("  \(i+1). ", color: cYellow)
            appendColored("[\(formatter.string(from: entry.date))] ", color: cDimGray)
            appendOutput("\(preview)\(entry.content.count > 60 ? "..." : "")\n")
        }
        appendColored("  Use /clipboard <N> to re-copy, /clipboard search <query> to search\n\n", color: cGray)
    }

    // MARK: - Clipboard Watcher

    func startClipboardWatch() {
        isWatchingClipboard = true
        lastClipboardCount = NSPasteboard.general.changeCount
        lastClipboard = NSPasteboard.general.string(forType: .string) ?? ""
        clipboardTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.checkClipboard()
        }
        appendColored("👁 Clipboard watcher ON\n", color: cGreen, bold: true)
        appendColored("  Agent-O will detect code & errors in your clipboard\n", color: cGray)
        appendColored("  Type /unwatch to stop\n\n", color: cGray)
        bubbleLabel.stringValue = speechBubble("Watching clipboard...")
    }

    func stopClipboardWatch() {
        isWatchingClipboard = false
        clipboardTimer?.invalidate()
        clipboardTimer = nil
        appendColored("👁 Clipboard watcher OFF\n\n", color: cGray)
        bubbleLabel.stringValue = speechBubble("Stopped watching")
    }

    func setAutoTranslate(_ lang: String) {
        autoTranslateLang = lang.lowercased()
        let langName = lang.uppercased()
        if !isWatchingClipboard {
            startClipboardWatch()
        }
        appendColored("🌐 Auto-translate → \(langName)\n", color: cPurple, bold: true)
        appendColored("  Copy any text — it will be translated to \(langName) automatically\n", color: cGray)
        appendColored("  Type /translate off to stop auto-translating\n\n", color: cGray)
        bubbleLabel.stringValue = speechBubble("Auto-translate → \(langName)")
    }

    func clearAutoTranslate() {
        autoTranslateLang = nil
        appendColored("🌐 Auto-translate OFF\n\n", color: cGray)
        bubbleLabel.stringValue = speechBubble("Auto-translate off")
    }

    func checkClipboard() {
        let currentCount = NSPasteboard.general.changeCount
        guard currentCount != lastClipboardCount else { return }
        lastClipboardCount = currentCount
        guard let content = NSPasteboard.general.string(forType: .string), !content.isEmpty else { return }
        lastClipboard = content

        // Track clipboard history
        clipboardHistory.append((content: content, date: Date()))
        if clipboardHistory.count > 50 {
            clipboardHistory.removeFirst(clipboardHistory.count - 50)
        }

        // Auto-translate mode
        if let lang = autoTranslateLang {
            let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { return }
            appendColored("📋 Copied: \(String(trimmed.prefix(80)))\(trimmed.count > 80 ? "..." : "")\n", color: cGray)
            translateText(trimmed, to: lang)
            return
        }

        // Normal clipboard detection mode
        let lower = content.lowercased()

        let codeKeywords = ["func ", "def ", "class ", "=>", "import ", "const ", "let ", "var ", "function ", "return ", "if (", "for (", "while ("]
        let errorKeywords = ["error", "exception", "traceback", "fatal", "panic", "failed", "undefined", "null pointer", "segfault"]

        let isCode = codeKeywords.contains(where: { lower.contains($0.lowercased()) })
        let isError = errorKeywords.contains(where: { lower.contains($0) })

        if isError {
            appendColored("🔴 Error detected in clipboard!\n", color: cRed, bold: true)
            appendColored("  Type: fix — to get help from Claude\n\n", color: cGray)
            bubbleLabel.stringValue = speechBubble("Error detected! 🔴")
            setState(.error)
        } else if isCode {
            appendColored("📋 Code detected in clipboard! (\(content.count) chars)\n", color: cCyan, bold: true)
            appendColored("  Type: explain — to analyze with Claude\n\n", color: cGray)
            bubbleLabel.stringValue = speechBubble("Code detected! 📋")
        } else {
            appendColored("📋 Clipboard updated (\(content.count) chars)\n\n", color: cGray)
        }
    }

    // MARK: - Snippets

    func saveSnippet() {
        guard !lastResponse.isEmpty else {
            appendColored("❌ Nothing to save. Run a command first.\n\n", color: cRed)
            return
        }
        let title = String(lastResponse.prefix(60)).replacingOccurrences(of: "\n", with: " ")
        savedSnippets.append((title: title, content: lastResponse, date: Date()))
        appendColored("💾 Snippet saved! (#\(savedSnippets.count))\n", color: cGreen, bold: true)
        appendColored("  \(title)...\n\n", color: cGray)
        bubbleLabel.stringValue = speechBubble("Saved! 💾")
        playSound("Pop")
    }

    func listSnippets() {
        guard !savedSnippets.isEmpty else {
            appendColored("📝 No saved snippets yet. Use /save after a command.\n\n", color: cGray)
            return
        }
        appendColored("📝 Saved Snippets (\(savedSnippets.count)):\n", color: cCyan, bold: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        for (i, snippet) in savedSnippets.enumerated() {
            appendColored("  \(i+1). ", color: cYellow)
            appendOutput("\(snippet.title)\n")
            appendColored("     \(formatter.string(from: snippet.date))\n", color: cGray)
        }
        appendOutput("\n")
    }

    func searchSnippets(_ query: String) {
        let results = savedSnippets.filter { $0.title.localizedCaseInsensitiveContains(query) || $0.content.localizedCaseInsensitiveContains(query) }
        if results.isEmpty {
            appendColored("🔍 No snippets matching \"\(query)\"\n\n", color: cGray)
        } else {
            appendColored("🔍 Found \(results.count) snippet(s) for \"\(query)\":\n", color: cCyan, bold: true)
            for (i, snippet) in results.enumerated() {
                appendColored("  \(i+1). ", color: cYellow)
                appendOutput("\(snippet.title)\n")
                if let range = snippet.content.range(of: query, options: .caseInsensitive) {
                    let safeStart = snippet.content.index(range.lowerBound, offsetBy: -30, limitedBy: snippet.content.startIndex) ?? snippet.content.startIndex
                    let safeEnd = snippet.content.index(range.upperBound, offsetBy: 30, limitedBy: snippet.content.endIndex) ?? snippet.content.endIndex
                    appendColored("     ...\(snippet.content[safeStart..<safeEnd])...\n", color: cGray)
                }
            }
            appendOutput("\n")
        }
    }

    // MARK: - Share Card

    func generateShareCard() {
        let evo = Evolution.stage(for: pet.level)
        let skin = currentSkin.rawValue
        let svg = """
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 280" width="500" height="280">
          <style>
            text { font-family: 'SF Mono', 'Consolas', monospace; }
          </style>
          <defs>
            <linearGradient id="bg" x1="0" y1="0" x2="500" y2="280" gradientUnits="userSpaceOnUse">
              <stop offset="0%" stop-color="#0a0a0f"/>
              <stop offset="100%" stop-color="#1a1a2e"/>
            </linearGradient>
            <linearGradient id="accent" x1="0" y1="0" x2="1" y2="0">
              <stop offset="0%" stop-color="#4dd4e6"/>
              <stop offset="100%" stop-color="#b388ff"/>
            </linearGradient>
          </defs>
          <rect width="500" height="280" fill="url(#bg)" rx="16"/>
          <rect width="500" height="280" fill="none" stroke="#4dd4e633" rx="16" stroke-width="1"/>
          <text x="30" y="40" font-size="24" font-weight="bold" fill="url(#accent)">Agent-O</text>
          <text x="30" y="65" font-size="12" fill="#8892b0">ascii desktop companion</text>
          <text x="30" y="105" font-size="14" fill="#e6f1ff">★ Level \(pet.level)</text>
          <text x="140" y="105" font-size="14" fill="#b388ff">\(evo)</text>
          <text x="30" y="135" font-size="12" fill="#8892b0">XP: \(pet.xp)/\(pet.xpForNextLevel)</text>
          <text x="30" y="165" font-size="12" fill="#00e676">Hunger: \(pet.hunger)%</text>
          <text x="140" y="165" font-size="12" fill="#ff4081">Happy: \(pet.happiness)%</text>
          <text x="240" y="165" font-size="12" fill="#ffd740">Energy: \(pet.energy)%</text>
          <text x="30" y="200" font-size="12" fill="#8892b0">Commands: \(pet.totalCommands) · Streak: \(pet.streak)d</text>
          <text x="30" y="225" font-size="12" fill="#8892b0">Skin: \(skin) · Achievements: \(pet.unlockedAchievements.count)/23</text>
          <text x="30" y="260" font-size="10" fill="#484f58">github.com/egorfedorov/agentO</text>
          <text x="390" y="260" font-size="10" fill="#484f58">🤖 \(evo)</text>
        </svg>
        """

        let desktopPath = NSHomeDirectory() + "/Desktop/agento-card.svg"
        do {
            try svg.write(toFile: desktopPath, atomically: true, encoding: String.Encoding.utf8)
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(desktopPath, forType: .string)
            appendColored("🎴 Share card saved!\n", color: cGreen, bold: true)
            appendColored("  📁 ~/Desktop/agento-card.svg\n", color: cGray)
            appendColored("  📋 Path copied to clipboard\n\n", color: cGray)
            bubbleLabel.stringValue = speechBubble("Card exported! 🎴")
            playSound("Pop")
        } catch {
            appendColored("❌ Failed to save: \(error.localizedDescription)\n\n", color: cRed)
        }
    }

    // MARK: - Screenshot

    func captureScreenshot() {
        let tmpPath = NSTemporaryDirectory() + "agento_screenshot.png"
        appendColored("📸 Click and drag to capture a screen area...\n", color: cCyan, bold: true)
        bubbleLabel.stringValue = speechBubble("Select area... 📸")
        setState(.thinking)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
            process.arguments = ["-i", tmpPath]
            try? process.run()
            process.waitUntilExit()

            DispatchQueue.main.async {
                guard let self = self else { return }
                if FileManager.default.fileExists(atPath: tmpPath) {
                    self.appendColored("📸 Screenshot captured!\n", color: self.cGreen, bold: true)
                    self.appendColored("⏳ → claude (analyzing image)...\n", color: self.cDimGray)
                    let oldLevel = self.pet.level
                    self.pet.onCommandRun()
                    self.pet.save()
                    self.refreshStatsDisplay()
                    DispatchQueue.global(qos: .userInitiated).async {
                        self.runCLI(cli: "claude", prompt: "Analyze this screenshot and describe what you see. If there's code, explain it. If there's an error, suggest a fix. Image: \(tmpPath)", oldLevel: oldLevel)
                    }
                } else {
                    self.appendColored("❌ Screenshot cancelled\n\n", color: self.cGray)
                    self.setState(.idle)
                }
            }
        }
    }

    // MARK: - Git Diff Review

    func reviewDiff() {
        setState(.thinking)
        appendColored("🔍 Getting git diff...\n", color: cCyan, bold: true)
        bubbleLabel.stringValue = speechBubble("Reviewing code... 🔍")

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let process = Process()
            let pipe = Pipe()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
            process.arguments = ["diff", "--stat", "--diff-filter=ACDMR", "-p"]
            process.standardOutput = pipe
            process.standardError = pipe
            try? process.run()
            process.waitUntilExit()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let diff = String(data: data, encoding: .utf8) ?? ""

            DispatchQueue.main.async {
                if diff.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.appendColored("✅ No changes to review (clean working tree)\n\n", color: self.cGreen)
                    self.setState(.idle)
                    return
                }
                let truncated = String(diff.prefix(3000))
                self.appendColored("📝 Sending diff to Claude for review...\n", color: self.cDimGray)
                let oldLevel = self.pet.level
                self.pet.onCommandRun()
                self.pet.save()
                self.refreshStatsDisplay()
                DispatchQueue.global(qos: .userInitiated).async {
                    self.runCLI(cli: "claude", prompt: "Review this git diff. Point out potential bugs, suggest improvements, and highlight good changes. Be concise.\n\n\(truncated)", oldLevel: oldLevel)
                }
            }
        }
    }

    // MARK: - Auto Commit Message

    func autoCommitMessage() {
        setState(.thinking)
        appendColored("📝 Generating commit message...\n", color: cCyan, bold: true)
        bubbleLabel.stringValue = speechBubble("Writing commit... 📝")

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            // Get staged diff
            let process = Process()
            let pipe = Pipe()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
            process.arguments = ["diff", "--cached", "--stat", "-p"]
            process.standardOutput = pipe
            process.standardError = pipe
            try? process.run()
            process.waitUntilExit()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let diff = String(data: data, encoding: .utf8) ?? ""

            DispatchQueue.main.async {
                if diff.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.appendColored("❌ No staged changes. Run: git add <files> first\n\n", color: self.cRed)
                    self.setState(.idle)
                    return
                }
                let truncated = String(diff.prefix(3000))
                self.appendColored("⏳ → claude...\n", color: self.cDimGray)
                let oldLevel = self.pet.level
                self.pet.onCommandRun()
                self.pet.save()
                self.refreshStatsDisplay()
                DispatchQueue.global(qos: .userInitiated).async {
                    self.runCLI(cli: "claude", prompt: "Generate a concise git commit message (1-2 lines) for these staged changes. Just the message, no explanation.\n\n\(truncated)", oldLevel: oldLevel)
                }
            }
        }
    }

    // MARK: - Ask About File

    func askAboutFile(_ path: String) {
        let expandedPath = NSString(string: path).expandingTildeInPath
        guard FileManager.default.fileExists(atPath: expandedPath) else {
            appendColored("❌ File not found: \(path)\n\n", color: cRed)
            return
        }
        guard let content = try? String(contentsOfFile: expandedPath, encoding: .utf8) else {
            appendColored("❌ Cannot read file: \(path)\n\n", color: cRed)
            return
        }
        let truncated = String(content.prefix(4000))
        let fileName = (path as NSString).lastPathComponent
        setState(.thinking)
        appendColored("📄 Reading \(fileName) (\(content.count) chars)...\n", color: cCyan)
        bubbleLabel.stringValue = speechBubble("Analyzing \(fileName)...")
        appendColored("⏳ → claude...\n", color: cDimGray)

        let oldLevel = pet.level
        pet.onCommandRun()
        pet.save()
        refreshStatsDisplay()

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: "Explain this file (\(fileName)). What does it do? Any issues?\n\n```\n\(truncated)\n```", oldLevel: oldLevel)
        }
    }

    // MARK: - Chat System

    func newChat() {
        chatSessions.append([])
        currentChat = chatSessions.count - 1
        outputText.textStorage?.setAttributedString(NSAttributedString(string: ""))
        appendColored("💬 New chat #\(currentChat + 1)\n\n", color: cCyan, bold: true)
        bubbleLabel.stringValue = speechBubble("New chat! 💬")
        playSound("Pop")
    }

    func listChats() {
        appendColored("💬 Chats (\(chatSessions.count)):\n", color: cCyan, bold: true)
        for (i, session) in chatSessions.enumerated() {
            let marker = i == currentChat ? " ◀ current" : ""
            let preview = session.last ?? "(empty)"
            let shortPreview = String(preview.prefix(40))
            appendColored("  \(i + 1). ", color: cYellow)
            appendOutput("\(shortPreview)\(marker)\n")
        }
        appendOutput("\n")
        appendColored("  /chat <N> to switch, /chat new for new\n\n", color: cGray)
    }

    func switchChat(to num: Int) {
        let index = num - 1
        guard index >= 0, index < chatSessions.count else {
            appendColored("❌ Chat #\(num) doesn't exist\n\n", color: cRed)
            return
        }
        currentChat = index
        outputText.textStorage?.setAttributedString(NSAttributedString(string: ""))
        appendColored("💬 Switched to chat #\(num)\n\n", color: cCyan, bold: true)
        bubbleLabel.stringValue = speechBubble("Chat #\(num)")
        playSound("Pop")
    }

    // MARK: - Auto-commit Detection

    func checkGitChanges() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let process = Process()
            let pipe = Pipe()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
            process.arguments = ["status", "--porcelain"]
            process.standardOutput = pipe
            process.standardError = Pipe()
            try? process.run()
            process.waitUntilExit()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: .utf8) ?? ""
            let changeCount = output.components(separatedBy: "\n").filter { !$0.isEmpty }.count

            DispatchQueue.main.async {
                guard let self = self else { return }
                if changeCount >= 10 && self.lastGitChangeCount < 10 {
                    self.appendColored("💡 You have \(changeCount) uncommitted changes.\n", color: self.cYellow, bold: true)
                    self.appendColored("   Type /commit to auto-generate a commit message\n\n", color: self.cGray)
                    self.bubbleLabel.stringValue = speechBubble("Time to commit? 💡")
                }
                self.lastGitChangeCount = changeCount
            }
        }
    }

    // MARK: - Enhanced Sounds

    func playSoundForEvent(_ event: String) {
        switch event {
        case "levelup":
            playSound("Hero")
        case "achievement":
            playSound("Glass")
        case "feed", "play", "rest":
            playSound("Pop")
        case "error":
            playSound("Basso")
        case "gamewin":
            playSound("Purr")
        case "translate":
            playSound("Tink")
        case "pomo_done":
            playSound("Submarine")
        default:
            playSound("Pop")
        }
    }

    // MARK: - Quick Actions

    @objc func quickCommit() {
        lastInteraction = Date()
        pet.onCommit()
        pet.save()
        refreshStatsDisplay()
        updateDailyQuest("commit_1", by: 1)
        appendColored("❯ /commit\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble(L10n.t("prep_commit"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: L10n.t("prompt_commit"))
        }
    }

    @objc func quickTest() {
        lastInteraction = Date()
        appendColored("❯ /test\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble(L10n.t("run_tests"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: L10n.t("prompt_test"))
        }
    }

    @objc func quickExplain() {
        lastInteraction = Date()
        appendColored("❯ /explain\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble(L10n.t("find_errors"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: L10n.t("prompt_explain"))
        }
    }

    @objc func quickReview() {
        lastInteraction = Date()
        appendColored("❯ /review\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble(L10n.t("code_review"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: "claude", prompt: L10n.t("prompt_review"))
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
        bubbleLabel.stringValue = speechBubble(L10n.t("dance_msg"))
        playSound("Funk")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.state = .idle
            self?.bubbleLabel.stringValue = speechBubble(L10n.t("dance_done"))
        }
    }

    // MARK: - Run CLI

    func runCLI(cli: String, prompt: String, oldLevel: Int = 0) {
        let process = Process()
        let pipe = Pipe()

        // Learn from the prompt
        brain.learn(from: prompt)
        promptJournal.record(source: cli, prompt: prompt)

        // Enhance prompt with brain context for Claude (not Codex)
        var enhancedPrompt = prompt
        if cli != "codex", let context = brain.buildContext(level: pet.level) {
            enhancedPrompt = "\(context)\n\n\(prompt)"
        }

        // Use shell to get proper PATH
        process.executableURL = URL(fileURLWithPath: "/bin/zsh")
        let escapedPrompt = enhancedPrompt
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
            .replacingOccurrences(of: "$", with: "\\$")
            .replacingOccurrences(of: "`", with: "\\`")

        if cli == "codex" {
            process.arguments = ["-l", "-c", "codex exec \"\(escapedPrompt)\""]
        } else {
            process.arguments = ["-l", "-c", "claude -p \"\(escapedPrompt)\""]
        }

        process.standardOutput = pipe
        process.standardError = pipe
        var env = ProcessInfo.processInfo.environment
        env.removeValue(forKey: "CLAUDECODE")
        env.removeValue(forKey: "CODEX_CLI_SESSION")
        process.environment = env
        currentProcess = process

        do {
            try process.run()
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.appendColored("❌ Error: \(error.localizedDescription)\n\n", color: self!.cRed)
                self?.setState(.error, duration: 3)
                self?.bubbleLabel.stringValue = speechBubble("\(L10n.t("error_launch")) \(cli)!")
                self?.playSound("Basso")
            }
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.setState(.typing)
        }

        var accumulatedOutput = ""
        let fileHandle = pipe.fileHandleForReading
        fileHandle.readabilityHandler = { [weak self] handle in
            let data = handle.availableData
            if data.isEmpty {
                handle.readabilityHandler = nil
                return
            }
            if let str = String(data: data, encoding: .utf8) {
                accumulatedOutput += str
                self?.appendOutput(str)
            }
        }

        process.waitUntilExit()
        currentProcess = nil

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.lastResponse = accumulatedOutput
            self.appendOutput("\n")
            if process.terminationStatus == 0 {
                self.pet.onCommandSuccess()
                self.pet.save()
                self.refreshStatsDisplay()
                self.checkLevelUp(oldLevel: oldLevel)
                self.setState(.happy, duration: 3)
                self.bubbleLabel.stringValue = speechBubble(L10n.t("done_xp"))
                self.playSound("Glass")
            } else {
                self.setState(.error, duration: 3)
                self.bubbleLabel.stringValue = speechBubble(L10n.t("error_exec"))
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
        env.removeValue(forKey: "CODEX_CLI_SESSION")
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
        bubbleLabel.stringValue = speechBubble("\(L10n.t("welcome")) \(L10n.t("toggle_hint"))")
        updateAgentDisplay()

        appendColored("╔═══════════════════════════════════════╗\n", color: cCyan)
        appendColored("║         Agent-O  Terminal              ║\n", color: cCyan)
        appendColored("║  Claude/Codex Assistant + Tamagotchi  ║\n", color: cCyan)
        appendColored("╚═══════════════════════════════════════╝\n\n", color: cCyan)

        if !pet.hasCompletedOnboarding {
            startOnboarding()
            return
        }

        if pet.streak > 1 {
            appendColored("🔥 Welcome back! Streak: \(pet.streak) days! +20 XP\n\n", color: cOrange, bold: true)
        }
        appendColored("  ⌘⇧O   ", color: cYellow, bold: true)
        appendOutput("show/hide window\n")
        appendColored("  ↑↓    ", color: cYellow, bold: true)
        appendOutput("command history\n")
        appendColored("  D&D   ", color: cYellow, bold: true)
        appendOutput("drag & drop file to analyze\n\n")
        appendColored("  /help ", color: cGreen, bold: true)
        appendOutput("all commands  ")
        appendColored("/quests ", color: cYellow, bold: true)
        appendOutput("daily quests\n\n")

        // Show daily quests reminder
        _ = getTodayQuests()
        let done = pet.dailyQuestsCompleted.count
        if done < 3 {
            appendColored("📋 Daily quests: \(done)/3 — type /quests\n\n", color: cDimGray)
        }
    }

    // MARK: - Translation

    static let translateLangs: Set<String> = [
        "EN", "RU", "ES", "FR", "DE", "IT", "PT", "JA", "KO", "ZH", "AR", "HI", "TR", "PL", "NL", "UK", "CS", "SV"
    ]

    func parseTranslateCommand(_ input: String) -> (String, String)? {
        let trimmed = input.trimmingCharacters(in: .whitespaces)
        guard trimmed.count > 3 else { return nil }
        let prefix = String(trimmed.prefix(2)).uppercased()
        let thirdChar = trimmed[trimmed.index(trimmed.startIndex, offsetBy: 2)]
        guard thirdChar == " ", AgentODelegate.translateLangs.contains(prefix) else { return nil }
        let text = String(trimmed.dropFirst(3)).trimmingCharacters(in: .whitespaces)
        guard !text.isEmpty else { return nil }
        return (prefix.lowercased(), text)
    }

    func translateText(_ text: String, to targetLang: String) {
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Translating → \(targetLang.uppercased())...")
        appendColored("🌐 Translating to \(targetLang.uppercased())...\n", color: cPurple)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let encoded = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? text
            let urlString = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=\(targetLang)&dt=t&q=\(encoded)"
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async {
                    self.appendColored("❌ Translation error\n\n", color: self.cRed)
                    self.setState(.error)
                }
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                        self.setState(.error)
                        return
                    }
                    guard let data = data else {
                        self.appendColored("❌ No response\n\n", color: self.cRed)
                        self.setState(.error)
                        return
                    }

                    // Parse Google Translate JSON response
                    // Format: [[["translated text","original text",null,null,10]],null,"ru",...]
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [Any],
                       let sentences = json.first as? [Any] {
                        var translated = ""
                        for item in sentences {
                            if let sentence = item as? [Any], let text = sentence.first as? String {
                                translated += text
                            }
                        }
                        if !translated.isEmpty {
                            self.appendColored("✅ \(targetLang.uppercased()): ", color: self.cGreen, bold: true)
                            self.appendOutput("\(translated)\n")
                            // Copy to clipboard
                            NSPasteboard.general.clearContents()
                            NSPasteboard.general.setString(translated, forType: .string)
                            self.lastClipboard = translated
                            self.lastClipboardCount = NSPasteboard.general.changeCount
                            self.appendColored("📋 Copied to clipboard!\n\n", color: self.cGray)
                            self.bubbleLabel.stringValue = speechBubble("Translated! 📋")
                            self.setState(.happy)
                            self.playSound("Pop")

                            // XP for translation
                            let oldLevel = self.pet.level
                            self.pet.onCommandRun()
                            self.pet.save()
                            self.refreshStatsDisplay()
                            if self.pet.level > oldLevel {
                                self.appendColored("⭐ LEVEL UP! → \(self.pet.level)!\n", color: self.cYellow, bold: true)
                            }
                            return
                        }
                    }
                    self.appendColored("❌ Could not parse translation\n\n", color: self.cRed)
                    self.setState(.error)
                }
            }
            task.resume()
        }
    }

    // MARK: - Quick Calc & Conversions

    func quickCalc(_ input: String) {
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Calculating...")

        // Parse: <amount> <from> to <to>
        let parts = input.lowercased().split(separator: " ")
        guard parts.count >= 4,
              let amount = Double(parts[0]),
              parts[parts.count - 2] == "to" else {
            appendColored("❌ Usage: /calc <amount> <from> to <to>\n", color: cRed)
            appendColored("  Examples:\n", color: cGray)
            appendColored("  /calc 150 usd to rub\n", color: cDimGray)
            appendColored("  /calc 100 km to miles\n", color: cDimGray)
            appendColored("  /calc 2pm est to msk\n\n", color: cDimGray)
            setState(.idle)
            return
        }

        let fromUnit = String(parts[1])
        let toUnit = String(parts[parts.count - 1])

        // Unit conversions (no API needed)
        let unitConversions: [String: [String: (Double) -> Double]] = [
            "km":      ["miles": { $0 / 1.60934 }, "mi": { $0 / 1.60934 }],
            "miles":   ["km": { $0 * 1.60934 }],
            "mi":      ["km": { $0 * 1.60934 }],
            "kg":      ["lbs": { $0 * 2.20462 }, "lb": { $0 * 2.20462 }],
            "lbs":     ["kg": { $0 / 2.20462 }],
            "lb":      ["kg": { $0 / 2.20462 }],
            "c":       ["f": { $0 * 9.0 / 5.0 + 32.0 }],
            "f":       ["c": { ($0 - 32.0) * 5.0 / 9.0 }],
            "cm":      ["inches": { $0 / 2.54 }, "in": { $0 / 2.54 }],
            "inches":  ["cm": { $0 * 2.54 }],
            "in":      ["cm": { $0 * 2.54 }],
            "l":       ["gallons": { $0 / 3.78541 }, "gal": { $0 / 3.78541 }],
            "gallons": ["l": { $0 * 3.78541 }],
            "gal":     ["l": { $0 * 3.78541 }],
        ]

        if let conversions = unitConversions[fromUnit], let converter = conversions[toUnit] {
            let result = converter(amount)
            appendColored("🔢 ", color: cCyan)
            appendColored(String(format: "%.2f %@ = %.2f %@\n\n", amount, fromUnit, result, toUnit), color: cGreen, bold: true)
            bubbleLabel.stringValue = speechBubble(String(format: "%.2f %@!", result, toUnit))
            setState(.happy, duration: 2)
            playSound("Pop")
            return
        }

        // Timezone conversions
        let tzOffsets: [String: Int] = [
            "utc": 0, "gmt": 0, "est": -5, "edt": -4, "cst": -6, "cdt": -5,
            "mst": -7, "mdt": -6, "pst": -8, "pdt": -7, "msk": 3, "eet": 2,
            "eest": 3, "cet": 1, "cest": 2, "jst": 9, "kst": 9, "ist": 5,
            "aest": 10, "aedt": 11, "brt": -3, "cst_cn": 8
        ]

        if let fromOffset = tzOffsets[fromUnit], let toOffset = tzOffsets[toUnit] {
            // Parse time like "2pm", "14", "1430", "2:30pm"
            let timeStr = String(parts[0])
            var hour = 0
            var minute = 0
            let cleanTime = timeStr.replacingOccurrences(of: "am", with: "").replacingOccurrences(of: "pm", with: "")

            if cleanTime.contains(":") {
                let tp = cleanTime.split(separator: ":")
                hour = Int(tp[0]) ?? 0
                minute = tp.count > 1 ? (Int(tp[1]) ?? 0) : 0
            } else {
                hour = Int(cleanTime) ?? 0
            }

            if timeStr.contains("pm") && hour < 12 { hour += 12 }
            if timeStr.contains("am") && hour == 12 { hour = 0 }

            let diff = toOffset - fromOffset
            var newHour = (hour + diff) % 24
            if newHour < 0 { newHour += 24 }

            let fromFormatted = String(format: "%02d:%02d %@", hour, minute, fromUnit.uppercased())
            let toFormatted = String(format: "%02d:%02d %@", newHour, minute, toUnit.uppercased())

            appendColored("🕐 ", color: cCyan)
            appendColored("\(fromFormatted) = \(toFormatted)", color: cGreen, bold: true)
            let diffSign = diff >= 0 ? "+" : ""
            appendColored("  (\(diffSign)\(diff)h)\n\n", color: cDimGray)
            bubbleLabel.stringValue = speechBubble("\(toFormatted)")
            setState(.happy, duration: 2)
            playSound("Pop")
            return
        }

        // Currency conversion (API)
        let currencies: Set<String> = ["usd", "eur", "rub", "gbp", "jpy", "cny", "krw", "try", "brl", "inr", "uah", "pln", "czk", "sek", "mxn"]
        guard currencies.contains(fromUnit), currencies.contains(toUnit) else {
            appendColored("❌ Unknown conversion: \(fromUnit) → \(toUnit)\n", color: cRed)
            appendColored("  Currencies: USD EUR RUB GBP JPY CNY KRW TRY BRL INR UAH PLN CZK SEK MXN\n", color: cDimGray)
            appendColored("  Units: km↔miles, kg↔lbs, C↔F, cm↔inches, L↔gallons\n", color: cDimGray)
            appendColored("  Timezones: UTC EST PST MSK JST KST CET etc.\n\n", color: cDimGray)
            setState(.idle)
            return
        }

        // Check cache (1 hour)
        if let rates = cachedRates,
           let cacheDate = ratesCacheDate,
           Date().timeIntervalSince(cacheDate) < 3600 {
            performCurrencyConversion(amount: amount, from: fromUnit, to: toUnit, rates: rates)
            return
        }

        appendColored("💱 Fetching exchange rates...\n", color: cDimGray)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: "https://open.er-api.com/v6/latest/USD"),
                  let data = try? Data(contentsOf: url),
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let rates = json["rates"] as? [String: Double] else {
                DispatchQueue.main.async {
                    self.appendColored("❌ Failed to fetch exchange rates\n\n", color: self.cRed)
                    self.setState(.error, duration: 2)
                }
                return
            }

            DispatchQueue.main.async {
                self.cachedRates = rates.reduce(into: [String: Double]()) { $0[$1.key.lowercased()] = $1.value }
                self.ratesCacheDate = Date()
                self.performCurrencyConversion(amount: amount, from: fromUnit, to: toUnit, rates: self.cachedRates!)
            }
        }
    }

    func performCurrencyConversion(amount: Double, from: String, to: String, rates: [String: Double]) {
        guard let fromRate = rates[from], let toRate = rates[to], fromRate > 0 else {
            appendColored("❌ Rate not found for \(from) or \(to)\n\n", color: cRed)
            setState(.error, duration: 2)
            return
        }

        let result = amount / fromRate * toRate
        appendColored("💱 ", color: cCyan)
        appendColored(String(format: "%.2f %@ = %.2f %@\n\n", amount, from.uppercased(), result, to.uppercased()), color: cGreen, bold: true)
        bubbleLabel.stringValue = speechBubble(String(format: "%.2f %@", result, to.uppercased()))
        setState(.happy, duration: 2)
        playSound("Pop")
    }

    // MARK: - Regex Builder

    func regexBuilder(_ description: String) {
        guard !description.isEmpty else {
            appendColored("❌ Usage: /regex <description>\n", color: cRed)
            appendColored("  Example: /regex email validation\n", color: cDimGray)
            appendColored("  Example: /regex match dates like 2024-01-15\n\n", color: cDimGray)
            setState(.idle)
            return
        }

        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Building regex...")
        appendColored("🔧 Regex Builder: \(description)\n", color: cCyan, bold: true)
        appendColored("⏳ → claude...\n", color: cDimGray)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let prompt = "Generate a regex pattern for: \(description). Output format:\nPattern: <regex>\nExample matches: <3 examples>\nExplanation: <brief>"
            let escapedPrompt = prompt
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")
                .replacingOccurrences(of: "$", with: "\\$")
                .replacingOccurrences(of: "`", with: "\\`")
            let result = self.shell("claude -p \"\(escapedPrompt)\"")?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            DispatchQueue.main.async {
                guard !result.isEmpty else {
                    self.appendColored("❌ Could not generate regex\n\n", color: self.cRed)
                    self.setState(.error, duration: 2)
                    return
                }

                // Display result
                self.appendColored("\n", color: self.cGreen)
                for line in result.split(separator: "\n", omittingEmptySubsequences: false) {
                    let l = String(line)
                    if l.hasPrefix("Pattern:") {
                        self.appendColored("  \(l)\n", color: self.cGreen, bold: true)
                    } else if l.hasPrefix("Example") {
                        self.appendColored("  \(l)\n", color: self.cYellow)
                    } else if l.hasPrefix("Explanation") {
                        self.appendColored("  \(l)\n", color: self.cGray)
                    } else {
                        self.appendColored("  \(l)\n", color: self.cGray)
                    }
                }
                self.appendOutput("\n")

                // Extract and copy just the pattern to clipboard
                if let patternLine = result.split(separator: "\n").first(where: { $0.hasPrefix("Pattern:") }) {
                    let pattern = String(patternLine.dropFirst(8)).trimmingCharacters(in: .whitespaces)
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(pattern, forType: .string)
                    self.appendColored("📋 Pattern copied to clipboard\n\n", color: self.cDimGray)
                }

                self.bubbleLabel.stringValue = speechBubble("Regex ready!")
                self.setState(.happy, duration: 2)
                self.playSound("Pop")
            }
        }
    }

    // MARK: - Daily Summary

    func checkDayReset() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        if todayDate != today {
            todayDate = today
            todayCommands = 0
            todayXP = 0
        }
    }

    func trackDailyCommand(xpEarned: Int = 0) {
        checkDayReset()
        todayCommands += 1
        todayXP += xpEarned
    }

    func showDailySummary() {
        checkDayReset()
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Here's your day!")

        let elapsed = Date().timeIntervalSince(sessionStart)
        let hours = Int(elapsed) / 3600
        let minutes = (Int(elapsed) % 3600) / 60

        appendColored("╭── Daily Summary ────────────────────╮\n", color: cCyan)

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        appendColored("  📅 \(formatter.string(from: Date()))\n\n", color: cYellow, bold: true)

        // Commands today
        appendColored("  ⌨️  Commands today:  ", color: cGray)
        appendColored("\(todayCommands)\n", color: cGreen, bold: true)

        // XP today
        appendColored("  ⭐ XP earned today:  ", color: cGray)
        appendColored("\(todayXP)\n", color: cGreen, bold: true)

        // Session time
        appendColored("  ⏱  Session time:    ", color: cGray)
        if hours > 0 {
            appendColored("\(hours)h \(minutes)m\n", color: cGreen, bold: true)
        } else {
            appendColored("\(minutes)m\n", color: cGreen, bold: true)
        }

        // Streak
        appendColored("  🔥 Current streak:  ", color: cGray)
        appendColored("\(pet.streak) day\(pet.streak == 1 ? "" : "s")\n", color: cGreen, bold: true)

        // Git commits today
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            let gitLog = self.shell("git log --oneline --since=\"midnight\" --author=\"$(git config user.name)\" 2>/dev/null | head -20") ?? ""
            let commitCount = gitLog.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0 :
                gitLog.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "\n").count

            DispatchQueue.main.async {
                self.appendColored("  📝 Git commits:     ", color: self.cGray)
                self.appendColored("\(commitCount)\n", color: self.cGreen, bold: true)

                // Pet stats
                self.appendColored("\n  Pet Stats:\n", color: self.cPurple, bold: true)
                self.appendColored("  🍕 Hunger:    \(self.pet.hunger)/100\n", color: self.cGray)
                self.appendColored("  😊 Happiness: \(self.pet.happiness)/100\n", color: self.cGray)
                self.appendColored("  ⚡ Energy:    \(self.pet.energy)/100\n", color: self.cGray)
                self.appendColored("  ⭐ Level:     \(self.pet.level) (\(self.pet.xp)/\(self.pet.xpForNextLevel) XP)\n", color: self.cGray)

                // Achievements
                let totalAchievements = self.pet.unlockedAchievements.count
                self.appendColored("  🏆 Achievements:    \(totalAchievements)/\(Achievement.all.count)\n", color: self.cGray)

                self.appendColored("╰────────────────────────────────────╯\n\n", color: self.cCyan)

                // Award bonus XP
                let oldLevel = self.pet.level
                self.pet.gainXP(20)
                self.todayXP += 20
                self.appendColored("  +20 XP for checking daily summary!\n\n", color: self.cYellow)
                if self.pet.level > oldLevel {
                    self.appendColored("⭐ LEVEL UP! → \(self.pet.level)!\n\n", color: self.cYellow, bold: true)
                }
                self.pet.save()
                self.refreshStatsDisplay()

                self.bubbleLabel.stringValue = speechBubble("Keep up the great work!")
                self.setState(.happy, duration: 3)
                self.playSound("Pop")
            }
        }
    }

    func promptIntentBucket(_ text: String) -> String {
        let lower = text.lowercased()
        if lower.contains("fix") || lower.contains("bug") || lower.contains("error") || lower.contains("stack trace") {
            return "Debug"
        }
        if lower.contains("review") || lower.contains("audit") || lower.contains("code review") {
            return "Review"
        }
        if lower.contains("refactor") || lower.contains("optimize") || lower.contains("improve") {
            return "Improve"
        }
        if lower.contains("write") || lower.contains("generate") || lower.contains("create") || lower.contains("build") {
            return "Create"
        }
        if lower.contains("explain") || lower.contains("analyze") || lower.contains("summary") {
            return "Explain"
        }
        return "General"
    }

    func promptHasContext(_ text: String) -> Bool {
        let lower = text.lowercased()
        if lower.contains("file") || lower.contains("line") || lower.contains("error") || lower.contains("trace") {
            return true
        }
        if text.contains("/") || text.contains(".swift") || text.contains(".ts") || text.contains(".py") || text.contains(".js") {
            return true
        }
        return false
    }

    func promptHasOutputFormat(_ text: String) -> Bool {
        let lower = text.lowercased()
        return lower.contains("output") ||
            lower.contains("format") ||
            lower.contains("json") ||
            lower.contains("steps") ||
            lower.contains("bullet") ||
            lower.contains("table")
    }

    func showPromptStats(days: Int) {
        let safeDays = max(1, min(30, days))
        let entries = promptJournal.entries(forLastDays: safeDays)
        if entries.isEmpty {
            appendColored("📭 No prompts logged for last \(safeDays) day(s).\n", color: cDimGray)
            appendColored("  Use Claude/Codex in Agent-O, then run /promptstats again.\n\n", color: cGray)
            return
        }

        var totalChars = 0
        var totalWords = 0
        var claudeCount = 0
        var codexCount = 0
        var contextCount = 0
        var formatCount = 0
        var intentCounts: [String: Int] = [:]
        var longest: (chars: Int, source: String, text: String)? = nil

        for entry in entries {
            let chars = entry["chars"] as? Int ?? 0
            let words = entry["words"] as? Int ?? 0
            let source = entry["source"] as? String ?? "claude"
            let text = entry["text"] as? String ?? ""

            totalChars += chars
            totalWords += words
            if source == "codex" { codexCount += 1 } else { claudeCount += 1 }
            if promptHasContext(text) { contextCount += 1 }
            if promptHasOutputFormat(text) { formatCount += 1 }
            let intent = promptIntentBucket(text)
            intentCounts[intent, default: 0] += 1

            if let current = longest {
                if chars > current.chars {
                    longest = (chars, source, text)
                }
            } else {
                longest = (chars, source, text)
            }
        }

        let count = entries.count
        let avgChars = count > 0 ? totalChars / count : 0
        let avgWords = count > 0 ? totalWords / count : 0
        let contextPct = count > 0 ? (contextCount * 100 / count) : 0
        let formatPct = count > 0 ? (formatCount * 100 / count) : 0
        let topIntent = intentCounts.max { a, b in a.value < b.value }?.key ?? "General"

        appendColored("╭── Prompt Stats ─────────────────────╮\n", color: cCyan)
        appendColored("  Window: last \(safeDays) day(s)\n", color: cGray)
        appendColored("  Total prompts: ", color: cGray)
        appendColored("\(count)\n", color: cGreen, bold: true)
        appendColored("  Claude/Codex: ", color: cGray)
        appendColored("\(claudeCount)/\(codexCount)\n", color: cYellow, bold: true)
        appendColored("  Avg size: ", color: cGray)
        appendColored("\(avgWords) words, \(avgChars) chars\n", color: cYellow)
        appendColored("  With context: ", color: cGray)
        appendColored("\(contextPct)%\n", color: cGreen)
        appendColored("  With output format: ", color: cGray)
        appendColored("\(formatPct)%\n", color: cGreen)
        appendColored("  Top intent: ", color: cGray)
        appendColored("\(topIntent)\n", color: cPurple, bold: true)

        if let longest = longest {
            let preview = String(longest.text.prefix(100)).replacingOccurrences(of: "\n", with: " ")
            appendColored("  Longest prompt (\(longest.source)): ", color: cGray)
            appendColored("\(longest.chars) chars\n", color: cYellow)
            appendColored("    \(preview)\(longest.text.count > 100 ? "..." : "")\n", color: cDimGray)
        }
        appendColored("╰────────────────────────────────────╯\n\n", color: cCyan)
    }

    func showPromptCoach(days: Int) {
        let safeDays = max(1, min(30, days))
        let entries = promptJournal.entries(forLastDays: safeDays)
        if entries.isEmpty {
            appendColored("📭 No prompts to coach yet for last \(safeDays) day(s).\n", color: cDimGray)
            appendColored("  Run Claude/Codex prompts first, then /promptcoach.\n\n", color: cGray)
            return
        }

        let count = entries.count
        var shortCount = 0
        var longCount = 0
        var contextCount = 0
        var formatCount = 0
        var repeatedStarts: [String: Int] = [:]

        for entry in entries {
            let words = entry["words"] as? Int ?? 0
            let text = entry["text"] as? String ?? ""
            if words < 12 { shortCount += 1 }
            if words > 220 { longCount += 1 }
            if promptHasContext(text) { contextCount += 1 }
            if promptHasOutputFormat(text) { formatCount += 1 }

            let firstWords = text.split(separator: " ").prefix(2).map { String($0).lowercased() }.joined(separator: " ")
            if !firstWords.isEmpty {
                repeatedStarts[firstWords, default: 0] += 1
            }
        }

        let shortPct = shortCount * 100 / count
        let longPct = longCount * 100 / count
        let contextPct = contextCount * 100 / count
        let formatPct = formatCount * 100 / count
        let topStart = repeatedStarts.max { a, b in a.value < b.value }

        appendColored("╭── Prompt Coach ─────────────────────╮\n", color: cPurple)
        appendColored("  Window: last \(safeDays) day(s), \(count) prompt(s)\n\n", color: cGray)

        if shortPct > 35 {
            appendColored("  1) Prompts too short (\(shortPct)%).\n", color: cYellow, bold: true)
            appendColored("     Add goal + context + constraints in one message.\n", color: cGray)
        } else {
            appendColored("  1) Prompt length is mostly healthy.\n", color: cGreen)
        }

        if contextPct < 65 {
            appendColored("  2) Add concrete context more often (\(contextPct)% now).\n", color: cYellow, bold: true)
            appendColored("     Mention files, errors, env, or expected behavior.\n", color: cGray)
        } else {
            appendColored("  2) Context quality is good (\(contextPct)% with context).\n", color: cGreen)
        }

        if formatPct < 50 {
            appendColored("  3) Ask for output format explicitly (\(formatPct)% now).\n", color: cYellow, bold: true)
            appendColored("     Example: \"Output: steps + patch + test command\".\n", color: cGray)
        } else {
            appendColored("  3) Output-format requests are solid (\(formatPct)%).\n", color: cGreen)
        }

        if longPct > 20 {
            appendColored("  4) Some prompts are very long (\(longPct)%).\n", color: cYellow, bold: true)
            appendColored("     Move background to bullets; keep ask in first line.\n", color: cGray)
        } else {
            appendColored("  4) Prompt verbosity is under control.\n", color: cGreen)
        }

        if let topStart = topStart, topStart.value >= 5 {
            appendColored("  5) You often start with \"\(topStart.key)\" (\(topStart.value)x).\n", color: cYellow, bold: true)
            appendColored("     Vary starts: fix/review/build/compare to improve intent clarity.\n", color: cGray)
        } else {
            appendColored("  5) Prompt openings are varied enough.\n", color: cGreen)
        }

        appendColored("\n  Suggested template:\n", color: cCyan, bold: true)
        appendColored("  Goal: <what outcome you need>\n", color: cDimGray)
        appendColored("  Context: <files/errors/constraints>\n", color: cDimGray)
        appendColored("  Output: <format + acceptance checks>\n", color: cDimGray)
        appendColored("╰────────────────────────────────────╯\n\n", color: cPurple)
    }

    func showHelp() {
        appendColored("╭── Commands ─────────────────────────╮\n", color: cCyan)
        appendColored("  CLI\n", color: cPurple, bold: true)
        let cliCmds: [(String, String)] = [
            ("text", "→ send to Claude"),
            ("/claude <p>", "→ explicitly to Claude CLI"),
            ("/codex <p>", "→ explicitly to Codex CLI"),
            ("/paste", "→ analyze clipboard content"),
        ]
        for (cmd, desc) in cliCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Tamagotchi\n", color: cPurple, bold: true)
        let petCmds: [(String, String)] = [
            ("/feed", "→ feed Agent-O (+Food)"),
            ("/play", "→ play with Agent-O (+Joy)"),
            ("/rest", "→ let Agent-O rest (+Energy)"),
            ("/stats", "→ full pet stats"),
            ("/evo", "→ evolution stage info"),
            ("/ach", "→ achievements list"),
        ]
        for (cmd, desc) in petCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Fun & Focus\n", color: cPurple, bold: true)
        let funCmds: [(String, String)] = [
            ("/game", "→ number guessing game"),
            ("/trivia", "→ dev trivia quiz"),
            ("/typing", "→ typing speed test"),
            ("/dance", "→ let's dance!"),
            ("/quests", "→ daily quests"),
            ("/inventory", "→ your items"),
            ("/pomo", "→ 25 min pomodoro timer"),
            ("/pomo10", "→ 10 min pomodoro"),
            ("/break", "→ 5 min break timer"),
            ("/stoppomo", "→ stop timer"),
        ]
        for (cmd, desc) in funCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Customization\n", color: cPurple, bold: true)
        let custCmds: [(String, String)] = [
            ("/skin <name>", "→ robot/cat/skull/clippy"),
            ("/theme <name>", "→ matrix/cyberpunk/sunset/ocean/hacker"),
        ]
        for (cmd, desc) in custCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Translation\n", color: cPurple, bold: true)
        let transCmds: [(String, String)] = [
            ("EN <text>", "→ translate to English"),
            ("RU <text>", "→ translate to Russian"),
            ("ES/FR/DE...", "→ any language (18 supported)"),
            ("/translate ru", "→ auto-translate clipboard → RU"),
            ("/translate en", "→ auto-translate clipboard → EN"),
            ("/translate off", "→ stop auto-translate"),
        ]
        for (cmd, desc) in transCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Tools\n", color: cPurple, bold: true)
        appendColored("  Smart Tools\n", color: cPurple, bold: true)
        let smartCmds: [(String, String)] = [
            ("/screenshot", "→ capture & analyze screen area"),
            ("/diff", "→ AI code review of git changes"),
            ("/commit", "→ auto-generate commit message"),
            ("/ask <file>", "→ analyze a file with Claude"),
            ("/watch", "→ clipboard watcher on"),
            ("/unwatch", "→ clipboard watcher off"),
            ("/save", "→ save last response"),
            ("/snippets", "→ list saved snippets"),
            ("/search <q>", "→ search snippets"),
            ("/share", "→ export pet share card"),
            ("/chat new", "→ start new chat"),
            ("/chat list", "→ list all chats"),
            ("/chat <N>", "→ switch to chat N"),
            ("/remind <t> ..", "→ set reminder (30m/2h)"),
            ("/reminders", "→ list active reminders"),
            ("/standup", "→ daily standup report"),
            ("/sh <desc>", "→ NL → shell command"),
            ("/clipboard", "→ clipboard history"),
            ("/calc <expr>", "→ calc/convert/currency"),
            ("/regex <desc>", "→ build regex pattern"),
            ("/daily", "→ daily activity summary"),
            ("/promptstats [N]", "→ prompt stats for N days"),
            ("/promptcoach [N]", "→ prompt quality feedback"),
            ("/teach <fact>", "→ teach your pet something"),
            ("/memory", "→ what your pet knows"),
            ("/brain", "→ export pet brain (JSON)"),
            ("/forget <fact>", "→ make pet forget"),
        ]
        for (cmd, desc) in smartCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        appendColored("  Social\n", color: cPurple, bold: true)
        let socialCmds: [(String, String)] = [
            ("/name <name>", "→ set leaderboard name"),
            ("/leaderboard", "→ publish to leaderboard"),
            ("/battle <user>", "→ send battle challenge"),
            ("/challenges", "→ incoming battle challenges"),
            ("/accept <user>", "→ accept battle challenge"),
            ("/decline <user>", "→ decline battle challenge"),
            ("/move <atk> <def>", "→ submit duel move"),
            ("/battles", "→ battle history"),
        ]
        for (cmd, desc) in socialCmds {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
        let toolCmds: [(String, String)] = [
            ("/git", "→ git project status"),
            ("/ps", "→ monitor processes"),
            ("/tip", "→ random tip"),
            ("/history", "→ command history"),
            ("/update", "→ check & install updates"),
            ("/version", "→ current version"),
            ("/clear", "→ clear output"),
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

    // MARK: - Pet Brain

    func showBrainMemory() {
        let iqLabel: String
        if pet.level >= 20 { iqLabel = "Cosmic IQ" }
        else if pet.level >= 15 { iqLabel = "Mythic IQ" }
        else if pet.level >= 10 { iqLabel = "Epic IQ" }
        else if pet.level >= 5 { iqLabel = "Evolved IQ" }
        else { iqLabel = "Baby IQ" }

        appendColored("╭── Pet Brain ────────────────────────╮\n", color: cPurple)
        appendColored("  Intelligence: \(iqLabel) (Lv.\(pet.level))\n", color: cCyan, bold: true)

        if brain.languages.isEmpty {
            appendColored("  Languages: (none detected yet)\n", color: cGray)
        } else {
            appendColored("  Languages: \(brain.languages.joined(separator: ", "))\n", color: cGreen)
        }

        if brain.frameworks.isEmpty {
            appendColored("  Frameworks: (none detected yet)\n", color: cGray)
        } else {
            appendColored("  Frameworks: \(brain.frameworks.joined(separator: ", "))\n", color: cGreen)
        }

        if brain.facts.isEmpty {
            appendColored("  Facts: (none taught yet, use /teach)\n", color: cGray)
        } else {
            appendColored("  Facts: \(brain.facts.joined(separator: "; "))\n", color: cGreen)
        }

        if brain.lastTopics.isEmpty {
            appendColored("  Recent topics: (none yet)\n", color: cGray)
        } else {
            let recent = brain.lastTopics.suffix(5).joined(separator: "\n    ")
            appendColored("  Recent topics:\n    \(recent)\n", color: cDimGray)
        }

        appendColored("  Patterns tracked: \(brain.patterns.count)\n", color: cDimGray)

        appendColored("  ──────────────────────────────────\n", color: cPurple)
        if pet.level < 5 {
            appendColored("  Brain inactive (unlocks at Lv.5)\n", color: cYellow)
        } else if pet.level < 10 {
            appendColored("  Active: injects languages & frameworks\n", color: cGreen)
        } else if pet.level < 15 {
            appendColored("  Active: + user facts & preferences\n", color: cGreen)
        } else if pet.level < 20 {
            appendColored("  Active: + recent topic context\n", color: cGreen)
        } else {
            appendColored("  Active: FULL enhancement (expert mode)\n", color: cGreen, bold: true)
        }
        appendColored("╰────────────────────────────────────╯\n\n", color: cPurple)
        playSound("Pop")
    }

    func exportBrain() {
        let exportPath = NSHomeDirectory() + "/Desktop/agento-brain.json"
        let data: [String: Any] = [
            "facts": brain.facts,
            "languages": brain.languages,
            "frameworks": brain.frameworks,
            "patterns": brain.patterns,
            "lastTopics": brain.lastTopics,
            "petLevel": pet.level,
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted),
           let json = String(data: jsonData, encoding: .utf8) {
            do {
                try json.write(toFile: exportPath, atomically: true, encoding: .utf8)
                let size = jsonData.count
                appendColored("Exported pet brain!\n", color: cGreen, bold: true)
                appendColored("  Path: \(exportPath)\n", color: cCyan)
                appendColored("  Size: \(size) bytes\n", color: cGray)
                appendColored("  Languages: \(brain.languages.count), Frameworks: \(brain.frameworks.count), Facts: \(brain.facts.count)\n\n", color: cGray)
                bubbleLabel.stringValue = speechBubble("Brain exported!")
                playSound("Pop")
            } catch {
                appendColored("Export failed: \(error.localizedDescription)\n\n", color: cRed)
            }
        }
    }

    // MARK: - Leaderboard

    func submitToLeaderboard() {
        if playerUsername.isEmpty {
            appendColored("❌ Set your name first: /name YourName\n\n", color: cRed)
            return
        }

        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Publishing to leaderboard...")
        appendColored("🏆 Submitting to leaderboard...\n", color: cYellow)

        if playerAuthToken.isEmpty {
            playerAuthToken = UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
            UserDefaults.standard.set(playerAuthToken, forKey: "agento_player_token")
            pet.leaderboardToken = playerAuthToken
            pet.leaderboardUsername = playerUsername
            pet.save()
        }

        let payload: [String: Any] = [
            "username": playerUsername,
            "token": playerAuthToken,
            "level": pet.level,
            "xp": pet.xp,
            "totalCommands": pet.totalCommands,
            "streak": pet.streak,
            "achievements": pet.unlockedAchievements.count,
            "hunger": pet.hunger,
            "happiness": pet.happiness,
            "energy": pet.energy,
            "skin": currentSkin.rawValue
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload),
              let url = URL(string: "\(AgentODelegate.leaderboardURL)/api/submit") else {
            appendColored("❌ Failed to create request\n\n", color: cRed)
            setState(.error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let error = error {
                    self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                    self.setState(.error)
                    return
                }

                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if statusCode >= 400 {
                        let errorText = json["error"] as? String ?? "Submit failed (HTTP \(statusCode))"
                        self.appendColored("❌ \(errorText)\n\n", color: self.cRed)
                        self.setState(.error)
                        return
                    }

                    if let token = json["token"] as? String, !token.isEmpty {
                        self.playerAuthToken = token
                        UserDefaults.standard.set(token, forKey: "agento_player_token")
                        self.pet.leaderboardToken = token
                        self.pet.leaderboardUsername = self.playerUsername
                        self.pet.save()
                    }

                    if let rank = json["rank"] as? Int {
                        self.appendColored("✅ Published! ", color: self.cGreen, bold: true)
                        self.appendColored("Rank: #\(rank)\n", color: self.cYellow, bold: true)
                        self.appendColored("  Protected profile: enabled\n", color: self.cDimGray)
                        self.appendColored("  View: \(AgentODelegate.leaderboardURL)\n\n", color: self.cCyan)
                        self.setState(.happy)
                        self.bubbleLabel.stringValue = speechBubble("Rank #\(rank)! 🏆")
                        self.playSound("Glass")
                    } else {
                        self.appendColored("✅ Submitted!\n", color: self.cGreen, bold: true)
                        self.appendColored("  Protected profile: enabled\n", color: self.cDimGray)
                        self.appendColored("  View: \(AgentODelegate.leaderboardURL)\n\n", color: self.cCyan)
                        self.setState(.happy)
                    }
                } else if statusCode >= 400 {
                    self.appendColored("❌ Submit failed (HTTP \(statusCode))\n\n", color: self.cRed)
                    self.setState(.error)
                } else {
                    self.appendColored("✅ Submitted!\n\n", color: self.cGreen, bold: true)
                    self.setState(.happy)
                }
            }
        }
        task.resume()
    }

    // MARK: - Pet Battles

    func resetDuelContext() {
        duelStatusTimer?.invalidate()
        duelStatusTimer = nil
        activeDuel = nil
        duelLastStatusSignature = ""
    }

    func normalizedBattleZone(_ raw: String) -> String? {
        let key = raw.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch key {
        case "head", "h", "голова", "headshot":
            return "head"
        case "body", "torso", "b", "туловище", "корпус":
            return "body"
        case "legs", "leg", "l", "ноги", "нога":
            return "legs"
        default:
            return nil
        }
    }

    func zoneLabel(_ zone: String) -> String {
        switch zone {
        case "head": return "Head"
        case "body": return "Body"
        case "legs": return "Legs"
        default: return zone
        }
    }

    func challengeStatusURL(challenger: String, opponent: String) -> URL? {
        let safeChallenger = challenger.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? challenger
        let safeOpponent = opponent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? opponent
        let safeToken = playerAuthToken.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? playerAuthToken
        return URL(string: "\(AgentODelegate.leaderboardURL)/api/battles/challenge/status?challenger=\(safeChallenger)&opponent=\(safeOpponent)&token=\(safeToken)")
    }

    func duelStatusSignature(battle: [String: Any]) -> String {
        let status = battle["status"] as? String ?? "unknown"
        let challengerMove = battle["challengerMove"] as? [String: Any]
        let opponentMove = battle["opponentMove"] as? [String: Any]
        let challengerAttack = challengerMove?["attack"] as? String ?? "-"
        let challengerDefense = challengerMove?["defense"] as? String ?? "-"
        let opponentAttack = opponentMove?["attack"] as? String ?? "-"
        let opponentDefense = opponentMove?["defense"] as? String ?? "-"
        let winner = battle["winner"] as? String ?? "-"
        return "\(status)|\(challengerAttack)|\(challengerDefense)|\(opponentAttack)|\(opponentDefense)|\(winner)"
    }

    func renderMoveHelp(opponent: String, alreadySubmitted: Bool) {
        appendColored("🧠 Duel phase: choose your attack + defense.\n", color: cYellow, bold: true)
        appendColored("  Zones: head | body | legs\n", color: cGray)
        appendColored("  Command: /move <attack> <defense>\n", color: cGray)
        if alreadySubmitted {
            appendColored("  Move locked. Waiting for \(opponent)...\n\n", color: cDimGray)
        } else {
            appendColored("  Example: /move head body\n\n", color: cDimGray)
        }
    }

    func beginDuelPolling(challenger: String, opponent: String) {
        if let timer = duelStatusTimer,
           timer.isValid,
           activeDuel?.challenger.lowercased() == challenger.lowercased(),
           activeDuel?.opponent.lowercased() == opponent.lowercased() {
            return
        }
        duelStatusTimer?.invalidate()
        duelStatusTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.pollDuelStatus(challenger: challenger, opponent: opponent)
        }
    }

    func pollDuelStatus(challenger: String, opponent: String) {
        guard battleActive else {
            resetDuelContext()
            return
        }
        guard let url = challengeStatusURL(challenger: challenger, opponent: opponent) else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard self.battleActive else {
                    self.resetDuelContext()
                    return
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    return
                }

                let status = (json["status"] as? String ?? "").lowercased()
                if status == "declined" || status == "expired" || status == "not_found" {
                    self.appendColored("⌛ Battle challenge ended (\(status)).\n\n", color: self.cDimGray)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.setState(.idle)
                    self.resetDuelContext()
                    return
                }
                _ = self.runResolvedBattle(from: json, publishResult: false)
            }
        }.resume()
    }

    func startBattle(opponent: String) {
        if playerUsername.isEmpty {
            appendColored("❌ Set your name first: /name YourName\n", color: cRed)
            appendColored("  Then /leaderboard to publish stats\n\n", color: cGray)
            return
        }
        let cleanOpponent = opponent.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanOpponent.isEmpty {
            appendColored("❌ Usage: /battle <username>\n\n", color: cRed)
            return
        }
        if battleActive || activeDuel != nil {
            appendColored("⚠️  Battle already in progress. Wait for it to finish.\n\n", color: cYellow)
            return
        }
        if cleanOpponent.lowercased() == playerUsername.lowercased() {
            appendColored("❌ You can't battle yourself!\n\n", color: cRed)
            return
        }

        battleActive = true
        resetDuelContext()
        let pollToken = UUID()
        pendingBattlePollToken = pollToken
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Challenge sent to \(cleanOpponent)")
        appendColored("⚔️  Challenge sent to \(cleanOpponent)\n", color: cYellow, bold: true)
        appendColored("  They need to run: /accept \(playerUsername)\n", color: cGray)
        appendColored("  Waiting for confirmation...\n\n", color: cGray)

        guard let url = URL(string: "\(AgentODelegate.leaderboardURL)/api/battles/challenge") else {
            appendColored("❌ Failed to create challenge request\n\n", color: cRed)
            battleActive = false
            pendingBattlePollToken = nil
            resetDuelContext()
            setState(.error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let payload: [String: Any] = [
            "challenger": playerUsername,
            "opponent": cleanOpponent,
            "token": playerAuthToken
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let error = error {
                    self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                    self.setState(.error)
                    return
                }

                if let http = response as? HTTPURLResponse, http.statusCode >= 400 {
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let serverError = json["error"] as? String {
                        self.appendColored("❌ \(serverError)\n\n", color: self.cRed)
                        self.battleActive = false
                        self.pendingBattlePollToken = nil
                        self.resetDuelContext()
                        self.setState(.error)
                        return
                    }
                    if http.statusCode == 404 {
                        self.appendColored("⚠️  Challenge API not deployed yet, starting direct battle.\n\n", color: self.cYellow)
                        self.pendingBattlePollToken = nil
                        self.fetchOpponentAndRunBattle(opponent: cleanOpponent)
                        return
                    }
                    self.appendColored("❌ Challenge request failed (HTTP \(http.statusCode))\n\n", color: self.cRed)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                    self.setState(.error)
                    return
                }

                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    self.appendColored("❌ Invalid challenge response\n\n", color: self.cRed)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                    self.setState(.error)
                    return
                }

                let status = (json["status"] as? String ?? "pending").lowercased()
                if status == "accepted" {
                    self.pendingBattlePollToken = nil
                    self.appendColored("✅ Challenge accepted by \(cleanOpponent)!\n\n", color: self.cGreen, bold: true)
                    if self.runResolvedBattle(from: json, publishResult: false) {
                        return
                    }
                    self.fetchOpponentAndRunBattle(opponent: cleanOpponent)
                    return
                }

                if status == "declined" {
                    self.appendColored("❌ \(cleanOpponent) declined your challenge.\n\n", color: self.cRed)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                    self.setState(.error)
                    return
                }

                self.pollBattleChallengeStatus(opponent: cleanOpponent, pollToken: pollToken, attemptsLeft: 30)
            }
        }
        task.resume()
    }

    func pollBattleChallengeStatus(opponent: String, pollToken: UUID, attemptsLeft: Int) {
        guard battleActive, pendingBattlePollToken == pollToken else { return }
        guard attemptsLeft > 0 else {
            appendColored("⌛ No response from \(opponent). Challenge expired.\n\n", color: cDimGray)
            battleActive = false
            pendingBattlePollToken = nil
            resetDuelContext()
            setState(.idle)
            bubbleLabel.stringValue = speechBubble("No accept yet.")
            return
        }

        let safeChallenger = playerUsername.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? playerUsername
        let safeOpponent = opponent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? opponent
        let safeToken = playerAuthToken.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? playerAuthToken
        guard let url = URL(string: "\(AgentODelegate.leaderboardURL)/api/battles/challenge/status?challenger=\(safeChallenger)&opponent=\(safeOpponent)&token=\(safeToken)") else {
            appendColored("❌ Failed to check challenge status\n\n", color: cRed)
            battleActive = false
            pendingBattlePollToken = nil
            resetDuelContext()
            setState(.error)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard self.battleActive, self.pendingBattlePollToken == pollToken else { return }

                if let error = error {
                    self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                    self.setState(.error)
                    return
                }

                if let http = response as? HTTPURLResponse, http.statusCode == 404 {
                    self.appendColored("⚠️  Challenge status API missing, starting direct battle.\n\n", color: self.cYellow)
                    self.pendingBattlePollToken = nil
                    self.fetchOpponentAndRunBattle(opponent: opponent)
                    return
                }

                let status: String
                let jsonPayload: [String: Any]?
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    status = (json["status"] as? String ?? "pending").lowercased()
                    jsonPayload = json
                } else {
                    status = "pending"
                    jsonPayload = nil
                }

                switch status {
                case "accepted":
                    self.pendingBattlePollToken = nil
                    self.appendColored("✅ Challenge accepted by \(opponent)!\n\n", color: self.cGreen, bold: true)
                    if let jsonPayload = jsonPayload, self.runResolvedBattle(from: jsonPayload, publishResult: false) {
                        return
                    }
                    self.fetchOpponentAndRunBattle(opponent: opponent)
                case "declined":
                    self.appendColored("❌ \(opponent) declined your challenge.\n\n", color: self.cRed)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                    self.setState(.error)
                case "expired":
                    self.appendColored("⌛ Challenge to \(opponent) expired.\n\n", color: self.cDimGray)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                    self.setState(.idle)
                default:
                    if attemptsLeft == 30 || attemptsLeft % 5 == 0 {
                        self.appendColored("  Waiting for \(opponent) to accept...\n", color: self.cDimGray)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.pollBattleChallengeStatus(opponent: opponent, pollToken: pollToken, attemptsLeft: attemptsLeft - 1)
                    }
                }
            }
        }.resume()
    }

    func respondToBattleChallenge(challenger: String, accept: Bool) {
        if playerUsername.isEmpty {
            appendColored("❌ Set your name first: /name YourName\n\n", color: cRed)
            return
        }
        let cleanChallenger = challenger.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanChallenger.isEmpty else {
            appendColored("❌ Usage: /\(accept ? "accept" : "decline") <username>\n\n", color: cRed)
            return
        }

        guard let url = URL(string: "\(AgentODelegate.leaderboardURL)/api/battles/challenge/respond") else {
            appendColored("❌ Failed to create response request\n\n", color: cRed)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let payload: [String: Any] = [
            "challenger": cleanChallenger,
            "opponent": playerUsername,
            "accepted": accept,
            "token": playerAuthToken
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let error = error {
                    self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                    return
                }

                if let http = response as? HTTPURLResponse, http.statusCode == 404 {
                    self.appendColored("⚠️  Challenge API not deployed on server yet.\n\n", color: self.cYellow)
                    return
                }

                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    self.appendColored("❌ Invalid response from server\n\n", color: self.cRed)
                    return
                }

                let status = (json["status"] as? String ?? "unknown").lowercased()
                switch status {
                case "accepted":
                    self.appendColored("✅ Challenge from \(cleanChallenger) accepted!\n", color: self.cGreen, bold: true)
                    self.appendColored("  Battle room opened. Pick your move with /move <attack> <defense>.\n\n", color: self.cGray)
                    self.bubbleLabel.stringValue = speechBubble("Challenge accepted!")
                    self.battleActive = true
                    if !self.runResolvedBattle(from: json, publishResult: false) {
                        self.fetchOpponentAndRunBattle(opponent: cleanChallenger)
                    }
                case "declined":
                    self.appendColored("❌ Challenge from \(cleanChallenger) declined.\n\n", color: self.cYellow)
                    self.bubbleLabel.stringValue = speechBubble("Challenge declined.")
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                case "not_found", "expired":
                    self.appendColored("⚠️  No active challenge from \(cleanChallenger).\n\n", color: self.cDimGray)
                    self.battleActive = false
                    self.pendingBattlePollToken = nil
                    self.resetDuelContext()
                default:
                    self.appendColored("⚠️  Unexpected status: \(status)\n\n", color: self.cDimGray)
                }
            }
        }.resume()
    }

    func submitBattleMove(args: String) {
        guard var duel = activeDuel else {
            appendColored("❌ No active duel. Start with /battle <username> first.\n\n", color: cRed)
            return
        }
        if duel.moveSubmitted {
            appendColored("⌛ Your move is already locked. Waiting for opponent...\n\n", color: cDimGray)
            return
        }

        let parts = args
            .split(whereSeparator: { $0.isWhitespace || $0.isNewline })
            .map { String($0) }
        guard parts.count == 2,
              let attack = normalizedBattleZone(parts[0]),
              let defense = normalizedBattleZone(parts[1]) else {
            appendColored("❌ Usage: /move <attack> <defense>\n", color: cRed)
            appendColored("  Zones: head | body | legs\n", color: cGray)
            appendColored("  Example: /move head body\n\n", color: cDimGray)
            return
        }

        guard let url = URL(string: "\(AgentODelegate.leaderboardURL)/api/battles/challenge/move") else {
            appendColored("❌ Failed to create move request\n\n", color: cRed)
            return
        }

        appendColored("🎯 Move sent: attack \(zoneLabel(attack)), defend \(zoneLabel(defense))\n", color: cYellow, bold: true)
        appendColored("  Waiting for opponent move...\n\n", color: cDimGray)

        duel.moveSubmitted = true
        activeDuel = duel

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let payload: [String: Any] = [
            "challenger": duel.challenger,
            "opponent": duel.opponent,
            "player": playerUsername,
            "token": playerAuthToken,
            "attack": attack,
            "defense": defense
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let error = error {
                    self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                    return
                }
                if let http = response as? HTTPURLResponse, http.statusCode >= 400 {
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let serverError = json["error"] as? String {
                        self.appendColored("❌ \(serverError)\n\n", color: self.cRed)
                    } else {
                        self.appendColored("❌ Move request failed\n\n", color: self.cRed)
                    }
                    return
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    self.appendColored("❌ Invalid response from battle server\n\n", color: self.cRed)
                    return
                }
                _ = self.runResolvedBattle(from: json, publishResult: false)
            }
        }.resume()
    }

    func listPendingBattleChallenges() {
        checkIncomingBattleChallenges(silent: false)
    }

    func checkIncomingBattleChallenges(silent: Bool) {
        if playerUsername.isEmpty || playerAuthToken.isEmpty {
            if !silent {
                appendColored("❌ Set /name and publish once via /leaderboard first\n\n", color: cRed)
            }
            return
        }
        if battleActive && silent { return }

        let safeUser = playerUsername.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? playerUsername
        let safeToken = playerAuthToken.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? playerAuthToken
        guard let url = URL(string: "\(AgentODelegate.leaderboardURL)/api/battles/challenge/inbox?username=\(safeUser)&token=\(safeToken)") else {
            if !silent {
                appendColored("❌ Failed to create inbox request\n\n", color: cRed)
            }
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let error = error {
                    if !silent {
                        self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                    }
                    return
                }
                if let http = response as? HTTPURLResponse, http.statusCode == 404 {
                    if !silent {
                        self.appendColored("⚠️  Challenge API not deployed on server yet.\n\n", color: self.cYellow)
                    }
                    return
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    if !silent {
                        self.appendColored("❌ Invalid response from server\n\n", color: self.cRed)
                    }
                    return
                }

                let challenges = json["challenges"] as? [[String: Any]] ?? []
                var currentKeys: Set<String> = []
                for item in challenges {
                    let challenger = item["challenger"] as? String ?? "?"
                    let createdAt = item["createdAt"] as? String ?? ""
                    let key = "\(challenger)|\(createdAt)"
                    currentKeys.insert(key)
                }
                self.knownIncomingChallengeKeys = self.knownIncomingChallengeKeys.intersection(currentKeys)

                if challenges.isEmpty {
                    if !silent {
                        self.appendColored("📭 No pending battle challenges.\n\n", color: self.cDimGray)
                    }
                    return
                }

                if silent {
                    var hasNew = false
                    for item in challenges {
                        let challenger = item["challenger"] as? String ?? "?"
                        let createdAt = item["createdAt"] as? String ?? ""
                        let key = "\(challenger)|\(createdAt)"
                        if !self.knownIncomingChallengeKeys.contains(key) {
                            hasNew = true
                            self.knownIncomingChallengeKeys.insert(key)
                            self.appendColored("⚔️  Incoming challenge from \(challenger)!\n", color: self.cYellow, bold: true)
                            self.appendColored("  /accept \(challenger)  |  /decline \(challenger)\n\n", color: self.cGray)
                        }
                    }
                    if hasNew {
                        self.bubbleLabel.stringValue = speechBubble("New battle challenge!")
                        self.playSound("Pop")
                    }
                    return
                }

                self.appendColored("📨 Pending challenges:\n", color: self.cCyan, bold: true)
                for item in challenges.prefix(10) {
                    let challenger = item["challenger"] as? String ?? "?"
                    let createdAt = item["createdAt"] as? String ?? ""
                    self.appendColored("  • \(challenger)", color: self.cYellow, bold: true)
                    if !createdAt.isEmpty {
                        self.appendColored("  (\(createdAt))", color: self.cDimGray)
                    }
                    self.appendOutput("\n")
                    self.appendColored("    /accept \(challenger)  |  /decline \(challenger)\n", color: self.cGray)
                }
                self.appendOutput("\n")
            }
        }.resume()
    }

    func intFromAny(_ value: Any?, default defaultValue: Int = 0) -> Int {
        if let v = value as? Int { return v }
        if let v = value as? Double { return Int(v) }
        if let v = value as? String, let n = Int(v) { return n }
        return defaultValue
    }

    @discardableResult
    func runResolvedBattle(from responseJson: [String: Any], publishResult: Bool) -> Bool {
        guard let battle = responseJson["battle"] as? [String: Any],
              let challenger = battle["challenger"] as? [String: Any],
              let opponent = battle["opponent"] as? [String: Any] else {
            return false
        }

        let challengerName = challenger["username"] as? String ?? "?"
        let opponentName = opponent["username"] as? String ?? "?"
        let iAmChallenger = playerUsername.lowercased() == challengerName.lowercased()
        let iAmOpponent = playerUsername.lowercased() == opponentName.lowercased()
        guard iAmChallenger || iAmOpponent else { return false }

        let mySide = iAmChallenger ? challenger : opponent
        let oppSide = iAmChallenger ? opponent : challenger
        let oppName = oppSide["username"] as? String ?? "?"
        let battleId = battle["id"] as? String ?? "\(challengerName)|\(opponentName)"
        let battleStatus = (battle["status"] as? String ?? "").lowercased()
        let challengerMove = battle["challengerMove"] as? [String: Any]
        let opponentMove = battle["opponentMove"] as? [String: Any]
        let myMove = iAmChallenger ? challengerMove : opponentMove
        let oppMove = iAmChallenger ? opponentMove : challengerMove

        if battleStatus == "pick_phase" || (battleStatus.isEmpty && (challengerMove != nil || opponentMove != nil) && battle["winner"] == nil) {
            battleActive = true
            pendingBattlePollToken = nil
            setState(.thinking)
            bubbleLabel.stringValue = speechBubble("Duel vs \(oppName)")

            let mySubmitted = myMove != nil
            let previousBattleId = activeDuel?.battleId ?? ""
            activeDuel = BattleDuelContext(
                challenger: challengerName,
                opponent: opponentName,
                battleId: battleId,
                moveSubmitted: mySubmitted
            )

            let signature = duelStatusSignature(battle: battle)
            if signature != duelLastStatusSignature {
                if duelLastStatusSignature.isEmpty || previousBattleId != battleId {
                    appendColored("\n", color: cGray)
                    appendColored("  ╔══════════════════════════════════════╗\n", color: cCyan)
                    appendColored("  ║     ⚔️  TACTICAL DUEL STARTED ⚔️      ║\n", color: cCyan)
                    appendColored("  ╚══════════════════════════════════════╝\n\n", color: cCyan)
                    appendColored("  \(playerUsername)", color: cGreen, bold: true)
                    appendColored("  vs  ", color: cGray)
                    appendColored("\(oppName)\n\n", color: cRed, bold: true)
                }

                let oppSubmitted = oppMove != nil
                appendColored("  Your move: ", color: cGray)
                appendColored(mySubmitted ? "locked\n" : "pending\n", color: mySubmitted ? cGreen : cYellow, bold: true)
                appendColored("  Opponent:  ", color: cGray)
                appendColored(oppSubmitted ? "locked\n" : "waiting\n", color: oppSubmitted ? cGreen : cDimGray, bold: true)

                if let myMove = myMove {
                    let myAttack = zoneLabel(myMove["attack"] as? String ?? "-")
                    let myDefense = zoneLabel(myMove["defense"] as? String ?? "-")
                    appendColored("  Your pick: A/\(myAttack) D/\(myDefense)\n", color: cCyan)
                }
                appendOutput("\n")

                if !mySubmitted {
                    renderMoveHelp(opponent: oppName, alreadySubmitted: false)
                } else {
                    renderMoveHelp(opponent: oppName, alreadySubmitted: true)
                }
                duelLastStatusSignature = signature
            }

            beginDuelPolling(challenger: challengerName, opponent: opponentName)
            return true
        }

        if battleStatus == "resolved" || (battle["winner"] != nil && challengerMove != nil && opponentMove != nil) {
            duelStatusTimer?.invalidate()
            duelStatusTimer = nil
            battleActive = true

            let winner = (battle["winner"] as? String ?? "draw")
            let resolutionNote = battle["resolutionNote"] as? String ?? ""
            let challengerScore = intFromAny(battle["challengerScore"], default: intFromAny(challenger["power"], default: 0))
            let opponentScore = intFromAny(battle["opponentScore"], default: intFromAny(opponent["power"], default: 0))
            let myScore = iAmChallenger ? challengerScore : opponentScore
            let oppScore = iAmChallenger ? opponentScore : challengerScore
            let oppLevel = intFromAny(oppSide["level"], default: 1)

            appendColored("\n", color: cGray)
            appendColored("  ╔══════════════════════════════════════╗\n", color: cCyan)
            appendColored("  ║        ⚔️  DUEL RESOLUTION ⚔️        ║\n", color: cCyan)
            appendColored("  ╚══════════════════════════════════════╝\n\n", color: cCyan)

            appendColored("  \(playerUsername)", color: cGreen, bold: true)
            appendColored("  vs  ", color: cGray)
            appendColored("\(oppName)\n\n", color: cRed, bold: true)

            let myAttack = zoneLabel((myMove?["attack"] as? String) ?? "-")
            let myDefense = zoneLabel((myMove?["defense"] as? String) ?? "-")
            let oppAttack = zoneLabel((oppMove?["attack"] as? String) ?? "-")
            let oppDefense = zoneLabel((oppMove?["defense"] as? String) ?? "-")

            appendColored("  You:      A/\(myAttack) D/\(myDefense)\n", color: cGreen)
            appendColored("  Opponent: A/\(oppAttack) D/\(oppDefense)\n", color: cRed)
            appendColored("  Score: ", color: cGray)
            appendColored("\(myScore)", color: cGreen, bold: true)
            appendColored(" : ", color: cGray)
            appendColored("\(oppScore)\n", color: cRed, bold: true)
            if !resolutionNote.isEmpty {
                appendColored("  Note: \(resolutionNote)\n", color: cDimGray)
            }
            appendOutput("\n")

            finishBattleFromServer(
                winner: winner,
                myScore: myScore,
                oppScore: oppScore,
                oppName: oppName,
                oppLevel: oppLevel
            )
            return true
        }

        let myLevel = intFromAny(mySide["level"], default: pet.level)
        let myHunger = intFromAny(mySide["hunger"], default: pet.hunger)
        let myHappiness = intFromAny(mySide["happiness"], default: pet.happiness)
        let myEnergy = intFromAny(mySide["energy"], default: pet.energy)
        let myStreak = intFromAny(mySide["streak"], default: pet.streak)
        let myAch = intFromAny(mySide["achievements"], default: pet.unlockedAchievements.count)
        let myPower = intFromAny(mySide["power"], default: 0)

        let oppLevel = intFromAny(oppSide["level"], default: 1)
        let oppHunger = intFromAny(oppSide["hunger"], default: 50)
        let oppHappiness = intFromAny(oppSide["happiness"], default: 50)
        let oppEnergy = intFromAny(oppSide["energy"], default: 50)
        let oppStreak = intFromAny(oppSide["streak"], default: 0)
        let oppAch = intFromAny(oppSide["achievements"], default: 0)
        let oppPower = intFromAny(oppSide["power"], default: 0)

        battleActive = true
        setState(.dancing)
        bubbleLabel.stringValue = speechBubble("Battle started!")

        appendColored("\n", color: cGray)
        appendColored("  ╔══════════════════════════════════════╗\n", color: cCyan)
        appendColored("  ║         ⚔️  PET BATTLE ⚔️            ║\n", color: cCyan)
        appendColored("  ╚══════════════════════════════════════╝\n\n", color: cCyan)

        appendColored("  \(playerUsername)", color: cGreen, bold: true)
        appendColored("  vs  ", color: cGray)
        appendColored("\(oppName)\n\n", color: cRed, bold: true)

        let rounds: [(String, Int, Int)] = [
            ("Level", myLevel, oppLevel),
            ("Food", myHunger, oppHunger),
            ("Joy", myHappiness, oppHappiness),
            ("Energy", myEnergy, oppEnergy),
            ("Streak", myStreak, oppStreak),
            ("Badges", myAch, oppAch),
        ]

        var step = 0
        func showRound() {
            guard step < rounds.count else {
                self.finishBattle(
                    myPower: Double(myPower),
                    oppPower: Double(oppPower),
                    oppName: oppName,
                    oppLevel: oppLevel,
                    publishResult: publishResult
                )
                return
            }
            let (name, myVal, oppVal) = rounds[step]
            let winner = myVal > oppVal ? ">" : (myVal < oppVal ? "<" : "=")
            let myColor = myVal >= oppVal ? self.cGreen : self.cRed
            let oppColor = oppVal >= myVal ? self.cGreen : self.cRed

            self.appendColored("  \(name.padding(toLength: 8, withPad: " ", startingAt: 0))", color: self.cGray)
            self.appendColored("\(String(myVal).padding(toLength: 5, withPad: " ", startingAt: 0))", color: myColor, bold: true)
            self.appendColored(" \(winner) ", color: self.cYellow, bold: true)
            self.appendColored("\(oppVal)\n", color: oppColor, bold: true)

            step += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showRound()
            }
        }

        showRound()
        return true
    }

    func fetchOpponentAndRunBattle(opponent: String) {
        resetDuelContext()
        guard let url = URL(string: "\(AgentODelegate.leaderboardURL)/api/player/\(opponent.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? opponent)") else {
            appendColored("❌ Invalid username\n\n", color: cRed)
            battleActive = false
            resetDuelContext()
            setState(.error)
            return
        }

        bubbleLabel.stringValue = speechBubble("Finding \(opponent)...")
        appendColored("⚔️  Preparing battle with \(opponent)...\n", color: cYellow, bold: true)

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let error = error {
                    self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                    self.battleActive = false
                    self.resetDuelContext()
                    self.setState(.error)
                    return
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let oppLevel = json["level"] as? Int else {
                    self.appendColored("❌ Player \"\(opponent)\" not found on leaderboard\n", color: self.cRed)
                    self.appendColored("  They need to /leaderboard first\n\n", color: self.cGray)
                    self.battleActive = false
                    self.resetDuelContext()
                    self.setState(.error)
                    return
                }

                let oppXP = json["xp"] as? Int ?? 0
                let oppStreak = json["streak"] as? Int ?? 0
                let oppAch = json["achievements"] as? Int ?? 0
                let oppHunger = json["hunger"] as? Int ?? 50
                let oppHappiness = json["happiness"] as? Int ?? 50
                let oppEnergy = json["energy"] as? Int ?? 50
                let oppEvo = json["evolution"] as? String ?? "Baby"
                let oppSkin = json["skin"] as? String ?? "Robot"

                self.runBattle(
                    oppName: opponent, oppLevel: oppLevel, oppXP: oppXP,
                    oppStreak: oppStreak, oppAch: oppAch,
                    oppHunger: oppHunger, oppHappiness: oppHappiness,
                    oppEnergy: oppEnergy, oppEvo: oppEvo, oppSkin: oppSkin
                )
            }
        }
        task.resume()
    }

    func runBattle(oppName: String, oppLevel: Int, oppXP: Int,
                   oppStreak: Int, oppAch: Int,
                   oppHunger: Int, oppHappiness: Int,
                   oppEnergy: Int, oppEvo: String, oppSkin: String) {

        let myPower = calculatePower(
            level: pet.level, hunger: pet.hunger, happiness: pet.happiness,
            energy: pet.energy, streak: pet.streak, achievements: pet.unlockedAchievements.count
        )
        let oppPower = calculatePower(
            level: oppLevel, hunger: oppHunger, happiness: oppHappiness,
            energy: oppEnergy, streak: oppStreak, achievements: oppAch
        )

        // Battle header
        appendColored("\n", color: cGray)
        appendColored("  ╔══════════════════════════════════════╗\n", color: cCyan)
        appendColored("  ║         ⚔️  PET BATTLE ⚔️            ║\n", color: cCyan)
        appendColored("  ╚══════════════════════════════════════╝\n\n", color: cCyan)

        appendColored("  \(playerUsername)", color: cGreen, bold: true)
        appendColored("  vs  ", color: cGray)
        appendColored("\(oppName)\n\n", color: cRed, bold: true)

        // Stats comparison
        let rounds: [(String, Int, Int)] = [
            ("Level", pet.level, oppLevel),
            ("Food", pet.hunger, oppHunger),
            ("Joy", pet.happiness, oppHappiness),
            ("Energy", pet.energy, oppEnergy),
            ("Streak", pet.streak, oppStreak),
            ("Badges", pet.unlockedAchievements.count, oppAch),
        ]

        setState(.dancing)
        var step = 0

        func showRound() {
            guard step < rounds.count else {
                // All rounds shown, determine winner
                self.finishBattle(myPower: myPower, oppPower: oppPower, oppName: oppName, oppLevel: oppLevel, publishResult: true)
                return
            }
            let (name, myVal, oppVal) = rounds[step]
            let winner = myVal > oppVal ? ">" : (myVal < oppVal ? "<" : "=")
            let myColor = myVal >= oppVal ? self.cGreen : self.cRed
            let oppColor = oppVal >= myVal ? self.cGreen : self.cRed

            self.appendColored("  \(name.padding(toLength: 8, withPad: " ", startingAt: 0))", color: self.cGray)
            self.appendColored("\(String(myVal).padding(toLength: 5, withPad: " ", startingAt: 0))", color: myColor, bold: true)
            self.appendColored(" \(winner) ", color: self.cYellow, bold: true)
            self.appendColored("\(oppVal)\n", color: oppColor, bold: true)

            step += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showRound()
            }
        }

        showRound()
    }

    func calculatePower(level: Int, hunger: Int, happiness: Int,
                        energy: Int, streak: Int, achievements: Int) -> Double {
        let stats = Double(hunger + happiness + energy) / 3.0
        let base = Double(level) * 100.0 + stats * 2.0
        let streakBonus = Double(streak) * 15.0
        let achBonus = Double(achievements) * 20.0
        // Add some randomness (+-15%)
        let luck = Double.random(in: 0.85...1.15)
        return (base + streakBonus + achBonus) * luck
    }

    func finishBattleFromServer(winner: String, myScore: Int, oppScore: Int, oppName: String, oppLevel: Int) {
        _ = oppLevel
        let normalizedWinner = winner.lowercased()
        let myName = playerUsername.lowercased()

        appendColored("\n  ──────────────────────────────────────\n", color: cGray)

        let result: String
        if normalizedWinner == myName {
            let xpGain = 45 + max(0, myScore - oppScore)
            appendColored("  🏆 YOU WIN! ", color: cGreen, bold: true)
            appendColored("+\(xpGain) XP\n\n", color: cYellow, bold: true)
            pet.gainXP(xpGain)
            pet.happiness = min(100, pet.happiness + 10)
            pet.battlesWon += 1
            result = "win"
            setState(.happy)
            bubbleLabel.stringValue = speechBubble("Tactical win vs \(oppName)!")
            playSound("Glass")
            updateDailyQuest("battle_win", by: 1)
        } else if normalizedWinner == "draw" {
            let xpGain = 30
            appendColored("  🤝 DRAW! ", color: cYellow, bold: true)
            appendColored("+\(xpGain) XP\n\n", color: cYellow)
            pet.gainXP(xpGain)
            result = "draw"
            setState(.idle)
            bubbleLabel.stringValue = speechBubble("Close duel!")
        } else {
            let xpGain = 15
            appendColored("  💀 YOU LOSE! ", color: cRed, bold: true)
            appendColored("+\(xpGain) XP (consolation)\n\n", color: cGray)
            pet.gainXP(xpGain)
            pet.energy = max(0, pet.energy - 10)
            pet.battlesLost += 1
            result = "loss"
            setState(.error)
            bubbleLabel.stringValue = speechBubble("\(oppName) outplayed us...")
        }

        let entry: [String: Any] = [
            "opponent": oppName,
            "result": result,
            "myPower": myScore,
            "oppPower": oppScore,
            "mode": "duel",
            "date": ISO8601DateFormatter().string(from: Date())
        ]
        pet.battleHistory.insert(entry, at: 0)
        if pet.battleHistory.count > 20 { pet.battleHistory = Array(pet.battleHistory.prefix(20)) }
        pet.save()
        refreshStatsDisplay()

        appendColored("  Battle another: /battle <username>\n\n", color: cGray)
        battleActive = false
        pendingBattlePollToken = nil
        resetDuelContext()
        processAchievements()
    }

    func finishBattle(myPower: Double, oppPower: Double, oppName: String, oppLevel: Int, publishResult: Bool = true) {
        appendColored("\n  ──────────────────────────────────────\n", color: cGray)

        let myPwr = Int(myPower)
        let oppPwr = Int(oppPower)

        appendColored("  Power: ", color: cGray)
        appendColored("\(myPwr)", color: cGreen, bold: true)
        appendColored(" vs ", color: cGray)
        appendColored("\(oppPwr)\n\n", color: cRed, bold: true)

        let result: String
        if myPower > oppPower {
            let xpGain = 50 + Int(Double(abs(myPwr - oppPwr)) * 0.1)
            appendColored("  🏆 YOU WIN! ", color: cGreen, bold: true)
            appendColored("+\(xpGain) XP\n\n", color: cYellow, bold: true)
            pet.gainXP(xpGain)
            pet.happiness = min(100, pet.happiness + 10)
            pet.battlesWon += 1
            result = "win"
            setState(.happy)
            bubbleLabel.stringValue = speechBubble("I beat \(oppName)!")
            playSound("Glass")
            updateDailyQuest("battle_win", by: 1)
        } else if oppPower > myPower {
            let xpGain = 15
            appendColored("  💀 YOU LOSE! ", color: cRed, bold: true)
            appendColored("+\(xpGain) XP (consolation)\n\n", color: cGray)
            pet.gainXP(xpGain)
            pet.energy = max(0, pet.energy - 10)
            pet.battlesLost += 1
            result = "loss"
            setState(.error)
            bubbleLabel.stringValue = speechBubble("\(oppName) was tough...")
        } else {
            let xpGain = 30
            appendColored("  🤝 DRAW! ", color: cYellow, bold: true)
            appendColored("+\(xpGain) XP\n\n", color: cYellow)
            pet.gainXP(xpGain)
            result = "draw"
            setState(.idle)
            bubbleLabel.stringValue = speechBubble("Evenly matched!")
        }

        // Record battle history
        let entry: [String: Any] = [
            "opponent": oppName,
            "result": result,
            "myPower": myPwr,
            "oppPower": oppPwr,
            "date": ISO8601DateFormatter().string(from: Date())
        ]
        pet.battleHistory.insert(entry, at: 0)
        if pet.battleHistory.count > 20 { pet.battleHistory = Array(pet.battleHistory.prefix(20)) }
        pet.save()
        refreshStatsDisplay()
        if publishResult {
            publishBattleResult(opponent: oppName, opponentLevel: oppLevel, result: result, myPower: myPwr, oppPower: oppPwr)
        }

        appendColored("  Battle another: /battle <username>\n\n", color: cGray)
        battleActive = false
        pendingBattlePollToken = nil
        resetDuelContext()
        processAchievements()
    }

    func publishBattleResult(opponent: String, opponentLevel: Int, result: String, myPower: Int, oppPower: Int) {
        guard !playerUsername.isEmpty else { return }
        guard let url = URL(string: "\(AgentODelegate.leaderboardURL)/api/battles/log") else { return }

        let winner: String
        if result == "win" { winner = playerUsername }
        else if result == "loss" { winner = opponent }
        else { winner = "draw" }

        let payload: [String: Any] = [
            "playerA": playerUsername,
            "playerB": opponent,
            "token": playerAuthToken,
            "winner": winner,
            "result": result,
            "playerALevel": pet.level,
            "playerBLevel": opponentLevel,
            "playerAPower": myPower,
            "playerBPower": oppPower,
            "createdAt": ISO8601DateFormatter().string(from: Date())
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { _, _, _ in }.resume()
    }

    func showBattleHistory() {
        if pet.battleHistory.isEmpty {
            appendColored("No battles yet. Try /battle <username>\n\n", color: cGray)
            return
        }
        appendColored("╭── Battle History ───────────────────╮\n", color: cPurple)
        appendColored("  W:\(pet.battlesWon) / L:\(pet.battlesLost) / Total:\(pet.battlesWon + pet.battlesLost)\n\n", color: cCyan, bold: true)
        for (_, b) in pet.battleHistory.prefix(10).enumerated() {
            let opp = b["opponent"] as? String ?? "?"
            let res = b["result"] as? String ?? "?"
            let myP = b["myPower"] as? Int ?? 0
            let opP = b["oppPower"] as? Int ?? 0
            let mode = b["mode"] as? String ?? "power"
            let icon = res == "win" ? "🏆" : (res == "loss" ? "💀" : "🤝")
            let color = res == "win" ? cGreen : (res == "loss" ? cRed : cYellow)
            appendColored("  \(icon) ", color: color)
            appendColored("vs \(opp.padding(toLength: 14, withPad: " ", startingAt: 0))", color: cGray)
            appendColored("\(myP) vs \(opP)", color: color)
            if mode == "duel" {
                appendColored("  [duel]", color: cCyan)
            }
            appendOutput("\n")
        }
        appendColored("╰────────────────────────────────────╯\n\n", color: cPurple)
    }

    // MARK: - Daily Quests

    struct DailyQuest {
        let id: String
        let desc: String
        let target: Int
        let xp: Int
    }

    static let questPool: [DailyQuest] = [
        DailyQuest(id: "cmd_3", desc: "Run 3 commands", target: 3, xp: 30),
        DailyQuest(id: "cmd_10", desc: "Run 10 commands", target: 10, xp: 60),
        DailyQuest(id: "feed_pet", desc: "Feed your pet", target: 1, xp: 20),
        DailyQuest(id: "play_pet", desc: "Play with your pet", target: 1, xp: 20),
        DailyQuest(id: "battle_win", desc: "Win a battle", target: 1, xp: 50),
        DailyQuest(id: "commit_1", desc: "Make a commit", target: 1, xp: 40),
        DailyQuest(id: "translate_1", desc: "Translate something", target: 1, xp: 25),
        DailyQuest(id: "game_play", desc: "Play a mini-game", target: 1, xp: 25),
        DailyQuest(id: "rest_pet", desc: "Let your pet rest", target: 1, xp: 20),
    ]

    func getTodayQuests() -> [DailyQuest] {
        let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        if pet.dailyQuestsDate != today {
            // New day — pick 3 random quests
            pet.dailyQuestsDate = today
            pet.dailyQuestsProgress = [:]
            pet.dailyQuestsCompleted = []
            let shuffled = AgentODelegate.questPool.shuffled()
            let picked = Array(shuffled.prefix(3))
            // Store which quests were picked
            pet.dailyQuestsProgress = Dictionary(uniqueKeysWithValues: picked.map { ($0.id, 0) })
            pet.save()
        }
        return AgentODelegate.questPool.filter { pet.dailyQuestsProgress.keys.contains($0.id) }
    }

    func updateDailyQuest(_ questId: String, by amount: Int) {
        let quests = getTodayQuests()
        guard pet.dailyQuestsProgress.keys.contains(questId),
              !pet.dailyQuestsCompleted.contains(questId) else { return }
        pet.dailyQuestsProgress[questId] = (pet.dailyQuestsProgress[questId] ?? 0) + amount
        if let quest = quests.first(where: { $0.id == questId }),
           (pet.dailyQuestsProgress[questId] ?? 0) >= quest.target {
            pet.dailyQuestsCompleted.append(questId)
            pet.gainXP(quest.xp)
            pet.save()
            appendColored("\n✅ Quest complete: \(quest.desc) (+\(quest.xp) XP)\n\n", color: cGreen, bold: true)
            playSound("Hero")
            refreshStatsDisplay()
            // Check if all 3 done
            if pet.dailyQuestsCompleted.count >= 3 {
                pet.gainXP(50)
                pet.save()
                appendColored("🌟 ALL DAILY QUESTS COMPLETE! +50 bonus XP\n\n", color: cYellow, bold: true)
                playSound("Glass")
            }
        } else {
            pet.save()
        }
    }

    func showDailyQuests() {
        let quests = getTodayQuests()
        appendColored("╭── Daily Quests ─────────────────────╮\n", color: cYellow)
        let done = pet.dailyQuestsCompleted.count
        appendColored("  \(done)/3 completed", color: cCyan, bold: true)
        if done >= 3 {
            appendColored("  ✅ All done!\n\n", color: cGreen, bold: true)
        } else {
            appendColored("\n\n", color: cGray)
        }
        for q in quests {
            let progress = pet.dailyQuestsProgress[q.id] ?? 0
            let completed = pet.dailyQuestsCompleted.contains(q.id)
            let icon = completed ? "✅" : "⬜"
            let color = completed ? cGreen : cGray
            appendColored("  \(icon) \(q.desc.padding(toLength: 22, withPad: " ", startingAt: 0))", color: color)
            if completed {
                appendColored("+\(q.xp) XP\n", color: cGreen)
            } else {
                appendColored("\(progress)/\(q.target)\n", color: cDimGray)
            }
        }
        appendColored("╰────────────────────────────────────╯\n\n", color: cYellow)
    }

    // MARK: - Inventory

    static let allItems: [(id: String, name: String, icon: String, desc: String)] = [
        ("hat_crown", "Crown", "👑", "Reach level 10"),
        ("hat_halo", "Halo", "😇", "Complete 30-day streak"),
        ("hat_party", "Party Hat", "🎉", "Reach level 5"),
        ("hat_tophat", "Top Hat", "🎩", "Win 5 battles"),
        ("frame_gold", "Gold Frame", "🖼", "Unlock 10 achievements"),
        ("frame_diamond", "Diamond Frame", "💎", "Reach level 20"),
        ("bg_stars", "Starfield BG", "✨", "Run 100 commands"),
        ("bg_fire", "Fire BG", "🔥", "7-day streak"),
        ("badge_og", "OG Badge", "🏅", "Early adopter"),
        ("pet_wings", "Wings", "🪽", "Win 10 battles"),
    ]

    func checkInventoryUnlocks() {
        let checks: [(String, Bool)] = [
            ("hat_party", pet.level >= 5),
            ("hat_crown", pet.level >= 10),
            ("frame_diamond", pet.level >= 20),
            ("hat_halo", pet.streak >= 30),
            ("hat_tophat", pet.battlesWon >= 5),
            ("frame_gold", pet.unlockedAchievements.count >= 10),
            ("bg_stars", pet.totalCommands >= 100),
            ("bg_fire", pet.streak >= 7),
            ("badge_og", pet.totalCommands >= 1),
            ("pet_wings", pet.battlesWon >= 10),
        ]
        for (id, cond) in checks {
            if cond && !pet.inventory.contains(id) {
                pet.inventory.append(id)
                if let item = AgentODelegate.allItems.first(where: { $0.id == id }) {
                    appendColored("\n🎁 NEW ITEM: \(item.icon) \(item.name)\n", color: cPurple, bold: true)
                    appendColored("   \(item.desc)\n\n", color: cGray)
                    playSound("Hero")
                }
            }
        }
        pet.save()
    }

    func showInventory() {
        appendColored("╭── Inventory ────────────────────────╮\n", color: cPurple)
        appendColored("  \(pet.inventory.count)/\(AgentODelegate.allItems.count) items\n\n", color: cCyan, bold: true)
        for item in AgentODelegate.allItems {
            let owned = pet.inventory.contains(item.id)
            let icon = owned ? item.icon : "🔒"
            let color = owned ? cPurple : cDimGray
            appendColored("  \(icon) \(item.name.padding(toLength: 16, withPad: " ", startingAt: 0))", color: color, bold: owned)
            appendColored("\(item.desc)\n", color: owned ? cGray : cDimGray)
        }
        appendColored("╰────────────────────────────────────╯\n\n", color: cPurple)
    }

    // MARK: - Onboarding

    var onboardingStep = 0

    func startOnboarding() {
        onboardingStep = 1
        appendColored("\n", color: cGray)
        appendColored("  ╔══════════════════════════════════════╗\n", color: cCyan)
        appendColored("  ║     Welcome to Agent-O! 🤖           ║\n", color: cCyan)
        appendColored("  ║     Let's get you started            ║\n", color: cCyan)
        appendColored("  ╚══════════════════════════════════════╝\n\n", color: cCyan)
        appendColored("  Your pet is hungry! Let's feed it.\n", color: cGreen)
        appendColored("  Type: ", color: cGray)
        appendColored("/feed\n\n", color: cYellow, bold: true)
        bubbleLabel.stringValue = speechBubble("Hi! I'm hungry... Type /feed")
    }

    func handleOnboardingStep(_ cmd: String) -> Bool {
        switch onboardingStep {
        case 1:
            if cmd == "/feed" {
                onboardingStep = 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.appendColored("  Great! Now let's play together.\n", color: self.cGreen)
                    self.appendColored("  Type: ", color: self.cGray)
                    self.appendColored("/play\n\n", color: self.cYellow, bold: true)
                    self.bubbleLabel.stringValue = speechBubble("Yum! Now play with me!")
                }
                return false // let /feed execute normally
            }
        case 2:
            if cmd == "/play" {
                onboardingStep = 3
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.appendColored("  Awesome! Now try asking Claude a question.\n", color: self.cGreen)
                    self.appendColored("  Type anything, e.g.: ", color: self.cGray)
                    self.appendColored("what is swift?\n\n", color: self.cYellow, bold: true)
                    self.bubbleLabel.stringValue = speechBubble("Fun! Now ask me anything!")
                }
                return false
            }
        case 3:
            if !cmd.hasPrefix("/") {
                onboardingStep = 0
                pet.hasCompletedOnboarding = true
                pet.save()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.appendColored("\n  ✅ Onboarding complete! You're ready.\n", color: self.cGreen, bold: true)
                    self.appendColored("  Type /help to see all commands\n", color: self.cGray)
                    self.appendColored("  Type /quests to see daily quests\n\n", color: self.cGray)
                    self.bubbleLabel.stringValue = speechBubble("Let's go! 🚀")
                    self.playSound("Glass")
                }
                return false
            }
        default:
            break
        }
        return false
    }

    // MARK: - Typing Speed Game

    var typingGameActive = false
    var typingTarget = ""
    var typingStartTime: Date?

    static let typingPhrases = [
        "git commit -m fix bug",
        "let x = array.map { $0 * 2 }",
        "func hello() -> String",
        "import Foundation",
        "for i in 0..<count {",
        "guard let value = optional else { return }",
        "struct Point { var x: Int; var y: Int }",
        "print(Hello World)",
        "docker compose up -d",
        "npm install --save-dev",
        "SELECT * FROM users WHERE id = 1",
        "curl -X POST localhost:3000",
    ]

    func startTypingGame() {
        typingTarget = AgentODelegate.typingPhrases.randomElement()!
        typingGameActive = true
        typingStartTime = nil
        setState(.happy)
        appendColored("⌨️  TYPING SPEED TEST\n\n", color: cCyan, bold: true)
        appendColored("  Type this as fast as you can:\n\n", color: cGray)
        appendColored("  \(typingTarget)\n\n", color: cYellow, bold: true)
        appendColored("  (Start typing! Timer starts on first key)\n\n", color: cDimGray)
        bubbleLabel.stringValue = speechBubble("Ready... type!")
        typingStartTime = Date()
        updateDailyQuest("game_play", by: 1)
    }

    func handleTypingInput(_ input: String) {
        guard typingGameActive, let start = typingStartTime else { return }
        typingGameActive = false
        let elapsed = Date().timeIntervalSince(start)
        let words = Double(typingTarget.split(separator: " ").count)
        let wpm = Int((words / elapsed) * 60.0)
        let accuracy = calculateAccuracy(input: input, target: typingTarget)

        appendColored("⏱  Results:\n", color: cCyan, bold: true)
        appendColored("  Time: \(String(format: "%.1f", elapsed))s\n", color: cGray)
        appendColored("  Speed: \(wpm) WPM\n", color: wpm > 60 ? cGreen : (wpm > 30 ? cYellow : cRed), bold: true)
        appendColored("  Accuracy: \(accuracy)%\n\n", color: accuracy >= 90 ? cGreen : (accuracy >= 70 ? cYellow : cRed))

        let xpGain = max(10, min(50, wpm / 2)) * accuracy / 100
        pet.gainXP(xpGain)
        pet.save()
        appendColored("  +\(xpGain) XP\n\n", color: cYellow)
        refreshStatsDisplay()

        if wpm > 60 && accuracy >= 90 {
            bubbleLabel.stringValue = speechBubble("Speed demon! 🔥")
            playSound("Glass")
        } else {
            bubbleLabel.stringValue = speechBubble("\(wpm) WPM — keep practicing!")
        }
        setState(.idle)
    }

    func calculateAccuracy(input: String, target: String) -> Int {
        let inputChars = Array(input)
        let targetChars = Array(target)
        let maxLen = max(inputChars.count, targetChars.count)
        guard maxLen > 0 else { return 100 }
        var matches = 0
        for i in 0..<min(inputChars.count, targetChars.count) {
            if inputChars[i] == targetChars[i] { matches += 1 }
        }
        return Int(Double(matches) / Double(maxLen) * 100.0)
    }

    // MARK: - Auto-Update

    func checkForUpdate() {
        appendColored("🔄 Checking for updates...\n", color: cCyan)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Checking updates...")

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let urlString = "https://api.github.com/repos/egorfedorov/agentO/releases/latest"
            guard let url = URL(string: urlString) else { return }

            var request = URLRequest(url: url)
            request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                        self.setState(.error)
                        return
                    }
                    guard let data = data,
                          let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                          let tagName = json["tag_name"] as? String else {
                        self.appendColored("❌ Could not check version\n\n", color: self.cRed)
                        self.setState(.error)
                        return
                    }

                    let remoteVersion = tagName.hasPrefix("v") ? String(tagName.dropFirst()) : tagName

                    if remoteVersion == AgentODelegate.currentVersion {
                        self.appendColored("✅ Already up to date! v\(AgentODelegate.currentVersion)\n\n", color: self.cGreen, bold: true)
                        self.setState(.happy)
                        self.bubbleLabel.stringValue = speechBubble("Up to date!")
                        return
                    }

                    // New version available — find download URL
                    self.appendColored("🆕 New version: v\(remoteVersion) (current: v\(AgentODelegate.currentVersion))\n", color: self.cYellow, bold: true)

                    if let assets = json["assets"] as? [[String: Any]] {
                        let zipAsset = assets.first(where: { ($0["name"] as? String ?? "").hasSuffix(".zip") })
                        if let downloadURL = zipAsset?["browser_download_url"] as? String {
                            self.appendColored("⬇️  Downloading...\n", color: self.cCyan)
                            self.downloadAndInstallUpdate(from: downloadURL, version: remoteVersion)
                            return
                        }
                    }

                    // No zip asset — show manual update link
                    let body = json["html_url"] as? String ?? "https://github.com/egorfedorov/agentO/releases"
                    self.appendColored("📥 Download: \(body)\n\n", color: self.cCyan)
                    self.setState(.idle)
                }
            }
            task.resume()
        }
    }

    func downloadAndInstallUpdate(from urlString: String, version: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self,
                  let url = URL(string: urlString) else { return }

            let task = URLSession.shared.downloadTask(with: url) { tempURL, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.appendColored("❌ Download failed: \(error.localizedDescription)\n\n", color: self.cRed)
                        self.setState(.error)
                        return
                    }
                    guard let tempURL = tempURL else {
                        self.appendColored("❌ Download failed\n\n", color: self.cRed)
                        self.setState(.error)
                        return
                    }

                    // Find the current .app bundle path
                    let bundlePath = Bundle.main.bundlePath
                    let isAppBundle = bundlePath.hasSuffix(".app")

                    if isAppBundle {
                        // Running as .app — replace in place
                        self.installAppUpdate(from: tempURL, to: bundlePath, version: version)
                    } else {
                        // Running from CLI (./run.sh) — extract to Downloads
                        self.extractToDownloads(from: tempURL, version: version)
                    }
                }
            }
            task.resume()
        }
    }

    func installAppUpdate(from zipURL: URL, to appPath: String, version: String) {
        let fm = FileManager.default
        let tmpDir = NSTemporaryDirectory() + "agento-update-\(UUID().uuidString)"

        do {
            // Unzip
            let unzipProc = Process()
            unzipProc.executableURL = URL(fileURLWithPath: "/usr/bin/unzip")
            unzipProc.arguments = ["-o", zipURL.path, "-d", tmpDir]
            try unzipProc.run()
            unzipProc.waitUntilExit()

            // Find AgentO.app in extracted folder
            let extracted = try fm.contentsOfDirectory(atPath: tmpDir)
            guard let appName = extracted.first(where: { $0.hasSuffix(".app") }) else {
                appendColored("❌ No .app found in update\n\n", color: cRed)
                setState(.error)
                return
            }

            let newAppPath = tmpDir + "/" + appName
            let parentDir = (appPath as NSString).deletingLastPathComponent
            let backupPath = parentDir + "/AgentO-backup.app"

            // Backup current, move new
            try? fm.removeItem(atPath: backupPath)
            try fm.moveItem(atPath: appPath, toPath: backupPath)
            try fm.moveItem(atPath: newAppPath, toPath: appPath)

            // Remove quarantine
            let xattr = Process()
            xattr.executableURL = URL(fileURLWithPath: "/usr/bin/xattr")
            xattr.arguments = ["-cr", appPath]
            try xattr.run()
            xattr.waitUntilExit()

            appendColored("✅ Updated to v\(version)!\n", color: cGreen, bold: true)
            appendColored("🔄 Restarting...\n\n", color: cCyan)
            setState(.happy)
            bubbleLabel.stringValue = speechBubble("Updated! Restarting...")

            // Relaunch
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let proc = Process()
                proc.executableURL = URL(fileURLWithPath: "/usr/bin/open")
                proc.arguments = [appPath]
                try? proc.run()
                NSApp.terminate(nil)
            }
        } catch {
            appendColored("❌ Update failed: \(error.localizedDescription)\n\n", color: cRed)
            setState(.error)
        }
    }

    func extractToDownloads(from zipURL: URL, version: String) {
        let downloadsDir = NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .userDomainMask, true).first ?? "/tmp"
        let destDir = downloadsDir + "/AgentO-v\(version)"

        do {
            let proc = Process()
            proc.executableURL = URL(fileURLWithPath: "/usr/bin/unzip")
            proc.arguments = ["-o", zipURL.path, "-d", destDir]
            try proc.run()
            proc.waitUntilExit()

            // Remove quarantine
            let xattr = Process()
            xattr.executableURL = URL(fileURLWithPath: "/usr/bin/xattr")
            xattr.arguments = ["-cr", destDir]
            try xattr.run()
            xattr.waitUntilExit()

            appendColored("✅ Downloaded v\(version) to:\n", color: cGreen, bold: true)
            appendColored("  \(destDir)/AgentO.app\n", color: cCyan)
            appendColored("  Open it to use the new version\n\n", color: cGray)
            setState(.happy)
            bubbleLabel.stringValue = speechBubble("Updated! v\(version)")
        } catch {
            appendColored("❌ Extract failed: \(error.localizedDescription)\n\n", color: cRed)
            setState(.error)
        }
    }

    func checkForUpdateSilent() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let urlString = "https://api.github.com/repos/egorfedorov/agentO/releases/latest"
            guard let url = URL(string: urlString) else { return }

            var request = URLRequest(url: url)
            request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")

            let task = URLSession.shared.dataTask(with: request) { data, _, _ in
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let tagName = json["tag_name"] as? String else { return }

                let remoteVersion = tagName.hasPrefix("v") ? String(tagName.dropFirst()) : tagName
                guard remoteVersion != AgentODelegate.currentVersion else { return }

                DispatchQueue.main.async {
                    self.appendColored("🆕 Update available: v\(remoteVersion)! Type /update to install\n\n", color: self.cYellow, bold: true)
                    self.bubbleLabel.stringValue = speechBubble("Update available!")
                }
            }
            task.resume()
        }
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
