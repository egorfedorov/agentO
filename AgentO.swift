import AppKit
import Foundation
import Carbon.HIToolbox

final class InputTextField: NSTextField {
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        if event.type == .keyDown,
           flags == .command,
           event.charactersIgnoringModifiers?.lowercased() == "v",
           let text = NSPasteboard.general.string(forType: .string) {
            let normalized = text
                .replacingOccurrences(of: "\r\n", with: "\n")
                .replacingOccurrences(of: "\r", with: "\n")
                .replacingOccurrences(of: "\n", with: " ")
            if let editor = window?.fieldEditor(true, for: self) as? NSTextView {
                editor.insertText(normalized, replacementRange: editor.selectedRange())
            } else {
                stringValue += normalized
            }
            return true
        }
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

// MARK: - Pixel Art Sprites

struct PixelSprite {
    static let C: UInt32 = 0 // transparent

    // Color shortcuts
    static let BK: UInt32 = 0x1A1A2E  // outline dark
    static let OL: UInt32 = 0x222244  // outline

    // ========== ROBOT (Finn-style cute bot) ==========
    // Cyan/teal robot with antenna, white face panel, glowing eyes
    static let robotWalk1: [[UInt32]] = {
        let T = C, B: UInt32 = 0x1A1A2E, W: UInt32 = 0xFFFFFF, CY: UInt32 = 0x4ECDC4, CD: UInt32 = 0x3AA89F, SK: UInt32 = 0xE8D5B7, G: UInt32 = 0x56E39F
        return [
            [T,T,T,T,T,T,T,B,B,T,T,T,T,T,T,T],  // antenna
            [T,T,T,T,T,T,B,G,G,B,T,T,T,T,T,T],  // antenna tip
            [T,T,T,T,B,B,B,B,B,B,B,B,T,T,T,T],  // head top
            [T,T,T,B,W,W,W,W,W,W,W,W,B,T,T,T],
            [T,T,B,W,W,W,W,W,W,W,W,W,W,B,T,T],  // head
            [T,T,B,W,W,B,B,W,W,B,B,W,W,B,T,T],  // eyes
            [T,T,B,W,W,B,CY,W,W,B,CY,W,W,B,T,T],  // pupils
            [T,T,B,W,W,W,W,W,W,W,W,W,W,B,T,T],
            [T,T,T,B,W,W,B,B,B,W,W,B,T,T,T,T],  // mouth
            [T,T,T,T,B,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,B,CY,CY,CY,CY,CY,CY,CY,B,T,T,T,T],  // body
            [T,T,B,CY,CY,CY,CY,CY,CY,CY,CY,CY,B,T,T,T],
            [T,B,CD,B,CY,CY,CY,CY,CY,CY,CY,B,CD,B,T,T],  // arms
            [T,T,T,T,B,CY,CY,CY,CY,CY,B,T,T,T,T,T],
            [T,T,T,T,T,B,B,T,B,B,T,T,T,T,T,T],  // legs
            [T,T,T,T,B,B,T,T,T,B,B,T,T,T,T,T],  // feet
        ]
    }()
    static let robotWalk2: [[UInt32]] = {
        let T = C, B: UInt32 = 0x1A1A2E, W: UInt32 = 0xFFFFFF, CY: UInt32 = 0x4ECDC4, CD: UInt32 = 0x3AA89F, SK: UInt32 = 0xE8D5B7, G: UInt32 = 0x56E39F
        return [
            [T,T,T,T,T,T,T,B,B,T,T,T,T,T,T,T],
            [T,T,T,T,T,T,B,G,G,B,T,T,T,T,T,T],
            [T,T,T,T,B,B,B,B,B,B,B,B,T,T,T,T],
            [T,T,T,B,W,W,W,W,W,W,W,W,B,T,T,T],
            [T,T,B,W,W,W,W,W,W,W,W,W,W,B,T,T],
            [T,T,B,W,W,B,B,W,W,B,B,W,W,B,T,T],
            [T,T,B,W,W,CY,B,W,W,CY,B,W,W,B,T,T],  // eyes look other way
            [T,T,B,W,W,W,W,W,W,W,W,W,W,B,T,T],
            [T,T,T,B,W,W,W,B,B,W,W,B,T,T,T,T],
            [T,T,T,T,B,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,B,CY,CY,CY,CY,CY,CY,CY,B,T,T,T,T],
            [T,T,B,CY,CY,CY,CY,CY,CY,CY,CY,CY,B,T,T,T],
            [T,B,CD,B,CY,CY,CY,CY,CY,CY,CY,B,CD,B,T,T],
            [T,T,T,T,B,CY,CY,CY,CY,CY,B,T,T,T,T,T],
            [T,T,T,T,B,B,T,T,T,B,B,T,T,T,T,T],  // legs swapped
            [T,T,T,T,T,B,B,T,B,B,T,T,T,T,T,T],
        ]
    }()

    // ========== CAT (Shiba/Neko-style) ==========
    // Orange cat with pointy ears, white muzzle, pink nose, collar
    static let catWalk1: [[UInt32]] = {
        let T = C, B: UInt32 = 0x1A1A2E, O: UInt32 = 0xF0A040, OL: UInt32 = 0xD08830, W: UInt32 = 0xFFFFFF, P: UInt32 = 0xFF6B8A, R: UInt32 = 0xCC3355
        return [
            [T,T,T,B,B,T,T,T,T,T,T,B,B,T,T,T],  // ear tips
            [T,T,B,O,O,B,T,T,T,T,B,O,O,B,T,T],  // ears
            [T,B,O,OL,O,O,B,B,B,B,O,OL,O,O,B,T],  // ear inner + head
            [T,B,O,O,O,O,O,O,O,O,O,O,O,O,B,T],  // head
            [T,B,O,O,B,B,O,O,O,O,B,B,O,O,B,T],  // eyes outer
            [T,B,O,O,B,W,O,O,O,O,B,W,O,O,B,T],  // eyes
            [T,T,B,O,O,O,O,W,W,O,O,O,O,B,T,T],  // muzzle top
            [T,T,B,O,O,O,W,P,P,W,O,O,O,B,T,T],  // nose
            [T,T,T,B,O,O,O,W,W,O,O,O,B,T,T,T],  // mouth
            [T,T,T,T,B,B,R,R,R,R,B,B,T,T,T,T],  // collar
            [T,T,T,B,O,O,O,O,O,O,O,O,B,T,T,T],  // body
            [T,T,B,O,O,O,O,O,O,O,O,O,O,B,T,T],
            [T,T,B,O,O,O,O,O,O,O,O,O,O,B,T,T],
            [T,T,T,B,B,B,T,T,T,B,B,B,T,T,T,T],  // legs
            [T,T,T,B,O,B,T,T,T,B,O,B,T,T,T,T],  // paws
            [T,T,T,T,T,T,T,T,T,T,T,T,B,O,O,B],  // tail
        ]
    }()
    static let catWalk2: [[UInt32]] = {
        let T = C, B: UInt32 = 0x1A1A2E, O: UInt32 = 0xF0A040, OL: UInt32 = 0xD08830, W: UInt32 = 0xFFFFFF, P: UInt32 = 0xFF6B8A, R: UInt32 = 0xCC3355
        return [
            [T,T,T,B,B,T,T,T,T,T,T,B,B,T,T,T],
            [T,T,B,O,O,B,T,T,T,T,B,O,O,B,T,T],
            [T,B,O,OL,O,O,B,B,B,B,O,OL,O,O,B,T],
            [T,B,O,O,O,O,O,O,O,O,O,O,O,O,B,T],
            [T,B,O,O,B,B,O,O,O,O,B,B,O,O,B,T],
            [T,B,O,O,W,B,O,O,O,O,W,B,O,O,B,T],  // eyes look other way
            [T,T,B,O,O,O,O,W,W,O,O,O,O,B,T,T],
            [T,T,B,O,O,O,W,P,P,W,O,O,O,B,T,T],
            [T,T,T,B,O,O,O,W,W,O,O,O,B,T,T,T],
            [T,T,T,T,B,B,R,R,R,R,B,B,T,T,T,T],
            [T,T,T,B,O,O,O,O,O,O,O,O,B,T,T,T],
            [T,T,B,O,O,O,O,O,O,O,O,O,O,B,T,T],
            [T,T,B,O,O,O,O,O,O,O,O,O,O,B,T,T],
            [T,T,T,B,B,B,T,T,T,B,B,B,T,T,T,T],
            [T,T,T,T,B,O,B,T,B,O,B,T,T,T,T,T],  // legs swapped
            [T,B,O,O,B,T,T,T,T,T,T,T,T,T,T,T],  // tail other side
        ]
    }()

    // ========== SKULL (purple hoodie reaper) ==========
    static let skullWalk1: [[UInt32]] = {
        let T = C, B: UInt32 = 0x1A1A2E, W: UInt32 = 0xFFFFFF, WG: UInt32 = 0xDDDDDD, P: UInt32 = 0x8E44AD, PD: UInt32 = 0x6C3483, R: UInt32 = 0xFF4444
        return [
            [T,T,T,T,T,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,T,B,W,W,W,W,W,W,B,T,T,T,T],
            [T,T,T,B,W,W,W,W,W,W,W,W,B,T,T,T],
            [T,T,T,B,W,W,W,W,W,W,W,W,B,T,T,T],
            [T,T,T,B,B,B,W,W,W,B,B,W,B,T,T,T],  // eye sockets
            [T,T,T,B,R,B,W,W,W,R,B,W,B,T,T,T],  // red pupils
            [T,T,T,T,B,W,W,B,B,W,W,B,T,T,T,T],  // nose
            [T,T,T,T,B,W,B,W,W,B,W,B,T,T,T,T],  // teeth
            [T,T,T,T,T,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,B,B,P,P,P,P,P,P,B,B,T,T,T],  // hoodie
            [T,T,B,P,P,P,P,P,P,P,P,P,P,B,T,T],
            [T,B,PD,B,P,P,P,P,P,P,P,B,PD,B,T,T],
            [T,T,T,T,B,P,P,P,P,P,B,T,T,T,T,T],
            [T,T,T,T,T,B,B,T,B,B,T,T,T,T,T,T],
            [T,T,T,T,B,B,T,T,T,B,B,T,T,T,T,T],
            [T,T,T,T,T,T,T,T,T,T,T,T,T,T,T,T],
        ]
    }()
    static let skullWalk2: [[UInt32]] = {
        let T = C, B: UInt32 = 0x1A1A2E, W: UInt32 = 0xFFFFFF, WG: UInt32 = 0xDDDDDD, P: UInt32 = 0x8E44AD, PD: UInt32 = 0x6C3483, R: UInt32 = 0xFF4444
        return [
            [T,T,T,T,T,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,T,B,W,W,W,W,W,W,B,T,T,T,T],
            [T,T,T,B,W,W,W,W,W,W,W,W,B,T,T,T],
            [T,T,T,B,W,W,W,W,W,W,W,W,B,T,T,T],
            [T,T,T,B,B,B,W,W,W,B,B,W,B,T,T,T],
            [T,T,T,B,R,B,W,W,W,R,B,W,B,T,T,T],
            [T,T,T,T,B,W,W,B,B,W,W,B,T,T,T,T],
            [T,T,T,T,B,W,W,B,B,W,W,B,T,T,T,T],  // grin
            [T,T,T,T,T,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,B,B,P,P,P,P,P,P,B,B,T,T,T],
            [T,T,B,P,P,P,P,P,P,P,P,P,P,B,T,T],
            [T,B,PD,B,P,P,P,P,P,P,P,B,PD,B,T,T],
            [T,T,T,T,B,P,P,P,P,P,B,T,T,T,T,T],
            [T,T,T,T,B,B,T,T,T,B,B,T,T,T,T,T],
            [T,T,T,T,T,B,B,T,B,B,T,T,T,T,T,T],
            [T,T,T,T,T,T,T,T,T,T,T,T,T,T,T,T],
        ]
    }()

    // ========== CLIPPY → MINION ==========
    static let minionWalk1: [[UInt32]] = {
        let T = C, B: UInt32 = 0x1A1A2E, Y: UInt32 = 0xFDD835, YD: UInt32 = 0xE6C030, W: UInt32 = 0xFFFFFF, G: UInt32 = 0x999999, BL: UInt32 = 0x1565C0, BLD: UInt32 = 0x0D47A1
        return [
            [T,T,T,T,T,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,T,B,Y,Y,Y,Y,Y,Y,B,T,T,T,T],  // head
            [T,T,T,B,Y,Y,Y,Y,Y,Y,Y,Y,B,T,T,T],
            [T,T,T,B,Y,G,G,Y,Y,G,G,Y,B,T,T,T],  // goggle frame
            [T,T,T,B,G,W,W,G,G,W,W,G,B,T,T,T],  // goggles
            [T,T,T,B,G,W,B,G,G,W,B,G,B,T,T,T],  // pupils
            [T,T,T,B,Y,G,G,Y,Y,G,G,Y,B,T,T,T],
            [T,T,T,T,B,Y,Y,B,B,Y,Y,B,T,T,T,T],  // mouth
            [T,T,T,T,T,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,B,BL,BL,BL,BL,BL,BL,BL,B,T,T,T,T],  // overalls
            [T,T,B,Y,B,BL,BL,BL,BL,BL,B,Y,B,T,T,T],  // arms
            [T,T,T,T,B,BL,BL,BL,BL,BL,B,T,T,T,T,T],
            [T,T,T,T,B,BL,B,B,B,BL,B,T,T,T,T,T],  // pocket
            [T,T,T,T,B,BL,BL,T,BL,BL,B,T,T,T,T],
            [T,T,T,T,T,B,B,T,T,B,B,T,T,T,T,T],  // legs
            [T,T,T,T,B,B,T,T,T,B,B,T,T,T,T,T],  // shoes
        ]
    }()
    static let minionWalk2: [[UInt32]] = {
        let T = C, B: UInt32 = 0x1A1A2E, Y: UInt32 = 0xFDD835, YD: UInt32 = 0xE6C030, W: UInt32 = 0xFFFFFF, G: UInt32 = 0x999999, BL: UInt32 = 0x1565C0, BLD: UInt32 = 0x0D47A1
        return [
            [T,T,T,T,T,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,T,B,Y,Y,Y,Y,Y,Y,B,T,T,T,T],
            [T,T,T,B,Y,Y,Y,Y,Y,Y,Y,Y,B,T,T,T],
            [T,T,T,B,Y,G,G,Y,Y,G,G,Y,B,T,T,T],
            [T,T,T,B,G,W,W,G,G,W,W,G,B,T,T,T],
            [T,T,T,B,G,B,W,G,G,B,W,G,B,T,T,T],  // pupils look other way
            [T,T,T,B,Y,G,G,Y,Y,G,G,Y,B,T,T,T],
            [T,T,T,T,B,Y,Y,Y,Y,Y,Y,B,T,T,T,T],  // smile
            [T,T,T,T,T,B,B,B,B,B,B,T,T,T,T,T],
            [T,T,T,B,BL,BL,BL,BL,BL,BL,BL,B,T,T,T,T],
            [T,T,B,Y,B,BL,BL,BL,BL,BL,B,Y,B,T,T,T],
            [T,T,T,T,B,BL,BL,BL,BL,BL,B,T,T,T,T,T],
            [T,T,T,T,B,BL,B,B,B,BL,B,T,T,T,T,T],
            [T,T,T,T,B,BL,BL,T,BL,BL,B,T,T,T,T],
            [T,T,T,T,B,B,T,T,T,B,B,T,T,T,T,T],
            [T,T,T,T,T,B,B,T,B,B,T,T,T,T,T,T],  // feet swapped
        ]
    }()

    // Render pixel sprite to NSImage
    static func render(_ sprite: [[UInt32]], scale: Int = 6) -> NSImage {
        let w = sprite[0].count
        let h = sprite.count
        let imgW = w * scale
        let imgH = h * scale
        let image = NSImage(size: NSSize(width: imgW, height: imgH))
        image.lockFocus()
        NSColor.clear.set()
        NSRect(x: 0, y: 0, width: imgW, height: imgH).fill()
        for row in 0..<h {
            for col in 0..<w {
                let hex = sprite[row][col]
                guard hex != 0 else { continue }
                let r = CGFloat((hex >> 16) & 0xFF) / 255.0
                let g = CGFloat((hex >> 8) & 0xFF) / 255.0
                let b = CGFloat(hex & 0xFF) / 255.0
                NSColor(red: r, green: g, blue: b, alpha: 1.0).set()
                NSRect(x: col * scale, y: (h - 1 - row) * scale, width: scale, height: scale).fill()
            }
        }
        image.unlockFocus()
        return image
    }

    static func flipped(_ sprite: [[UInt32]]) -> [[UInt32]] {
        return sprite.map { $0.reversed() }
    }
}

extension AgentSkin {
    var pixelFrames: [[[UInt32]]] {
        switch self {
        case .robot: return [PixelSprite.robotWalk1, PixelSprite.robotWalk2]
        case .cat: return [PixelSprite.catWalk1, PixelSprite.catWalk2]
        case .skull: return [PixelSprite.skullWalk1, PixelSprite.skullWalk2]
        case .clippy: return [PixelSprite.minionWalk1, PixelSprite.minionWalk2]
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
        "no_processes":     [.en: "No running AI CLI processes", .ru: "Нет запущенных AI CLI процессов"],
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

class MiniPetView: NSView {
    var onDoubleClick: (() -> Void)?
    private var isDragging = false

    override var acceptsFirstResponder: Bool { true }
    override var mouseDownCanMoveWindow: Bool { false }

    override func mouseDown(with event: NSEvent) {
        if event.clickCount >= 2 {
            onDoubleClick?()
            return
        }
        isDragging = false
    }

    override func mouseDragged(with event: NSEvent) {
        isDragging = true
        guard let win = window else { return }
        var origin = win.frame.origin
        origin.x += event.deltaX
        origin.y -= event.deltaY
        win.setFrameOrigin(origin)
    }

    override func mouseUp(with event: NSEvent) {
        if !isDragging && event.clickCount == 1 {
            // Single click — show a random phrase
            if let delegate = NSApp.delegate as? AgentODelegate {
                delegate.miniSayRandom()
            }
        }
        isDragging = false
    }
}

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
    static let specialtyDefinitions: [(key: String, label: String, keywords: [String])] = [
        (
            key: "stake_game_dev",
            label: "GAME DEV",
            keywords: ["stake", "rgs", "slot", "rtp", "reel", "freespin", "bonus game", "game math", "paytable"]
        ),
        (
            key: "prompt_art",
            label: "Image & Prompt Art",
            keywords: ["image", "art", "render", "midjourney", "stable diffusion", "illustration", "concept art", "style"]
        ),
        (
            key: "frontend_ui",
            label: "Frontend & UX",
            keywords: ["frontend", "react", "next.js", "tailwind", "css", "ui", "ux", "svelte", "vite"]
        ),
        (
            key: "backend_systems",
            label: "Backend & APIs",
            keywords: ["backend", "api", "server", "database", "postgres", "redis", "microservice", "node", "typescript"]
        ),
        (
            key: "automation_ops",
            label: "Automation & Ops",
            keywords: ["automation", "script", "ci", "cd", "deploy", "pipeline", "bash", "terminal", "docker", "kubernetes"]
        ),
        (
            key: "generalist",
            label: "Generalist",
            keywords: []
        ),
    ]

    var facts: [String] = []
    var languages: [String] = []
    var frameworks: [String] = []
    var patterns: [String: Int] = [:]
    var lastTopics: [String] = []
    var specialtyScores: [String: Int] = ["generalist": 1]
    var manualSpecialtyKey: String? = nil

    static func specialtyLabel(for key: String) -> String {
        return specialtyDefinitions.first(where: { $0.key == key })?.label ?? key
    }

    static func isValidSpecialtyKey(_ key: String) -> Bool {
        return specialtyDefinitions.contains(where: { $0.key == key })
    }

    static func specialtyList() -> [(key: String, label: String)] {
        return specialtyDefinitions.map { ($0.key, $0.label) }
    }

    func topSpecialties(limit: Int = 3) -> [(key: String, label: String, score: Int)] {
        var rows: [(key: String, label: String, score: Int)] = []
        for spec in PetBrain.specialtyDefinitions {
            let score = specialtyScores[spec.key] ?? 0
            if score > 0 {
                rows.append((key: spec.key, label: spec.label, score: score))
            }
        }
        if rows.isEmpty {
            rows = [(key: "generalist", label: PetBrain.specialtyLabel(for: "generalist"), score: 1)]
        }
        rows.sort { a, b in
            if a.score == b.score { return a.label < b.label }
            return a.score > b.score
        }
        return Array(rows.prefix(max(1, limit)))
    }

    func currentSpecialtyKey() -> String {
        if let manual = manualSpecialtyKey, PetBrain.isValidSpecialtyKey(manual) {
            return manual
        }
        return topSpecialties(limit: 1).first?.key ?? "generalist"
    }

    func currentSpecialtyLabel() -> String {
        return PetBrain.specialtyLabel(for: currentSpecialtyKey())
    }

    func setManualSpecialty(_ key: String?) {
        if let key = key, !key.isEmpty, PetBrain.isValidSpecialtyKey(key) {
            manualSpecialtyKey = key
        } else {
            manualSpecialtyKey = nil
        }
        save()
    }

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

        var matchedSpecialty = false
        for spec in PetBrain.specialtyDefinitions where spec.key != "generalist" {
            var hits = 0
            for keyword in spec.keywords where lower.contains(keyword) {
                hits += 1
            }
            if hits > 0 {
                specialtyScores[spec.key, default: 0] += hits
                matchedSpecialty = true
            }
        }
        if !matchedSpecialty {
            specialtyScores["generalist", default: 0] += 1
        }

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

        if level >= 8 {
            context.append("Specialization focus: \(currentSpecialtyLabel())")
        }

        if level >= 12 {
            let top = topSpecialties(limit: 3).map { "\($0.label)(\($0.score))" }.joined(separator: ", ")
            context.append("Specialty signals: \(top)")
        }

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
            "specialtyScores": specialtyScores,
            "manualSpecialtyKey": manualSpecialtyKey as Any,
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
        let loadedScores = dict["specialtyScores"] as? [String: Int] ?? [:]
        brain.specialtyScores = loadedScores.isEmpty ? ["generalist": 1] : loadedScores
        brain.manualSpecialtyKey = dict["manualSpecialtyKey"] as? String
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

struct ProviderCostRow {
    var requests: Int = 0
    var inputChars: Int = 0
    var outputChars: Int = 0
    var inputTokens: Int = 0
    var outputTokens: Int = 0
    var usd: Double = 0
}

class ProviderCostTracker {
    static let savePath = NSHomeDirectory() + "/.agento_costs.json"

    var rows: [String: ProviderCostRow] = [:]
    var rateOverrides: [String: (inputPerM: Double, outputPerM: Double)] = [:]

    func estimateTokens(chars: Int) -> Int {
        return max(0, Int(ceil(Double(max(0, chars)) / 4.0)))
    }

    func envRate(provider: String, suffix: String) -> Double? {
        let key = "AGENTO_RATE_\(provider.uppercased())_\(suffix)"
        guard let raw = ProcessInfo.processInfo.environment[key]?.trimmingCharacters(in: .whitespacesAndNewlines),
              !raw.isEmpty else {
            return nil
        }
        return Double(raw)
    }

    func defaultRates(provider: String) -> (inputPerM: Double, outputPerM: Double) {
        switch provider.lowercased() {
        case "gpt":
            // Approx defaults (USD per 1M tokens) for budget telemetry.
            return (0.40, 1.60)
        case "gemini":
            // Approx defaults (USD per 1M tokens).
            return (0.35, 1.05)
        case "claude":
            return (0.0, 0.0)
        case "codex":
            return (0.0, 0.0)
        case "ollama":
            return (0.0, 0.0)
        default:
            return (0.0, 0.0)
        }
    }

    func rates(provider: String) -> (inputPerM: Double, outputPerM: Double) {
        let key = provider.lowercased()
        if let override = rateOverrides[key] {
            return override
        }
        let defaults = defaultRates(provider: key)
        let envIn = envRate(provider: key, suffix: "IN_PER_M")
        let envOut = envRate(provider: key, suffix: "OUT_PER_M")
        return (
            inputPerM: envIn ?? defaults.inputPerM,
            outputPerM: envOut ?? defaults.outputPerM
        )
    }

    func estimateUSD(provider: String, inputChars: Int, outputChars: Int) -> Double {
        let ratesNow = rates(provider: provider)
        let inTokens = estimateTokens(chars: inputChars)
        let outTokens = estimateTokens(chars: outputChars)
        let inUSD = (Double(inTokens) / 1_000_000.0) * ratesNow.inputPerM
        let outUSD = (Double(outTokens) / 1_000_000.0) * ratesNow.outputPerM
        return inUSD + outUSD
    }

    func record(provider: String, inputChars: Int, outputChars: Int) {
        let key = provider.lowercased()
        let inTokens = estimateTokens(chars: inputChars)
        let outTokens = estimateTokens(chars: outputChars)
        let runUSD = estimateUSD(provider: key, inputChars: inputChars, outputChars: outputChars)

        var row = rows[key] ?? ProviderCostRow()
        row.requests += 1
        row.inputChars += max(0, inputChars)
        row.outputChars += max(0, outputChars)
        row.inputTokens += inTokens
        row.outputTokens += outTokens
        row.usd += runUSD
        rows[key] = row
        save()
    }

    func setRates(provider: String, inputPerM: Double, outputPerM: Double) {
        rateOverrides[provider.lowercased()] = (max(0, inputPerM), max(0, outputPerM))
        save()
    }

    func clearRates(provider: String) {
        rateOverrides.removeValue(forKey: provider.lowercased())
        save()
    }

    func reset() {
        rows.removeAll()
        save()
    }

    func totalUSD() -> Double {
        return rows.values.reduce(0) { $0 + $1.usd }
    }

    func totalRequests() -> Int {
        return rows.values.reduce(0) { $0 + $1.requests }
    }

    func save() {
        var rowsRaw: [String: Any] = [:]
        for (provider, row) in rows {
            rowsRaw[provider] = [
                "requests": row.requests,
                "inputChars": row.inputChars,
                "outputChars": row.outputChars,
                "inputTokens": row.inputTokens,
                "outputTokens": row.outputTokens,
                "usd": row.usd,
            ]
        }

        var overridesRaw: [String: Any] = [:]
        for (provider, rates) in rateOverrides {
            overridesRaw[provider] = [
                "inputPerM": rates.inputPerM,
                "outputPerM": rates.outputPerM,
            ]
        }

        let payload: [String: Any] = [
            "rows": rowsRaw,
            "rateOverrides": overridesRaw,
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: payload),
           let json = String(data: jsonData, encoding: .utf8) {
            try? json.write(toFile: ProviderCostTracker.savePath, atomically: true, encoding: .utf8)
        }
    }

    static func load() -> ProviderCostTracker {
        let tracker = ProviderCostTracker()
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: savePath)),
              let raw = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return tracker
        }

        if let rowsRaw = raw["rows"] as? [String: [String: Any]] {
            for (provider, row) in rowsRaw {
                tracker.rows[provider] = ProviderCostRow(
                    requests: row["requests"] as? Int ?? 0,
                    inputChars: row["inputChars"] as? Int ?? 0,
                    outputChars: row["outputChars"] as? Int ?? 0,
                    inputTokens: row["inputTokens"] as? Int ?? 0,
                    outputTokens: row["outputTokens"] as? Int ?? 0,
                    usd: row["usd"] as? Double ?? 0
                )
            }
        }

        if let overridesRaw = raw["rateOverrides"] as? [String: [String: Any]] {
            for (provider, rates) in overridesRaw {
                let inPerM = rates["inputPerM"] as? Double ?? 0
                let outPerM = rates["outputPerM"] as? Double ?? 0
                tracker.rateOverrides[provider] = (inPerM, outPerM)
            }
        }

        return tracker
    }
}

enum PersonalityType: String, CaseIterable {
    case helpful
    case sarcastic
    case zen
    case hyper

    var label: String {
        switch self {
        case .helpful: return "Helpful"
        case .sarcastic: return "Sarcastic"
        case .zen: return "Zen"
        case .hyper: return "Hyper"
        }
    }
}

class PersonalityProfile {
    static let savePath = NSHomeDirectory() + "/.agento_memory.json"
    static let legacyPath = NSHomeDirectory() + "/.agento_personality.json"

    var manualTypeKey: String?
    var categoryCounts: [String: Int] = [:]
    var commandCounts: [String: Int] = [:]
    var providerCounts: [String: Int] = [:]
    var languageCounts: [String: Int] = [:]
    var timeOfDayCounts: [String: Int] = [:]
    var successfulRuns: Int = 0
    var failedRuns: Int = 0
    var promptRuns: Int = 0
    var fastBurstCount: Int = 0
    var focusActions: Int = 0
    var socialActions: Int = 0
    var helperActions: Int = 0
    var lastCommandTimestamp: TimeInterval = 0

    var currentType: PersonalityType {
        if let manual = manualTypeKey, let forced = PersonalityType(rawValue: manual) {
            return forced
        }
        return inferredType()
    }

    var runCount: Int {
        return successfulRuns + failedRuns
    }

    var errorRate: Double {
        guard runCount > 0 else { return 0 }
        return Double(failedRuns) / Double(runCount)
    }

    func activeTimeBucketLabel() -> String {
        let sorted = timeOfDayCounts.sorted { a, b in
            if a.value == b.value { return a.key < b.key }
            return a.value > b.value
        }
        guard let top = sorted.first else { return "n/a" }
        return top.key
    }

    func topLanguages(limit: Int = 3) -> [(String, Int)] {
        return languageCounts
            .sorted { a, b in
                if a.value == b.value { return a.key < b.key }
                return a.value > b.value
            }
            .prefix(limit)
            .map { ($0.key, $0.value) }
    }

    func hourBucket(for date: Date = Date()) -> String {
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 6..<12: return "morning"
        case 12..<18: return "day"
        case 18..<24: return "evening"
        default: return "night"
        }
    }

    func detectLanguages(in input: String) -> [String] {
        let text = input.lowercased()
        let lexemes: [String: [String]] = [
            "swift": ["swift", "xcode", "appkit", "swiftui"],
            "python": ["python", "py ", "pip", "pytest"],
            "javascript": ["javascript", "js ", "node", "npm", "pnpm", "tsx"],
            "typescript": ["typescript", "ts ", "tsconfig", "typecheck"],
            "go": ["golang", "go ", "go.mod"],
            "rust": ["rust", "cargo", ".rs"],
            "cpp": [" c++", "cpp", ".hpp", ".cc", ".cpp"],
            "java": ["java", "gradle", "maven"],
            "sql": ["sql", "postgres", "mysql", "sqlite"],
            "html/css": ["html", "css", "tailwind", "svg"]
        ]
        var found: [String] = []
        for (lang, markers) in lexemes {
            if markers.contains(where: { text.contains($0) }) {
                found.append(lang)
            }
        }
        return found
    }

    func commandCategory(_ input: String) -> String {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if trimmed.isEmpty { return "prompt" }
        if !trimmed.hasPrefix("/") { return "prompt" }
        let token = trimmed.split(separator: " ").first.map(String.init) ?? trimmed

        let focus: Set<String> = ["/pomo", "/pomo10", "/break", "/stoppomo", "/rest"]
        let social: Set<String> = ["/battle", "/accept", "/decline", "/move", "/battles", "/leaderboard", "/market", "/rent", "/name"]
        let tools: Set<String> = ["/diff", "/commit", "/test", "/ask", "/screenshot", "/regex", "/sh", "/watch", "/unwatch", "/git", "/ps", "/save", "/snippets", "/search", "/export"]
        let learn: Set<String> = ["/train", "/teach", "/memory", "/brain", "/promptcoach", "/promptstats", "/training", "/specialist", "/personality", "/suggest", "/optimizer"]
        let fun: Set<String> = ["/game", "/trivia", "/typing", "/dance", "/quests", "/inventory"]

        if focus.contains(token) { return "focus" }
        if social.contains(token) { return "social" }
        if tools.contains(token) { return "tools" }
        if learn.contains(token) { return "learning" }
        if fun.contains(token) { return "fun" }
        if token == "/help" || token == "/version" || token == "/update" || token == "/clear" { return "meta" }
        if token == "/model" || token == "/models" || token == "/compare" || token == "/usage" || token == "/cost" { return "ai_router" }
        return "prompt"
    }

    func recordInput(_ input: String) {
        let now = Date().timeIntervalSince1970
        if lastCommandTimestamp > 0 && (now - lastCommandTimestamp) < 15 {
            fastBurstCount += 1
        }
        lastCommandTimestamp = now

        let normalized = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if normalized.hasPrefix("/") {
            let token = normalized.split(separator: " ").first.map(String.init) ?? normalized
            commandCounts[token, default: 0] += 1
        }

        let category = commandCategory(input)
        categoryCounts[category, default: 0] += 1
        let bucket = hourBucket()
        timeOfDayCounts[bucket, default: 0] += 1

        let langs = detectLanguages(in: input)
        for lang in langs {
            languageCounts[lang, default: 0] += 1
        }

        if category == "prompt" {
            promptRuns += 1
        }
        if category == "focus" {
            focusActions += 1
        }
        if category == "social" {
            socialActions += 1
        }
        if category == "tools" || category == "learning" {
            helperActions += 1
        }
        save()
    }

    func recordRun(provider: String, success: Bool) {
        let key = provider.lowercased()
        providerCounts[key, default: 0] += 1
        if success {
            successfulRuns += 1
        } else {
            failedRuns += 1
        }
        save()
    }

    func setManualType(_ type: PersonalityType?) {
        manualTypeKey = type?.rawValue
        save()
    }

    func inferredType() -> PersonalityType {
        if focusActions >= 12 && errorRate < 0.2 {
            return .zen
        }
        if fastBurstCount >= 25 || promptRuns >= 160 {
            return .hyper
        }
        if failedRuns >= 8 && errorRate >= 0.35 {
            return .sarcastic
        }
        let eveningAndNight = (timeOfDayCounts["evening"] ?? 0) + (timeOfDayCounts["night"] ?? 0)
        let morningAndDay = (timeOfDayCounts["morning"] ?? 0) + (timeOfDayCounts["day"] ?? 0)
        if eveningAndNight >= 40 && eveningAndNight > morningAndDay {
            return .zen
        }
        return .helpful
    }

    func successLine() -> String {
        switch currentType {
        case .helpful:
            return "Nice work. XP secured."
        case .sarcastic:
            return "Well, that actually worked."
        case .zen:
            return "Flow maintained. Good output."
        case .hyper:
            return "Boom! Another win!"
        }
    }

    func errorLine() -> String {
        switch currentType {
        case .helpful:
            return "No worries, we can fix this."
        case .sarcastic:
            return "Great. Another error. Let's patch it."
        case .zen:
            return "Breathe. We debug step by step."
        case .hyper:
            return "Error spike! Let's counter-attack."
        }
    }

    func thinkingLine() -> String {
        switch currentType {
        case .helpful:
            return "Thinking..."
        case .sarcastic:
            return "Thinking, because guessing is expensive..."
        case .zen:
            return "Centering context..."
        case .hyper:
            return "Turbo thinking..."
        }
    }

    func save() {
        let data: [String: Any] = [
            "manualTypeKey": manualTypeKey as Any,
            "categoryCounts": categoryCounts,
            "commandCounts": commandCounts,
            "providerCounts": providerCounts,
            "languageCounts": languageCounts,
            "timeOfDayCounts": timeOfDayCounts,
            "successfulRuns": successfulRuns,
            "failedRuns": failedRuns,
            "promptRuns": promptRuns,
            "fastBurstCount": fastBurstCount,
            "focusActions": focusActions,
            "socialActions": socialActions,
            "helperActions": helperActions,
            "lastCommandTimestamp": lastCommandTimestamp,
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: data),
           let json = String(data: jsonData, encoding: .utf8) {
            try? json.write(toFile: PersonalityProfile.savePath, atomically: true, encoding: .utf8)
        }
    }

    static func load() -> PersonalityProfile {
        let profile = PersonalityProfile()
        let sourcePath: String
        if FileManager.default.fileExists(atPath: savePath) {
            sourcePath = savePath
        } else if FileManager.default.fileExists(atPath: legacyPath) {
            sourcePath = legacyPath
        } else {
            return profile
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: sourcePath)),
              let raw = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return profile
        }
        profile.manualTypeKey = raw["manualTypeKey"] as? String
        profile.categoryCounts = raw["categoryCounts"] as? [String: Int] ?? [:]
        profile.commandCounts = raw["commandCounts"] as? [String: Int] ?? [:]
        profile.providerCounts = raw["providerCounts"] as? [String: Int] ?? [:]
        profile.languageCounts = raw["languageCounts"] as? [String: Int] ?? [:]
        profile.timeOfDayCounts = raw["timeOfDayCounts"] as? [String: Int] ?? [:]
        profile.successfulRuns = raw["successfulRuns"] as? Int ?? 0
        profile.failedRuns = raw["failedRuns"] as? Int ?? 0
        profile.promptRuns = raw["promptRuns"] as? Int ?? 0
        profile.fastBurstCount = raw["fastBurstCount"] as? Int ?? 0
        profile.focusActions = raw["focusActions"] as? Int ?? 0
        profile.socialActions = raw["socialActions"] as? Int ?? 0
        profile.helperActions = raw["helperActions"] as? Int ?? 0
        profile.lastCommandTimestamp = raw["lastCommandTimestamp"] as? TimeInterval ?? 0
        return profile
    }
}

enum TokenOptimizerMode: String {
    case off
    case balanced
    case aggressive
}

struct TokenOptimizationResult {
    var finalPrompt: String
    var originalChars: Int
    var optimizedChars: Int
    var savedChars: Int
    var mode: TokenOptimizerMode
    var usedBrainContext: Bool

    var savedPercent: Int {
        guard originalChars > 0 else { return 0 }
        return Int((Double(savedChars) / Double(originalChars)) * 100.0)
    }
}

class TokenOptimizer {
    static let savePath = NSHomeDirectory() + "/.agento_optimizer.json"

    struct Limits {
        let promptChars: Int
        let promptLines: Int
        let contextChars: Int
        let contextLines: Int
        let totalChars: Int
        let includeBrainForCodex: Bool
    }

    var mode: TokenOptimizerMode = .balanced
    var totalRuns: Int = 0
    var claudeRuns: Int = 0
    var codexRuns: Int = 0
    var totalOriginalChars: Int = 0
    var totalOptimizedChars: Int = 0

    var isEnabled: Bool {
        return mode != .off
    }

    var totalSavedChars: Int {
        return max(0, totalOriginalChars - totalOptimizedChars)
    }

    var totalSavedPercent: Int {
        guard totalOriginalChars > 0 else { return 0 }
        return Int((Double(totalSavedChars) / Double(totalOriginalChars)) * 100.0)
    }

    func limits(for cli: String) -> Limits {
        let isCodex = cli.lowercased() == "codex"
        switch mode {
        case .off:
            return Limits(
                promptChars: 100000,
                promptLines: 2000,
                contextChars: 100000,
                contextLines: 2000,
                totalChars: 200000,
                includeBrainForCodex: false
            )
        case .balanced:
            if isCodex {
                return Limits(
                    promptChars: 2600,
                    promptLines: 70,
                    contextChars: 360,
                    contextLines: 14,
                    totalChars: 3000,
                    includeBrainForCodex: true
                )
            }
            return Limits(
                promptChars: 3200,
                promptLines: 85,
                contextChars: 650,
                contextLines: 18,
                totalChars: 3900,
                includeBrainForCodex: true
            )
        case .aggressive:
            if isCodex {
                return Limits(
                    promptChars: 1550,
                    promptLines: 42,
                    contextChars: 240,
                    contextLines: 9,
                    totalChars: 1800,
                    includeBrainForCodex: true
                )
            }
            return Limits(
                promptChars: 1900,
                promptLines: 50,
                contextChars: 320,
                contextLines: 10,
                totalChars: 2200,
                includeBrainForCodex: true
            )
        }
    }

    func optimize(prompt: String, brainContext: String?, cli: String) -> TokenOptimizationResult {
        let safePrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        let safeContext = (brainContext ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        var composedOriginal = safePrompt
        if !safeContext.isEmpty && cli.lowercased() != "codex" {
            composedOriginal = "\(safeContext)\n\n\(safePrompt)"
        }

        if mode == .off {
            let unchanged = TokenOptimizationResult(
                finalPrompt: composedOriginal,
                originalChars: composedOriginal.count,
                optimizedChars: composedOriginal.count,
                savedChars: 0,
                mode: .off,
                usedBrainContext: !safeContext.isEmpty && cli.lowercased() != "codex"
            )
            record(result: unchanged, cli: cli)
            return unchanged
        }

        let limits = limits(for: cli)
        let normalizedPrompt = normalizeText(safePrompt)
        let compressedPrompt = compressText(
            normalizedPrompt,
            maxChars: limits.promptChars,
            maxLines: limits.promptLines
        )

        var compressedContext = ""
        var useContext = false
        if !safeContext.isEmpty {
            if cli.lowercased() != "codex" || limits.includeBrainForCodex {
                compressedContext = compressText(
                    normalizeText(safeContext),
                    maxChars: limits.contextChars,
                    maxLines: limits.contextLines
                )
                useContext = !compressedContext.isEmpty
            }
        }

        var finalPrompt = compressedPrompt
        if useContext {
            finalPrompt = "\(compressedContext)\n\n\(compressedPrompt)"
        }
        finalPrompt = clipToTotal(finalPrompt, maxChars: limits.totalChars)

        if useContext {
            composedOriginal = "\(safeContext)\n\n\(safePrompt)"
        } else {
            composedOriginal = safePrompt
        }

        let optimized = TokenOptimizationResult(
            finalPrompt: finalPrompt,
            originalChars: composedOriginal.count,
            optimizedChars: finalPrompt.count,
            savedChars: max(0, composedOriginal.count - finalPrompt.count),
            mode: mode,
            usedBrainContext: useContext
        )
        record(result: optimized, cli: cli)
        return optimized
    }

    func resetStats() {
        totalRuns = 0
        claudeRuns = 0
        codexRuns = 0
        totalOriginalChars = 0
        totalOptimizedChars = 0
        save()
    }

    func normalizeText(_ text: String) -> String {
        let lf = text.replacingOccurrences(of: "\r\n", with: "\n")
        let lines = lf.components(separatedBy: "\n")
        var compact: [String] = []
        var blankRun = 0
        for raw in lines {
            let line = raw.replacingOccurrences(of: "\t", with: "    ")
            let isBlank = line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            if isBlank {
                blankRun += 1
                if blankRun > 1 { continue }
                compact.append("")
            } else {
                blankRun = 0
                compact.append(line)
            }
        }
        return compact.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func compressText(_ text: String, maxChars: Int, maxLines: Int) -> String {
        guard !text.isEmpty else { return "" }
        let lines = text.components(separatedBy: "\n")
        var reduced = text

        if lines.count > maxLines {
            let importantTokens = [
                "error", "failed", "exception", "trace", "stack", "fatal",
                "warning", "undefined", "cannot", "invalid", "timeout"
            ]
            let headCount = max(1, Int(Double(maxLines) * 0.5))
            let tailCount = max(1, Int(Double(maxLines) * 0.25))
            let middleStart = min(lines.count, headCount)
            let middleEnd = max(middleStart, lines.count - tailCount)

            var selected = Array(lines.prefix(headCount))
            let middleSlice = lines[middleStart..<middleEnd]
            let middleBudget = max(1, maxLines - headCount - tailCount - 1)
            let important = middleSlice.filter { line in
                let lower = line.lowercased()
                return importantTokens.contains(where: { lower.contains($0) })
            }

            for line in important.prefix(middleBudget) where !selected.contains(line) {
                selected.append(line)
            }
            selected.append("...[trimmed \(max(0, lines.count - maxLines)) lines]...")
            for line in lines.suffix(tailCount) where !selected.contains(line) {
                selected.append(line)
            }
            reduced = selected.joined(separator: "\n")
        }

        if reduced.count <= maxChars {
            return reduced
        }

        let headSize = max(40, Int(Double(maxChars) * 0.68))
        let tailSize = max(20, maxChars - headSize - 28)
        let head = String(reduced.prefix(headSize))
        let tail = String(reduced.suffix(tailSize))
        return "\(head)\n...[trimmed]...\n\(tail)"
    }

    func clipToTotal(_ text: String, maxChars: Int) -> String {
        guard text.count > maxChars else { return text }
        let headSize = max(40, Int(Double(maxChars) * 0.7))
        let tailSize = max(20, maxChars - headSize - 26)
        let head = String(text.prefix(headSize))
        let tail = String(text.suffix(tailSize))
        return "\(head)\n...[snip]...\n\(tail)"
    }

    func record(result: TokenOptimizationResult, cli: String) {
        totalRuns += 1
        totalOriginalChars += result.originalChars
        totalOptimizedChars += result.optimizedChars
        if cli.lowercased() == "codex" {
            codexRuns += 1
        } else {
            claudeRuns += 1
        }
        save()
    }

    func save() {
        let data: [String: Any] = [
            "mode": mode.rawValue,
            "totalRuns": totalRuns,
            "claudeRuns": claudeRuns,
            "codexRuns": codexRuns,
            "totalOriginalChars": totalOriginalChars,
            "totalOptimizedChars": totalOptimizedChars,
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: data),
           let json = String(data: jsonData, encoding: .utf8) {
            try? json.write(toFile: TokenOptimizer.savePath, atomically: true, encoding: .utf8)
        }
    }

    static func load() -> TokenOptimizer {
        let optimizer = TokenOptimizer()
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: savePath)),
              let raw = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return optimizer
        }
        if let modeRaw = raw["mode"] as? String,
           let mode = TokenOptimizerMode(rawValue: modeRaw) {
            optimizer.mode = mode
        }
        optimizer.totalRuns = raw["totalRuns"] as? Int ?? 0
        optimizer.claudeRuns = raw["claudeRuns"] as? Int ?? 0
        optimizer.codexRuns = raw["codexRuns"] as? Int ?? 0
        optimizer.totalOriginalChars = raw["totalOriginalChars"] as? Int ?? 0
        optimizer.totalOptimizedChars = raw["totalOptimizedChars"] as? Int ?? 0
        return optimizer
    }
}

struct BattleDuelContext {
    var challenger: String
    var opponent: String
    var battleId: String
    var moveSubmitted: Bool
}

enum AIProvider: String, CaseIterable {
    case claude
    case codex
    case gpt
    case gemini
    case ollama

    var label: String {
        switch self {
        case .claude: return "Claude CLI"
        case .codex: return "Codex CLI"
        case .gpt: return "OpenAI GPT"
        case .gemini: return "Google Gemini"
        case .ollama: return "Ollama (local)"
        }
    }
}

struct ProviderSyncResult {
    var provider: AIProvider
    var output: String
    var error: String?
    var inputChars: Int
    var outputChars: Int
    var model: String
    var durationMs: Int

    var success: Bool {
        return error == nil && !output.isEmpty
    }
}

// MARK: - Main App Delegate

class AgentODelegate: NSObject, NSApplicationDelegate, NSTextFieldDelegate, NSWindowDelegate {
    static let sourceVersion = "7.1.1"
    static func parseVersion(_ version: String) -> [Int] {
        return version
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: ".")
            .map { Int($0) ?? 0 }
    }

    static func compareVersions(_ lhs: String, _ rhs: String) -> Int {
        let left = parseVersion(lhs)
        let right = parseVersion(rhs)
        let count = max(left.count, right.count)
        for idx in 0..<count {
            let l = idx < left.count ? left[idx] : 0
            let r = idx < right.count ? right[idx] : 0
            if l < r { return -1 }
            if l > r { return 1 }
        }
        return 0
    }

    static var currentVersion: String {
        let source = sourceVersion.trimmingCharacters(in: .whitespacesAndNewlines)
        if let bundleVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           !bundleVersion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let bundle = bundleVersion.trimmingCharacters(in: .whitespacesAndNewlines)
            return compareVersions(source, bundle) >= 0 ? source : bundle
        }
        return source
    }
    // UI
    var window: NSPanel!
    var miniWindow: NSPanel!
    var miniLabel: NSTextField!
    var agentLabel: NSTextField!  // kept for compact mode fallback
    var agentImageView: NSImageView!
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
    var commandAutocompleteMatches: [String] = []
    var commandAutocompleteSeed: String = ""
    var commandAutocompleteIndex: Int = 0
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
    var personality = PersonalityProfile.load()
    var costTracker = ProviderCostTracker.load()
    var tokenOptimizer = TokenOptimizer.load()
    var lastTokenOptimization: TokenOptimizationResult?
    var currentProvider: AIProvider = .claude
    var providerModelOverrides: [String: String] = [:]
    var providerEndpointOverrides: [String: String] = [:]
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
    var leaderboardSyncTimer: Timer?
    var knownIncomingChallengeKeys: Set<String> = []
    var activeDuel: BattleDuelContext?
    var duelStatusTimer: Timer?
    var duelLastStatusSignature: String = ""
    var lastLeaderboardSubmittedSignature: String = ""
    var lastSilentLeaderboardErrorAt: Date?

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
        if let rawProvider = UserDefaults.standard.string(forKey: "agento_provider"),
           let provider = AIProvider(rawValue: rawProvider.lowercased()) {
            currentProvider = provider
        }
        providerModelOverrides = UserDefaults.standard.dictionary(forKey: "agento_provider_models") as? [String: String] ?? [:]
        providerEndpointOverrides = UserDefaults.standard.dictionary(forKey: "agento_provider_endpoints") as? [String: String] ?? [:]
        pet.save()
        lastLeaderboardSubmittedSignature = ""
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
        bubbleLabel.stringValue = speechBubble("New look! \(skin.rawValue)")
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
        window.becomesKeyOnlyIfNeeded = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.isMovableByWindowBackground = false
        window.titlebarAppearsTransparent = true
        window.isOpaque = false
        window.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.14, alpha: 1.0)
        window.minSize = NSSize(width: 360, height: 500)
        window.delegate = self

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

        // Pixel agent (left) + side stats (right)
        yPos -= 150
        let agentW: CGFloat = (w - 20) * 0.55
        // Hidden text label kept for compact mode
        agentLabel = NSTextField(labelWithString: "")
        agentLabel.frame = NSRect(x: 10, y: yPos, width: agentW, height: 150)
        agentLabel.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .medium)
        agentLabel.textColor = cCyan
        agentLabel.alignment = .center
        agentLabel.autoresizingMask = [.width, .minYMargin]
        agentLabel.isHidden = true
        dropContainer.addSubview(agentLabel)

        // Pixel art image view
        let spriteScale = 8
        let spriteSize = 16 * spriteScale  // 128px
        agentImageView = NSImageView(frame: NSRect(
            x: 10 + (Int(agentW) - spriteSize) / 2,
            y: Int(yPos) + (150 - spriteSize) / 2,
            width: spriteSize, height: spriteSize
        ))
        agentImageView.imageScaling = .scaleNone
        agentImageView.wantsLayer = true
        agentImageView.autoresizingMask = [.minYMargin]
        dropContainer.addSubview(agentImageView)

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

    var miniBubbleLabel: NSTextField!
    var miniImageView: NSImageView!
    var miniAnimFrame = 0
    var miniWalkTimer: Timer?
    var miniWalkDirection: CGFloat = 1  // 1 = right, -1 = left
    var miniWalkSpeed: CGFloat = 1.2
    var miniIsWalking = false
    var miniBubbleHideTimer: Timer?

    // MARK: - Mini Window (Minimized Mode)

    func setupMiniWindow() {
        let screen = NSScreen.main!.visibleFrame
        let spriteSize: CGFloat = 96   // 16px * 6 scale
        let mw: CGFloat = spriteSize + 8
        let bubbleH: CGFloat = 22
        let mh: CGFloat = spriteSize + bubbleH + 8
        miniWindow = NSPanel(
            contentRect: NSRect(x: screen.midX - mw / 2, y: screen.minY + 4, width: mw, height: mh),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        miniWindow.isFloatingPanel = true
        miniWindow.level = .floating
        miniWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        miniWindow.isMovableByWindowBackground = false
        miniWindow.backgroundColor = .clear
        miniWindow.hasShadow = false
        miniWindow.isOpaque = false

        let container = MiniPetView(frame: NSRect(x: 0, y: 0, width: mw, height: mh))
        container.wantsLayer = true
        container.layer?.backgroundColor = NSColor.clear.cgColor
        container.onDoubleClick = { [weak self] in self?.toggleWindow() }

        // Speech bubble above character
        miniBubbleLabel = NSTextField(labelWithString: "")
        miniBubbleLabel.frame = NSRect(x: -40, y: mh - bubbleH - 2, width: mw + 80, height: bubbleH)
        miniBubbleLabel.font = NSFont.systemFont(ofSize: 11, weight: .semibold)
        miniBubbleLabel.textColor = .white
        miniBubbleLabel.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.15, alpha: 0.9)
        miniBubbleLabel.isBezeled = false
        miniBubbleLabel.drawsBackground = true
        miniBubbleLabel.wantsLayer = true
        miniBubbleLabel.layer?.cornerRadius = 10
        miniBubbleLabel.layer?.masksToBounds = true
        miniBubbleLabel.alignment = .center
        miniBubbleLabel.maximumNumberOfLines = 1
        miniBubbleLabel.lineBreakMode = .byTruncatingTail
        miniBubbleLabel.isHidden = true

        // Pixel art character
        miniImageView = NSImageView(frame: NSRect(x: 4, y: 4, width: spriteSize, height: spriteSize))
        miniImageView.imageScaling = .scaleNone
        miniImageView.wantsLayer = true

        container.addSubview(miniImageView)
        container.addSubview(miniBubbleLabel)
        miniWindow.contentView = container

        updateMiniAgent()
    }

    var miniJumpOffset: CGFloat = 0
    var miniJumpVelocity: CGFloat = 0
    var miniIsJumping = false
    var miniBaseY: CGFloat = 0
    var miniSayTimer: Timer?
    var miniStepCount = 0

    static let miniPhrases = [
        "Hey! Click me!", "Wandering...", "La la la~", "Boop!",
        "I'm a pixel!", "Watcha doin?", "*walks*", "Beep boop!",
        "So many windows!", "Exploring...", "*happy noises*",
        "I can see your dock!", "Wheee!", "Adventure time!",
        "Need help? Click me!", "*bounces*", "Pixel power!",
        "Over here!", "Catch me!", "*stretches*",
        "Let's code!", "Debug time!", "Ship it!", "LGTM!",
    ]

    func startMiniWalk() {
        guard miniWalkTimer == nil else { return }
        miniIsWalking = true
        miniBaseY = miniWindow.frame.origin.y
        miniStepCount = 0
        miniWalkTimer = Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { [weak self] _ in
            self?.stepMiniWalk()
        }
        // Random phrases timer
        miniSayTimer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { [weak self] _ in
            self?.miniSayRandom()
        }
        // Say hi immediately
        showMiniBubble("Hey! Click me to open!")
    }

    func stopMiniWalk() {
        miniIsWalking = false
        miniWalkTimer?.invalidate()
        miniWalkTimer = nil
        miniSayTimer?.invalidate()
        miniSayTimer = nil
    }

    func miniSayRandom() {
        guard miniIsWalking else { return }
        let phrase = AgentODelegate.miniPhrases.randomElement() ?? "..."
        showMiniBubble(phrase)
    }

    func showMiniBubble(_ text: String) {
        guard miniBubbleLabel != nil else { return }
        miniBubbleLabel.stringValue = " \(text) "
        miniBubbleLabel.isHidden = false
        miniBubbleHideTimer?.invalidate()
        miniBubbleHideTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { [weak self] _ in
            self?.miniBubbleLabel.isHidden = true
        }
    }

    func stepMiniWalk() {
        guard let screen = NSScreen.main?.visibleFrame else { return }
        var frame = miniWindow.frame

        // Horizontal movement
        frame.origin.x += miniWalkSpeed * miniWalkDirection

        // Bounce off edges
        if frame.origin.x <= screen.minX {
            frame.origin.x = screen.minX
            miniWalkDirection = 1
        } else if frame.maxX >= screen.maxX {
            frame.origin.x = screen.maxX - frame.width
            miniWalkDirection = -1
        }

        // Random jump
        miniStepCount += 1
        if !miniIsJumping && miniStepCount % 120 == 0 && Int.random(in: 0..<3) == 0 {
            miniIsJumping = true
            miniJumpVelocity = 6.0
            showMiniBubble(["Wheee!", "Boing!", "Jump!", "*hops*", "Yay!"].randomElement()!)
        }

        // Jump physics
        if miniIsJumping {
            miniJumpOffset += miniJumpVelocity
            miniJumpVelocity -= 0.4  // gravity
            if miniJumpOffset <= 0 {
                miniJumpOffset = 0
                miniJumpVelocity = 0
                miniIsJumping = false
            }
        }

        frame.origin.y = miniBaseY + miniJumpOffset
        miniWindow.setFrameOrigin(frame.origin)
    }

    func updateMiniAgent() {
        guard miniImageView != nil else { return }
        let pixFrames = currentSkin.pixelFrames
        miniAnimFrame = (miniAnimFrame + 1) % pixFrames.count
        let sprite = pixFrames[miniAnimFrame]

        let finalSprite = miniWalkDirection < 0 ? PixelSprite.flipped(sprite) : sprite
        miniImageView.image = PixelSprite.render(finalSprite)
    }

    func syncMiniBubble() {
        // only used from main window state changes — show relevant messages in mini
        guard miniBubbleLabel != nil, miniIsWalking, bubbleLabel != nil else { return }
        let full = bubbleLabel.stringValue
        let lines = full.components(separatedBy: "\n").filter { $0.contains("│") }
        let text = lines.map { $0.replacingOccurrences(of: "│", with: "").trimmingCharacters(in: .whitespaces) }.joined(separator: " ")
        guard !text.isEmpty else { return }
        // Filter out boring/technical messages
        let skip = ["Tip:", "Skin:", "up/down", "arrows", "/help", "Level"]
        if skip.contains(where: { text.contains($0) }) { return }
        showMiniBubble(text)
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
            updateMiniAgent()
            startMiniWalk()
        } else {
            stopMiniWalk()
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

        // Reposition: pixel agent at top, centered
        let compactSpriteSize = 16 * 6
        agentImageView.frame = NSRect(
            x: (Int(w) - compactSpriteSize) / 2,
            y: Int(h) - 30 - compactSpriteSize - 4,
            width: compactSpriteSize, height: compactSpriteSize
        )
        agentImageView.image = PixelSprite.render(currentSkin.pixelFrames[0], scale: 6)

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
        let fullSpriteSize = 16 * 8
        agentImageView.frame = NSRect(
            x: 10 + (Int(agentW) - fullSpriteSize) / 2,
            y: Int(yPos) + (150 - fullSpriteSize) / 2,
            width: fullSpriteSize, height: fullSpriteSize
        )
        agentImageView.image = PixelSprite.render(currentSkin.pixelFrames[0], scale: 8)
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
            if Int.random(in: 0..<3) == 0, let suggestion = self.bestSuggestionLine() {
                self.bubbleLabel.stringValue = speechBubble(suggestion)
            } else {
                let tip = AgentArt.tips.randomElement()!
                self.bubbleLabel.stringValue = speechBubble(tip)
            }
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
        leaderboardSyncTimer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true) { [weak self] _ in
            self?.syncLeaderboardIfNeeded()
        }
    }

    func animate() {
        // Pixel art in main window
        let pixFrames = currentSkin.pixelFrames
        animFrame = (animFrame + 1) % pixFrames.count
        if agentImageView != nil {
            agentImageView.image = PixelSprite.render(pixFrames[animFrame], scale: 8)
        }
        updateMiniAgent()
    }

    func updateAgentDisplay() {
        let pixFrames = currentSkin.pixelFrames
        if agentImageView != nil {
            agentImageView.image = PixelSprite.render(pixFrames[0], scale: 8)
        }
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
            self?.runCLI(cli: self?.currentProvider.rawValue ?? "claude", prompt: prompt, oldLevel: oldLevel)
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

    func resetCommandAutocomplete() {
        commandAutocompleteMatches = []
        commandAutocompleteSeed = ""
        commandAutocompleteIndex = 0
    }

    func slashAutocompleteCommands() -> [String] {
        return [
            "/accept", "/ach", "/achievements", "/ask", "/battle", "/battles", "/brain",
            "/break", "/calc", "/chat", "/challenges", "/claude", "/clear", "/clipboard", "/compare", "/cost",
            "/codex", "/commit", "/compact", "/daily", "/dance", "/decline", "/diff",
            "/en", "/evo", "/export", "/feed", "/forget", "/full", "/game", "/git", "/guess",
            "/gemini", "/gpt", "/help", "/history", "/inventory", "/leaderboard", "/market", "/memory", "/model", "/models", "/move",
            "/personality", "/suggest", "/test",
            "/name", "/paste", "/play", "/pomo", "/pomo10", "/pomodoro", "/promptcoach",
            "/promptstats", "/ps", "/quests", "/regex", "/remind", "/reminders", "/rent", "/rest",
            "/review", "/ru", "/save", "/screenshot", "/search", "/sh", "/share", "/skin",
            "/snippets", "/specialist", "/standup", "/stats", "/stoppomo", "/teach", "/theme", "/tip", "/optimizer",
            "/train", "/training", "/translate", "/trivia", "/typing", "/unwatch", "/update", "/usage", "/version", "/watch", "/ollama"
        ]
    }

    func autocompleteSlashCommand(textView: NSTextView) -> Bool {
        let originalInput = textView.string
        let normalizedInput = normalizeCommandPrefix(originalInput)

        let spaceIndex = normalizedInput.firstIndex(of: " ")
        let commandToken = spaceIndex == nil ? normalizedInput : String(normalizedInput[..<spaceIndex!])
        let argsSuffix = spaceIndex == nil ? "" : String(normalizedInput[spaceIndex!...])

        guard commandToken.hasPrefix("/") else { return false }
        let query = commandToken.lowercased()
        let isCyclingCurrentResult = !commandAutocompleteMatches.isEmpty &&
            (query == commandAutocompleteSeed || query == commandAutocompleteMatches[commandAutocompleteIndex].lowercased())

        let matches: [String]
        if isCyclingCurrentResult {
            matches = commandAutocompleteMatches
            commandAutocompleteIndex = (commandAutocompleteIndex + 1) % matches.count
        } else {
            matches = slashAutocompleteCommands().filter { $0.hasPrefix(query) }
            guard !matches.isEmpty else {
                NSSound.beep()
                return true
            }
            commandAutocompleteMatches = matches
            commandAutocompleteSeed = query
            commandAutocompleteIndex = 0
        }

        let completion = matches[commandAutocompleteIndex]
        let completedText = completion + argsSuffix

        inputField.stringValue = completedText
        textView.string = completedText
        textView.setSelectedRange(NSRange(location: completedText.count, length: 0))
        return true
    }

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            resetCommandAutocomplete()
            sendPrompt()
            return true
        }
        if commandSelector == #selector(NSResponder.insertTab(_:)) {
            return autocompleteSlashCommand(textView: textView)
        }
        if commandSelector == #selector(NSResponder.selectAll(_:)) {
            textView.selectAll(nil)
            return true
        }
        if commandSelector == #selector(NSResponder.moveUp(_:)) {
            resetCommandAutocomplete()
            navigateHistory(direction: -1)
            return true
        }
        if commandSelector == #selector(NSResponder.moveDown(_:)) {
            resetCommandAutocomplete()
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
            appendOutput("⏳ Analyzing file via \(currentProvider.rawValue)...\n")

            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.runCLI(cli: self?.currentProvider.rawValue ?? "claude", prompt: prompt)
            }
        }
    }

    // MARK: - Process Monitor

    func monitorProcesses() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let result = self?.shell("ps aux | grep -E '(claude|codex|ollama|gemini)' | grep -v grep | awk '{print $11, $12, $13}' 2>/dev/null") ?? ""
            DispatchQueue.main.async {
                let lines = result.trimmingCharacters(in: .whitespacesAndNewlines)
                if lines.isEmpty {
                    self?.appendColored("📊 No running AI CLI processes\n\n", color: self!.cDimGray)
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
        resetCommandAutocomplete()
        let prompt = inputField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }
        let parsedPrompt = normalizeCommandPrefix(prompt)
        inputField.stringValue = ""
        lastInteraction = Date()
        if state == .sleeping { state = .idle }
        personality.recordInput(parsedPrompt)

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

        // Determine provider
        var cli = currentProvider.rawValue
        var actualPrompt = parsedPrompt

        if parsedPrompt.hasPrefix("/codex ") {
            cli = "codex"
            actualPrompt = String(parsedPrompt.dropFirst(7))
        } else if parsedPrompt.hasPrefix("/claude ") {
            actualPrompt = String(parsedPrompt.dropFirst(8))
        } else if parsedPrompt.hasPrefix("/gpt ") {
            cli = "gpt"
            actualPrompt = String(parsedPrompt.dropFirst(5))
        } else if parsedPrompt.hasPrefix("/gemini ") {
            cli = "gemini"
            actualPrompt = String(parsedPrompt.dropFirst(8))
        } else if parsedPrompt.hasPrefix("/ollama ") {
            cli = "ollama"
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
        bubbleLabel.stringValue = speechBubble("\(personality.thinkingLine()) \(actualPrompt.prefix(28))...")
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

        case "/test":
            quickTest()
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

        case "/help all commands":
            showHelpCatalog()
            return true

        case "/memory":
            showBrainMemory()
            return true

        case "/brain":
            exportBrain()
            return true

        case "/model":
            showModelStatus()
            return true

        case "/models":
            showModelCatalog()
            return true

        case "/usage":
            showProviderUsage(days: 7)
            return true

        case "/personality":
            showPersonalityStatus()
            return true

        case "/suggest":
            showProactiveSuggestion()
            return true

        case "/cost":
            showCostSummary()
            return true

        case "/compare":
            appendColored("❌ Usage: /compare <prompt>\n", color: cRed)
            appendColored("  Optional: /compare claude,codex <prompt>\n\n", color: cGray)
            return true

        case "/specialist":
            showSpecialistStatus()
            return true

        case "/specialist list":
            showSpecialistCatalog()
            return true

        case "/optimizer":
            showTokenOptimizerStatus()
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

        case "/quests daily quests":
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

        case "/market":
            showMarketOverview()
            return true

        case "/rent":
            showRentHelp()
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

        case "/export":
            exportSnippetsMarkdown()
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

        case "/training", "/train":
            showTrainingDashboard()
            return true

        case "/clipboard":
            showClipboardHistory("")
            return true

        default:
            if cmd.hasPrefix("/help ") {
                let args = String(cmd.dropFirst(6)).trimmingCharacters(in: .whitespacesAndNewlines)
                handleHelpCommand(args: args)
                return true
            }
            if cmd.hasPrefix("/quests ") {
                showDailyQuests()
                return true
            }
            // Teach/train the pet brain
            if cmd.hasPrefix("/teach ") || cmd.hasPrefix("/train ") {
                let fact = String(cmd.dropFirst(7)).trimmingCharacters(in: .whitespacesAndNewlines)
                if fact.isEmpty {
                    appendColored("Usage: /teach <fact>\n", color: cRed)
                    appendColored("   or: /train <fact>\n\n", color: cGray)
                } else if brain.facts.contains(fact) {
                    appendColored("Already learned: \"\(fact)\"\n\n", color: cDimGray)
                } else {
                    brain.facts.append(fact)
                    brain.save()
                    pet.gainXP(5)
                    pet.save()
                    refreshStatsDisplay()
                    appendColored("Learned: \"\(fact)\"\n", color: cGreen, bold: true)
                    appendColored("  \(brain.facts.count) fact(s) stored  (+5 XP)\n\n", color: cGray)
                    bubbleLabel.stringValue = speechBubble("Training complete!")
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
            if cmd.hasPrefix("/specialist ") {
                let args = String(cmd.dropFirst(12)).trimmingCharacters(in: .whitespacesAndNewlines)
                handleSpecialistCommand(args: args)
                return true
            }
            if cmd.hasPrefix("/model ") {
                let args = String(cmd.dropFirst(7)).trimmingCharacters(in: .whitespacesAndNewlines)
                handleModelCommand(args: args)
                return true
            }
            if cmd.hasPrefix("/usage ") {
                let raw = String(cmd.dropFirst(7)).trimmingCharacters(in: .whitespacesAndNewlines)
                let days = max(1, Int(raw) ?? 7)
                showProviderUsage(days: days)
                return true
            }
            if cmd.hasPrefix("/personality ") {
                let args = String(cmd.dropFirst(13)).trimmingCharacters(in: .whitespacesAndNewlines)
                handlePersonalityCommand(args: args)
                return true
            }
            if cmd.hasPrefix("/cost ") {
                let args = String(cmd.dropFirst(6)).trimmingCharacters(in: .whitespacesAndNewlines)
                handleCostCommand(args: args)
                return true
            }
            if cmd.hasPrefix("/compare ") {
                let args = String(cmd.dropFirst(9)).trimmingCharacters(in: .whitespacesAndNewlines)
                compareProviders(args: args)
                return true
            }
            if cmd.hasPrefix("/optimizer ") {
                let args = String(cmd.dropFirst(11)).trimmingCharacters(in: .whitespacesAndNewlines)
                handleTokenOptimizerCommand(args: args)
                return true
            }
            if cmd.hasPrefix("/rent ") {
                let args = String(cmd.dropFirst(6)).trimmingCharacters(in: .whitespacesAndNewlines)
                handleRentCommand(args: args)
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
                        lastLeaderboardSubmittedSignature = ""
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
                    bubbleLabel.stringValue = speechBubble("New look! \(skin.rawValue)")
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
        appendColored("⏳ → \(currentProvider.rawValue)...\n", color: cDimGray)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let prompt = "Convert this to a single shell command for macOS. Output ONLY the command, nothing else: \(description)"
            let generated = self.runProviderSync(self.currentProvider, prompt: prompt)

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
            appendColored("  Type: fix — to get help from active provider\n\n", color: cGray)
            bubbleLabel.stringValue = speechBubble("Error detected! 🔴")
            setState(.error)
        } else if isCode {
            appendColored("📋 Code detected in clipboard! (\(content.count) chars)\n", color: cCyan, bold: true)
            appendColored("  Type: explain — to analyze with active provider\n\n", color: cGray)
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

    func exportSnippetsMarkdown() {
        guard !savedSnippets.isEmpty else {
            appendColored("❌ No snippets to export. Save with /save first.\n\n", color: cRed)
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        var markdown = "# Agent-O Snippets\n\n"
        markdown += "Exported: \(formatter.string(from: Date()))\n\n"
        for (index, snippet) in savedSnippets.enumerated() {
            markdown += "## \(index + 1). \(snippet.title)\n"
            markdown += "_Saved: \(formatter.string(from: snippet.date))_\n\n"
            markdown += "```text\n\(snippet.content)\n```\n\n"
        }

        let path = NSHomeDirectory() + "/Desktop/agento-snippets.md"
        do {
            try markdown.write(toFile: path, atomically: true, encoding: .utf8)
            appendColored("✅ Snippets exported\n", color: cGreen, bold: true)
            appendColored("  \(path)\n\n", color: cGray)
            bubbleLabel.stringValue = speechBubble("Snippets exported.")
            playSound("Pop")
        } catch {
            appendColored("❌ Export failed: \(error.localizedDescription)\n\n", color: cRed)
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
                    self.appendColored("⏳ → \(self.currentProvider.rawValue) (analyzing image)...\n", color: self.cDimGray)
                    let oldLevel = self.pet.level
                    self.pet.onCommandRun()
                    self.pet.save()
                    self.refreshStatsDisplay()
                    DispatchQueue.global(qos: .userInitiated).async {
                        self.runCLI(cli: self.currentProvider.rawValue, prompt: "Analyze this screenshot and describe what you see. If there's code, explain it. If there's an error, suggest a fix. Image: \(tmpPath)", oldLevel: oldLevel)
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
                self.appendColored("📝 Sending diff to \(self.currentProvider.label) for review...\n", color: self.cDimGray)
                let oldLevel = self.pet.level
                self.pet.onCommandRun()
                self.pet.save()
                self.refreshStatsDisplay()
                DispatchQueue.global(qos: .userInitiated).async {
                    self.runCLI(cli: self.currentProvider.rawValue, prompt: "Review this git diff. Point out potential bugs, suggest improvements, and highlight good changes. Be concise.\n\n\(truncated)", oldLevel: oldLevel)
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
                self.appendColored("⏳ → \(self.currentProvider.rawValue)...\n", color: self.cDimGray)
                let oldLevel = self.pet.level
                self.pet.onCommandRun()
                self.pet.save()
                self.refreshStatsDisplay()
                DispatchQueue.global(qos: .userInitiated).async {
                    self.runCLI(cli: self.currentProvider.rawValue, prompt: "Generate a concise git commit message (1-2 lines) for these staged changes. Just the message, no explanation.\n\n\(truncated)", oldLevel: oldLevel)
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
        appendColored("⏳ → \(currentProvider.rawValue)...\n", color: cDimGray)

        let oldLevel = pet.level
        pet.onCommandRun()
        pet.save()
        refreshStatsDisplay()

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: self?.currentProvider.rawValue ?? "claude", prompt: "Explain this file (\(fileName)). What does it do? Any issues?\n\n```\n\(truncated)\n```", oldLevel: oldLevel)
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
            self?.runCLI(cli: self?.currentProvider.rawValue ?? "claude", prompt: L10n.t("prompt_commit"))
        }
    }

    @objc func quickTest() {
        lastInteraction = Date()
        appendColored("❯ /test\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble(L10n.t("run_tests"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: self?.currentProvider.rawValue ?? "claude", prompt: L10n.t("prompt_test"))
        }
    }

    @objc func quickExplain() {
        lastInteraction = Date()
        appendColored("❯ /explain\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble(L10n.t("find_errors"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: self?.currentProvider.rawValue ?? "claude", prompt: L10n.t("prompt_explain"))
        }
    }

    @objc func quickReview() {
        lastInteraction = Date()
        appendColored("❯ /review\n", color: cCyan, bold: true)
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble(L10n.t("code_review"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.runCLI(cli: self?.currentProvider.rawValue ?? "claude", prompt: L10n.t("prompt_review"))
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

    // MARK: - AI Provider Routing

    func saveProviderPreferences() {
        UserDefaults.standard.set(currentProvider.rawValue, forKey: "agento_provider")
        UserDefaults.standard.set(providerModelOverrides, forKey: "agento_provider_models")
        UserDefaults.standard.set(providerEndpointOverrides, forKey: "agento_provider_endpoints")
    }

    func sourceLabel(_ source: String) -> String {
        if let provider = AIProvider(rawValue: source.lowercased()) {
            return provider.rawValue
        }
        return source.lowercased()
    }

    func sourceDisplayLabel(_ source: String) -> String {
        if let provider = AIProvider(rawValue: source.lowercased()) {
            return provider.label
        }
        return source
    }

    func currentModel(for provider: AIProvider) -> String {
        if let override = providerModelOverrides[provider.rawValue]?.trimmingCharacters(in: .whitespacesAndNewlines),
           !override.isEmpty {
            return override
        }
        let env = ProcessInfo.processInfo.environment
        switch provider {
        case .claude:
            return env["AGENTO_CLAUDE_MODEL"] ?? ""
        case .codex:
            return env["AGENTO_CODEX_MODEL"] ?? ""
        case .gpt:
            return env["AGENTO_OPENAI_MODEL"] ?? "gpt-4.1-mini"
        case .gemini:
            return env["AGENTO_GEMINI_MODEL"] ?? "gemini-2.0-flash"
        case .ollama:
            return env["AGENTO_OLLAMA_MODEL"] ?? "llama3.1"
        }
    }

    func currentEndpoint(for provider: AIProvider) -> String {
        if let override = providerEndpointOverrides[provider.rawValue]?.trimmingCharacters(in: .whitespacesAndNewlines),
           !override.isEmpty {
            return override
        }
        let env = ProcessInfo.processInfo.environment
        switch provider {
        case .gpt:
            return env["AGENTO_OPENAI_BASE_URL"] ?? "https://api.openai.com/v1"
        case .gemini:
            return env["AGENTO_GEMINI_BASE_URL"] ?? "https://generativelanguage.googleapis.com/v1beta"
        default:
            return ""
        }
    }

    func setProvider(_ provider: AIProvider) {
        currentProvider = provider
        saveProviderPreferences()
    }

    func setProviderModel(_ provider: AIProvider, model: String?) {
        let clean = model?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if clean.isEmpty {
            providerModelOverrides.removeValue(forKey: provider.rawValue)
        } else {
            providerModelOverrides[provider.rawValue] = clean
        }
        saveProviderPreferences()
    }

    func shellQuote(_ value: String) -> String {
        return "'" + value.replacingOccurrences(of: "'", with: "'\"'\"'") + "'"
    }

    func applyCommandTemplate(_ template: String, prompt: String, model: String) -> String {
        var cmd = template
        let promptArg = shellQuote(prompt)
        let modelArg = shellQuote(model)
        if cmd.contains("{prompt}") {
            cmd = cmd.replacingOccurrences(of: "{prompt}", with: promptArg)
        } else {
            cmd += " " + promptArg
        }
        if cmd.contains("{model}") {
            cmd = cmd.replacingOccurrences(of: "{model}", with: modelArg)
        }
        return cmd
    }

    func shellCommandForProvider(_ provider: AIProvider, prompt: String) -> String? {
        let model = currentModel(for: provider)
        let env = ProcessInfo.processInfo.environment
        switch provider {
        case .claude:
            return "claude -p \(shellQuote(prompt))"
        case .codex:
            if model.isEmpty {
                return "codex exec \(shellQuote(prompt))"
            }
            return "codex exec --model \(shellQuote(model)) \(shellQuote(prompt))"
        case .ollama:
            return "ollama run \(shellQuote(model)) \(shellQuote(prompt))"
        case .gpt:
            if let custom = env["AGENTO_GPT_COMMAND"], !custom.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return applyCommandTemplate(custom, prompt: prompt, model: model)
            }
            return nil
        case .gemini:
            if let custom = env["AGENTO_GEMINI_COMMAND"], !custom.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return applyCommandTemplate(custom, prompt: prompt, model: model)
            }
            return nil
        }
    }

    func runJSONRequest(url: URL, headers: [String: String], body: [String: Any], timeout: TimeInterval = 90) -> (status: Int, data: Data?, errorText: String?) {
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        guard let payload = try? JSONSerialization.data(withJSONObject: body) else {
            return (0, nil, "Failed to serialize request body")
        }
        request.httpBody = payload

        var status = 0
        var dataOut: Data?
        var errorText: String?
        let sem = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let http = response as? HTTPURLResponse {
                status = http.statusCode
            }
            dataOut = data
            if let error = error {
                errorText = error.localizedDescription
            }
            sem.signal()
        }.resume()
        _ = sem.wait(timeout: .now() + timeout + 5)
        return (status, dataOut, errorText)
    }

    func parseOpenAIOutput(_ json: [String: Any]) -> String {
        if let outputText = json["output_text"] as? String, !outputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return outputText
        }
        var chunks: [String] = []
        if let output = json["output"] as? [[String: Any]] {
            for item in output {
                if let content = item["content"] as? [[String: Any]] {
                    for part in content {
                        if let text = part["text"] as? String, !text.isEmpty {
                            chunks.append(text)
                        } else if let text = part["output_text"] as? String, !text.isEmpty {
                            chunks.append(text)
                        }
                    }
                }
            }
        }
        return chunks.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func parseGeminiOutput(_ json: [String: Any]) -> String {
        var chunks: [String] = []
        if let candidates = json["candidates"] as? [[String: Any]] {
            for candidate in candidates {
                if let content = candidate["content"] as? [String: Any],
                   let parts = content["parts"] as? [[String: Any]] {
                    for part in parts {
                        if let text = part["text"] as? String, !text.isEmpty {
                            chunks.append(text)
                        }
                    }
                }
            }
        }
        return chunks.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func runGPTViaAPI(prompt: String) -> (text: String?, error: String?) {
        let env = ProcessInfo.processInfo.environment
        guard let apiKey = env["OPENAI_API_KEY"], !apiKey.isEmpty else {
            return (nil, "OPENAI_API_KEY is missing. Set API key or AGENTO_GPT_COMMAND.")
        }
        let model = currentModel(for: .gpt)
        let rawEndpoint = currentEndpoint(for: .gpt).trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedEndpoint: String
        if rawEndpoint.lowercased().hasSuffix("/responses") {
            normalizedEndpoint = rawEndpoint
        } else {
            normalizedEndpoint = rawEndpoint.trimmingCharacters(in: CharacterSet(charactersIn: "/")) + "/responses"
        }
        guard let url = URL(string: normalizedEndpoint) else {
            return (nil, "Failed to build OpenAI URL")
        }
        let body: [String: Any] = [
            "model": model,
            "input": prompt
        ]
        let result = runJSONRequest(
            url: url,
            headers: ["Authorization": "Bearer \(apiKey)"],
            body: body
        )
        if let err = result.errorText, !err.isEmpty {
            return (nil, err)
        }
        guard let data = result.data else {
            return (nil, "OpenAI returned empty response")
        }
        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
            return (nil, "OpenAI returned invalid JSON")
        }
        if result.status >= 400 {
            let apiMessage = ((json["error"] as? [String: Any])?["message"] as? String) ?? "HTTP \(result.status)"
            return (nil, apiMessage)
        }
        let text = parseOpenAIOutput(json)
        if text.isEmpty {
            return (nil, "OpenAI returned no text output")
        }
        return (text, nil)
    }

    func runGeminiViaAPI(prompt: String) -> (text: String?, error: String?) {
        let env = ProcessInfo.processInfo.environment
        guard let apiKey = env["GEMINI_API_KEY"], !apiKey.isEmpty else {
            return (nil, "GEMINI_API_KEY is missing. Set API key or AGENTO_GEMINI_COMMAND.")
        }
        let model = currentModel(for: .gemini)
        let base = currentEndpoint(for: .gemini).trimmingCharacters(in: .whitespacesAndNewlines)
        var endpoint = base
        if endpoint.contains("{model}") {
            endpoint = endpoint.replacingOccurrences(of: "{model}", with: model)
        } else if !endpoint.contains(":generateContent") {
            endpoint = endpoint.trimmingCharacters(in: CharacterSet(charactersIn: "/")) + "/models/\(model):generateContent"
        }
        if !endpoint.contains("key=") {
            endpoint += endpoint.contains("?") ? "&key=\(apiKey)" : "?key=\(apiKey)"
        }
        guard let url = URL(string: endpoint) else {
            return (nil, "Failed to build Gemini URL")
        }
        let body: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": prompt]
                    ]
                ]
            ]
        ]
        let result = runJSONRequest(url: url, headers: [:], body: body)
        if let err = result.errorText, !err.isEmpty {
            return (nil, err)
        }
        guard let data = result.data else {
            return (nil, "Gemini returned empty response")
        }
        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
            return (nil, "Gemini returned invalid JSON")
        }
        if result.status >= 400 {
            let apiMessage = ((json["error"] as? [String: Any])?["message"] as? String) ?? "HTTP \(result.status)"
            return (nil, apiMessage)
        }
        let text = parseGeminiOutput(json)
        if text.isEmpty {
            return (nil, "Gemini returned no text output")
        }
        return (text, nil)
    }

    func runShellWithStatus(_ command: String) -> (status: Int, output: String, error: String?) {
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
            let output = String(data: data, encoding: .utf8) ?? ""
            return (Int(process.terminationStatus), output, nil)
        } catch {
            return (-1, "", error.localizedDescription)
        }
    }

    func runProviderSyncDetailed(_ provider: AIProvider, prompt: String, includeBrainContext: Bool = false) -> ProviderSyncResult {
        let started = Date()
        let rawContext = includeBrainContext ? brain.buildContext(level: pet.level) : nil
        let optimization = tokenOptimizer.optimize(prompt: prompt, brainContext: rawContext, cli: provider.rawValue)
        lastTokenOptimization = optimization
        let preparedPrompt = optimization.finalPrompt
        let model = currentModel(for: provider)

        if let cmd = shellCommandForProvider(provider, prompt: preparedPrompt) {
            let shellResult = runShellWithStatus(cmd)
            let output = shellResult.output.trimmingCharacters(in: .whitespacesAndNewlines)
            let duration = Int(Date().timeIntervalSince(started) * 1000)
            if let err = shellResult.error, !err.isEmpty {
                return ProviderSyncResult(
                    provider: provider,
                    output: "",
                    error: err,
                    inputChars: preparedPrompt.count,
                    outputChars: 0,
                    model: model,
                    durationMs: duration
                )
            }
            if shellResult.status != 0 && output.isEmpty {
                return ProviderSyncResult(
                    provider: provider,
                    output: "",
                    error: "Process failed (exit \(shellResult.status))",
                    inputChars: preparedPrompt.count,
                    outputChars: 0,
                    model: model,
                    durationMs: duration
                )
            }
            return ProviderSyncResult(
                provider: provider,
                output: output,
                error: nil,
                inputChars: preparedPrompt.count,
                outputChars: output.count,
                model: model,
                durationMs: duration
            )
        }

        let duration: () -> Int = { Int(Date().timeIntervalSince(started) * 1000) }
        switch provider {
        case .gpt:
            let result = runGPTViaAPI(prompt: preparedPrompt)
            if let text = result.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
                return ProviderSyncResult(
                    provider: provider,
                    output: text,
                    error: nil,
                    inputChars: preparedPrompt.count,
                    outputChars: text.count,
                    model: model,
                    durationMs: duration()
                )
            }
            return ProviderSyncResult(
                provider: provider,
                output: "",
                error: result.error ?? "GPT request failed",
                inputChars: preparedPrompt.count,
                outputChars: 0,
                model: model,
                durationMs: duration()
            )
        case .gemini:
            let result = runGeminiViaAPI(prompt: preparedPrompt)
            if let text = result.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
                return ProviderSyncResult(
                    provider: provider,
                    output: text,
                    error: nil,
                    inputChars: preparedPrompt.count,
                    outputChars: text.count,
                    model: model,
                    durationMs: duration()
                )
            }
            return ProviderSyncResult(
                provider: provider,
                output: "",
                error: result.error ?? "Gemini request failed",
                inputChars: preparedPrompt.count,
                outputChars: 0,
                model: model,
                durationMs: duration()
            )
        default:
            return ProviderSyncResult(
                provider: provider,
                output: "",
                error: "Provider \(provider.rawValue) is not configured",
                inputChars: preparedPrompt.count,
                outputChars: 0,
                model: model,
                durationMs: duration()
            )
        }
    }

    func runProviderSync(_ provider: AIProvider, prompt: String, includeBrainContext: Bool = false) -> String {
        let result = runProviderSyncDetailed(provider, prompt: prompt, includeBrainContext: includeBrainContext)
        return result.success ? result.output : ""
    }

    func showModelStatus() {
        appendColored("╭── Model Router ─────────────────────╮\n", color: cCyan)
        appendColored("  Active provider: \(currentProvider.label)\n", color: cGreen, bold: true)
        let model = currentModel(for: currentProvider)
        if model.isEmpty {
            appendColored("  Active model: default\n", color: cDimGray)
        } else {
            appendColored("  Active model: \(model)\n", color: cYellow)
        }
        appendColored("\n  Quick switch:\n", color: cPurple, bold: true)
        appendColored("  /model claude | /model codex | /model gpt | /model gemini | /model ollama\n", color: cGray)
        appendColored("  /models\n", color: cGray)
        appendColored("  /usage [days]\n", color: cGray)
        if currentProvider == .gpt || currentProvider == .gemini {
            let endpoint = currentEndpoint(for: currentProvider)
            appendColored("  Endpoint: \(endpoint)\n", color: cDimGray)
        }
        appendColored("╰─────────────────────────────────────╯\n\n", color: cCyan)
    }

    func showModelCatalog() {
        appendColored("🤖 Available providers\n", color: cCyan, bold: true)
        for provider in AIProvider.allCases {
            let marker = provider == currentProvider ? "◀ active" : ""
            let model = currentModel(for: provider)
            let modelText = model.isEmpty ? "default" : model
            appendColored("  \(provider.rawValue.padding(toLength: 8, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("→ \(provider.label)  model: \(modelText) \(marker)\n")
            if provider == .gpt || provider == .gemini {
                appendColored("           endpoint: \(currentEndpoint(for: provider))\n", color: cDimGray)
            }
        }
        appendColored("\n  Set provider: /model <provider>\n", color: cGray)
        appendColored("  Set model:    /model <provider> <model-id>\n", color: cGray)
        appendColored("  Clear model:  /model clear <provider>\n\n", color: cGray)
        appendColored("  Endpoint:     /model endpoint gpt|gemini <url>\n", color: cGray)
        appendColored("                /model endpoint clear gpt|gemini\n\n", color: cGray)
    }

    func showProviderUsage(days: Int) {
        let safeDays = max(1, days)
        let rows = promptJournal.entries(forLastDays: safeDays)
        if rows.isEmpty {
            appendColored("📊 No prompt usage in last \(safeDays) day(s)\n\n", color: cDimGray)
            return
        }

        var totalPrompts = 0
        var totalChars = 0
        var stats: [String: (count: Int, chars: Int)] = [:]
        for row in rows {
            let source = sourceLabel(row["source"] as? String ?? "unknown")
            let chars = row["chars"] as? Int ?? 0
            totalPrompts += 1
            totalChars += chars
            let prev = stats[source] ?? (0, 0)
            stats[source] = (prev.count + 1, prev.chars + chars)
        }

        appendColored("📊 Provider usage (\(safeDays)d)\n", color: cCyan, bold: true)
        let sorted = stats.sorted { a, b in
            if a.value.count == b.value.count { return a.key < b.key }
            return a.value.count > b.value.count
        }
        for (source, row) in sorted {
            let avg = row.count > 0 ? (row.chars / row.count) : 0
            let estUSD = costTracker.rows[source]?.usd ?? 0
            appendColored("  \(source.padding(toLength: 8, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput(String(format: "→ %@ | prompts %d, chars %d, avg %d, est:$%.5f\n",
                                sourceDisplayLabel(source), row.count, row.chars, avg, estUSD))
        }
        appendColored("  total    ", color: cGreen, bold: true)
        appendOutput("→ prompts \(totalPrompts), chars \(totalChars)\n\n")
    }

    func topPersonalityCategories(limit: Int = 3) -> [(String, Int)] {
        return personality.categoryCounts
            .sorted { a, b in
                if a.value == b.value { return a.key < b.key }
                return a.value > b.value
            }
            .prefix(limit)
            .map { ($0.key, $0.value) }
    }

    func showPersonalityStatus() {
        let mode = personality.manualTypeKey == nil ? "Auto" : "Manual"
        let type = personality.currentType
        appendColored("╭── Personality ──────────────────────╮\n", color: cCyan)
        appendColored("  Current: \(type.label)\n", color: cGreen, bold: true)
        appendColored("  Mode: \(mode)\n", color: cGray)
        appendColored("  Runs: \(personality.runCount) (ok \(personality.successfulRuns) / err \(personality.failedRuns))\n", color: cGray)
        appendColored(String(format: "  Error rate: %.1f%%\n", personality.errorRate * 100.0), color: cGray)
        appendColored("  Prompt runs: \(personality.promptRuns)\n", color: cGray)
        appendColored("  Focus actions: \(personality.focusActions)\n", color: cGray)
        appendColored("  Social actions: \(personality.socialActions)\n", color: cGray)
        appendColored("  Fast bursts: \(personality.fastBurstCount)\n", color: cGray)
        appendColored("  Active coding time: \(personality.activeTimeBucketLabel())\n", color: cGray)
        appendColored("  Memory file: ~/.agento_memory.json\n", color: cDimGray)

        let topCats = topPersonalityCategories()
        if !topCats.isEmpty {
            let row = topCats.map { "\($0.0)(\($0.1))" }.joined(separator: ", ")
            appendColored("  Top categories: \(row)\n", color: cDimGray)
        }
        let topLanguages = personality.topLanguages()
        if !topLanguages.isEmpty {
            let row = topLanguages.map { "\($0.0)(\($0.1))" }.joined(separator: ", ")
            appendColored("  Top languages: \(row)\n", color: cDimGray)
        }

        appendColored("\n  Commands:\n", color: cPurple, bold: true)
        appendColored("  /personality set helpful|sarcastic|zen|hyper\n", color: cYellow)
        appendColored("  /personality auto\n", color: cYellow)
        appendColored("  /personality suggest\n", color: cYellow)
        appendColored("  /personality reset\n", color: cYellow)
        appendColored("╰─────────────────────────────────────╯\n\n", color: cCyan)
    }

    func handlePersonalityCommand(args: String) {
        let value = args.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if value.isEmpty || value == "status" {
            showPersonalityStatus()
            return
        }
        if value == "suggest" {
            showProactiveSuggestion()
            return
        }
        if value == "auto" {
            personality.setManualType(nil)
            appendColored("✅ Personality mode: auto\n", color: cGreen, bold: true)
            appendColored("  Current: \(personality.currentType.label)\n\n", color: cGray)
            return
        }
        if value == "reset" {
            personality = PersonalityProfile()
            personality.save()
            appendColored("✅ Personality profile reset\n\n", color: cGreen, bold: true)
            return
        }
        if value.hasPrefix("set ") {
            let key = String(value.dropFirst(4)).trimmingCharacters(in: .whitespacesAndNewlines)
            guard let type = PersonalityType(rawValue: key) else {
                appendColored("❌ Unknown personality type: \(key)\n", color: cRed)
                appendColored("  Use: helpful | sarcastic | zen | hyper\n\n", color: cGray)
                return
            }
            personality.setManualType(type)
            appendColored("✅ Personality set: \(type.label)\n\n", color: cGreen, bold: true)
            return
        }
        appendColored("❌ Usage: /personality [status|set <type>|auto|suggest|reset]\n\n", color: cRed)
    }

    func gitSuggestionSnapshot() -> (repo: String, branch: String, changed: Int, staged: Int, unstaged: Int)? {
        let cwd = FileManager.default.currentDirectoryPath
        let quoted = shellQuote(cwd)
        let inside = shell("git -C \(quoted) rev-parse --is-inside-work-tree 2>/dev/null")?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard inside == "true" else { return nil }

        let branch = shell("git -C \(quoted) branch --show-current 2>/dev/null")?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? "unknown"
        let porcelain = shell("git -C \(quoted) status --porcelain 2>/dev/null") ?? ""
        let repo = URL(fileURLWithPath: cwd).lastPathComponent
        let lines = porcelain
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

        var staged = 0
        var unstaged = 0
        for line in lines {
            if line.hasPrefix("??") {
                unstaged += 1
                continue
            }
            if line.count >= 2 {
                let chars = Array(line)
                if chars[0] != " " { staged += 1 }
                if chars[1] != " " { unstaged += 1 }
            }
        }
        return (repo, branch, lines.count, staged, unstaged)
    }

    func bestSuggestionLine() -> String? {
        var candidates: [(Int, String)] = []

        if !pet.hasCompletedOnboarding {
            candidates.append((100, "Finish onboarding to unlock full pet progression."))
        }
        if playerUsername.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            candidates.append((98, "Set your public name: /name YourName"))
        } else if playerAuthToken.isEmpty {
            candidates.append((94, "Publish once to bind owner token: /leaderboard"))
        }
        if pet.energy < 25 {
            candidates.append((93, "Energy is low. Run /rest before next coding sprint."))
        }
        if pet.hunger < 25 {
            candidates.append((92, "Pet is hungry. Run /feed to recover mood and stability."))
        }
        if pet.happiness < 25 {
            candidates.append((90, "Pet mood is low. Run /play for a quick morale boost."))
        }
        let commitRuns = personality.commandCounts["/commit"] ?? 0
        let testRuns = personality.commandCounts["/test"] ?? 0
        if commitRuns >= 2 && testRuns + 1 < commitRuns {
            candidates.append((89, "You often commit without tests. Run /test before the next /commit."))
        }

        let activeBucket = personality.activeTimeBucketLabel()
        if (activeBucket == "night" || activeBucket == "evening") && pet.energy < 45 {
            candidates.append((84, "Late-session fatigue detected. Use /pomo10 or /rest to avoid sloppy mistakes."))
        }

        let commitSignals = (personality.categoryCounts["tools"] ?? 0) + pet.totalCommits
        let focusSignals = personality.focusActions
        if commitSignals >= 6 && focusSignals < 3 {
            candidates.append((83, "High dev activity detected. Try /pomo for focused execution."))
        }
        if commitSignals >= 5 && (personality.categoryCounts["prompt"] ?? 0) > 10 {
            candidates.append((80, "Before next commit, run /test for a fast safety check."))
        }
        if !isWatchingClipboard && pet.totalCommands >= 15 {
            candidates.append((72, "Enable clipboard assistant with /watch for auto code/error hints."))
        }

        if let git = gitSuggestionSnapshot() {
            if git.changed > 0 {
                if git.staged == 0 {
                    candidates.append((86, "Git \(git.repo)/\(git.branch): \(git.changed) changed files. Stage + run /commit."))
                } else {
                    candidates.append((88, "Git \(git.repo)/\(git.branch): \(git.staged) staged changes. Generate message: /commit."))
                }
            } else {
                candidates.append((48, "Git tree is clean on \(git.repo)/\(git.branch). Good moment for /battle or /training."))
            }
        }

        if candidates.isEmpty {
            return nil
        }
        let best = candidates.sorted { a, b in
            if a.0 == b.0 { return a.1 < b.1 }
            return a.0 > b.0
        }.first
        return best?.1
    }

    func showProactiveSuggestion() {
        if let line = bestSuggestionLine() {
            appendColored("💡 Suggestion: \(line)\n\n", color: cYellow, bold: true)
            bubbleLabel.stringValue = speechBubble(line)
            playSound("Pop")
        } else {
            appendColored("💡 No strong suggestion right now. Keep coding.\n\n", color: cDimGray)
        }
    }

    func parseCompareProviders(token: String) -> [AIProvider] {
        let parts = token
            .split(separator: ",")
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
            .filter { !$0.isEmpty }
        var parsed: [AIProvider] = []
        for key in parts {
            if let provider = AIProvider(rawValue: key), !parsed.contains(provider) {
                parsed.append(provider)
            }
        }
        return parsed
    }

    func defaultCompareProviders() -> [AIProvider] {
        var ordered: [AIProvider] = [currentProvider]
        for provider in AIProvider.allCases where !ordered.contains(provider) {
            ordered.append(provider)
        }
        return ordered
    }

    func compareProviders(args: String) {
        let trimmed = args.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            appendColored("❌ Usage: /compare <prompt>\n", color: cRed)
            appendColored("  Optional: /compare claude,codex <prompt>\n\n", color: cGray)
            return
        }

        var providers = defaultCompareProviders()
        var comparePrompt = trimmed
        let parts = trimmed.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        if parts.count == 2 {
            let selected = parseCompareProviders(token: String(parts[0]))
            if !selected.isEmpty {
                providers = selected
                comparePrompt = String(parts[1]).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        guard !comparePrompt.isEmpty else {
            appendColored("❌ Missing compare prompt\n\n", color: cRed)
            return
        }

        let oldLevel = pet.level
        pet.onCommandRun()
        pet.save()
        refreshStatsDisplay()

        appendColored("🧪 Provider compare started\n", color: cCyan, bold: true)
        appendColored("  Providers: \(providers.map { $0.rawValue }.joined(separator: ", "))\n", color: cGray)
        appendColored("  Prompt: \(String(comparePrompt.prefix(120)))\(comparePrompt.count > 120 ? "..." : "")\n\n", color: cDimGray)
        bubbleLabel.stringValue = speechBubble("Comparing providers...")
        setState(.thinking)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.brain.learn(from: comparePrompt)
            var results: [ProviderSyncResult] = []
            for provider in providers {
                self.promptJournal.record(source: provider.rawValue, prompt: comparePrompt)
                let result = self.runProviderSyncDetailed(provider, prompt: comparePrompt, includeBrainContext: true)
                if result.success {
                    self.costTracker.record(
                        provider: provider.rawValue,
                        inputChars: result.inputChars,
                        outputChars: result.outputChars
                    )
                }
                results.append(result)
            }

            DispatchQueue.main.async {
                let successful = results.filter { $0.success }
                if successful.isEmpty {
                    self.appendColored("❌ Compare failed: no provider produced output.\n\n", color: self.cRed)
                    self.setState(.error, duration: 3)
                    self.playSound("Basso")
                    return
                }

                self.appendColored("╭── Compare Results ──────────────────╮\n", color: self.cCyan)
                for result in results {
                    let statusIcon = result.success ? "✅" : "❌"
                    let color = result.success ? self.cGreen : self.cRed
                    self.appendColored("  \(statusIcon) \(result.provider.rawValue.uppercased())", color: color, bold: true)
                    self.appendOutput("  \(result.durationMs)ms")
                    if !result.model.isEmpty {
                        self.appendOutput("  model: \(result.model)")
                    }
                    let runCost = self.costTracker.estimateUSD(
                        provider: result.provider.rawValue,
                        inputChars: result.inputChars,
                        outputChars: result.outputChars
                    )
                    self.appendOutput(String(format: "  est:$%.5f\n", runCost))

                    if result.success {
                        let preview = String(result.output.prefix(280)).replacingOccurrences(of: "\n", with: " ")
                        self.appendColored("     \(preview)\(result.output.count > 280 ? "..." : "")\n", color: self.cGray)
                    } else {
                        self.appendColored("     \(result.error ?? "no output")\n", color: self.cDimGray)
                    }
                }

                if let fastest = successful.min(by: { $0.durationMs < $1.durationMs }) {
                    self.appendColored("  Fastest: \(fastest.provider.rawValue) (\(fastest.durationMs)ms)\n", color: self.cYellow, bold: true)
                }
                if let richest = successful.max(by: { $0.outputChars < $1.outputChars }) {
                    self.appendColored("  Longest output: \(richest.provider.rawValue) (\(richest.outputChars) chars)\n", color: self.cYellow)
                }
                let totalCompareCost = successful.reduce(0.0) { sum, row in
                    sum + self.costTracker.estimateUSD(
                        provider: row.provider.rawValue,
                        inputChars: row.inputChars,
                        outputChars: row.outputChars
                    )
                }
                self.appendColored(String(format: "  Compare est. cost: $%.5f\n", totalCompareCost), color: self.cOrange)
                self.appendColored("╰─────────────────────────────────────╯\n\n", color: self.cCyan)

                self.checkLevelUp(oldLevel: oldLevel)
                self.setState(.happy, duration: 3)
                self.bubbleLabel.stringValue = speechBubble("Compare done")
                self.playSound("Glass")
            }
        }
    }

    func showCostRates() {
        appendColored("💲 Cost rates (USD per 1M tokens)\n", color: cCyan, bold: true)
        for provider in AIProvider.allCases {
            let rates = costTracker.rates(provider: provider.rawValue)
            appendColored("  \(provider.rawValue.padding(toLength: 8, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput(String(format: "→ in %.3f | out %.3f\n", rates.inputPerM, rates.outputPerM))
        }
        appendColored("\n  Override:\n", color: cPurple, bold: true)
        appendColored("  /cost set <provider> <in_per_m> <out_per_m>\n", color: cGray)
        appendColored("  /cost clear <provider>\n", color: cGray)
        appendColored("  /cost reset\n\n", color: cGray)
    }

    func showCostSummary() {
        let totalRequests = costTracker.totalRequests()
        if totalRequests == 0 {
            appendColored("💲 No cost data yet. Run prompts first.\n", color: cDimGray)
            appendColored("  Commands: /cost rates, /cost set ..., /cost reset\n\n", color: cGray)
            return
        }

        appendColored("╭── Cost Tracker ─────────────────────╮\n", color: cCyan)
        appendColored("  Estimated tokens use chars/4 heuristic.\n", color: cDimGray)
        appendColored("  Total requests: \(totalRequests)\n", color: cGreen, bold: true)
        appendColored(String(format: "  Estimated total: $%.5f\n", costTracker.totalUSD()), color: cOrange, bold: true)

        let sorted = costTracker.rows.sorted { a, b in
            if a.value.usd == b.value.usd { return a.key < b.key }
            return a.value.usd > b.value.usd
        }
        for (provider, row) in sorted where row.requests > 0 {
            appendColored("  \(provider.padding(toLength: 8, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput(String(format: "→ req:%d inTok:%d outTok:%d est:$%.5f\n",
                               row.requests, row.inputTokens, row.outputTokens, row.usd))
        }
        appendColored("\n  /cost rates  /cost set ...  /cost clear ...  /cost reset\n", color: cGray)
        appendColored("╰─────────────────────────────────────╯\n\n", color: cCyan)
    }

    func handleCostCommand(args: String) {
        let value = args.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if value.isEmpty || value == "status" {
            showCostSummary()
            return
        }
        if value == "rates" {
            showCostRates()
            return
        }
        if value == "reset" {
            costTracker.reset()
            appendColored("✅ Cost tracker reset\n\n", color: cGreen, bold: true)
            return
        }
        if value.hasPrefix("clear ") {
            let provider = String(value.dropFirst(6)).trimmingCharacters(in: .whitespacesAndNewlines)
            guard AIProvider(rawValue: provider) != nil else {
                appendColored("❌ Unknown provider for /cost clear\n\n", color: cRed)
                return
            }
            costTracker.clearRates(provider: provider)
            appendColored("✅ Cleared custom rate for \(provider)\n\n", color: cGreen)
            return
        }
        if value.hasPrefix("set ") {
            let raw = String(value.dropFirst(4))
            let parts = raw.split(separator: " ", omittingEmptySubsequences: true).map(String.init)
            guard parts.count == 3, AIProvider(rawValue: parts[0]) != nil,
                  let inPerM = Double(parts[1]),
                  let outPerM = Double(parts[2]) else {
                appendColored("❌ Usage: /cost set <provider> <in_per_m> <out_per_m>\n\n", color: cRed)
                return
            }
            costTracker.setRates(provider: parts[0], inputPerM: inPerM, outputPerM: outPerM)
            appendColored(
                "✅ Cost rates for \(parts[0]) set (in \(String(format: "%.3f", inPerM)) / out \(String(format: "%.3f", outPerM)))\n\n",
                color: cGreen
            )
            return
        }
        appendColored("❌ Usage: /cost [status|rates|set|clear|reset]\n\n", color: cRed)
    }

    func handleModelCommand(args: String) {
        let value = args.trimmingCharacters(in: .whitespacesAndNewlines)
        if value.isEmpty || value == "status" {
            showModelStatus()
            return
        }
        if value == "list" || value == "ls" || value == "models" {
            showModelCatalog()
            return
        }

        if value.hasPrefix("endpoint ") {
            let endpointArgs = String(value.dropFirst(9)).trimmingCharacters(in: .whitespacesAndNewlines)
            handleModelEndpointCommand(args: endpointArgs)
            return
        }

        if value.hasPrefix("clear ") {
            let key = String(value.dropFirst(6)).trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            guard let provider = AIProvider(rawValue: key) else {
                appendColored("❌ Unknown provider: \(key)\n\n", color: cRed)
                return
            }
            setProviderModel(provider, model: nil)
            appendColored("✅ Cleared model override for \(provider.rawValue)\n\n", color: cGreen)
            return
        }

        let parts = value.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        guard let providerKey = parts.first else {
            showModelStatus()
            return
        }
        guard let provider = AIProvider(rawValue: String(providerKey).lowercased()) else {
            appendColored("❌ Unknown provider: \(providerKey)\n", color: cRed)
            appendColored("  Use: claude | codex | gpt | gemini | ollama\n\n", color: cGray)
            return
        }

        if parts.count == 1 {
            setProvider(provider)
            appendColored("✅ Active provider: \(provider.label)\n\n", color: cGreen, bold: true)
            return
        }

        let model = String(parts[1]).trimmingCharacters(in: .whitespacesAndNewlines)
        if model.isEmpty {
            appendColored("❌ Usage: /model \(provider.rawValue) <model-id>\n\n", color: cRed)
            return
        }
        setProvider(provider)
        setProviderModel(provider, model: model)
        appendColored("✅ Active provider: \(provider.label)\n", color: cGreen, bold: true)
        appendColored("✅ Model for \(provider.rawValue): \(model)\n\n", color: cGreen)
    }

    func handleModelEndpointCommand(args: String) {
        let value = args.trimmingCharacters(in: .whitespacesAndNewlines)
        if value.isEmpty {
            appendColored("Usage:\n", color: cRed)
            appendColored("  /model endpoint gpt <url>\n", color: cGray)
            appendColored("  /model endpoint gemini <url>\n", color: cGray)
            appendColored("  /model endpoint clear gpt|gemini\n\n", color: cGray)
            return
        }

        if value.hasPrefix("clear ") {
            let key = String(value.dropFirst(6)).trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            guard key == "gpt" || key == "gemini" else {
                appendColored("❌ Endpoint clear supports only gpt|gemini\n\n", color: cRed)
                return
            }
            providerEndpointOverrides.removeValue(forKey: key)
            saveProviderPreferences()
            appendColored("✅ Cleared custom endpoint for \(key)\n\n", color: cGreen)
            return
        }

        let parts = value.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        guard parts.count == 2 else {
            appendColored("❌ Usage: /model endpoint gpt|gemini <url>\n\n", color: cRed)
            return
        }
        let providerKey = String(parts[0]).lowercased()
        guard providerKey == "gpt" || providerKey == "gemini" else {
            appendColored("❌ Endpoint set supports only gpt|gemini\n\n", color: cRed)
            return
        }
        let endpoint = String(parts[1]).trimmingCharacters(in: .whitespacesAndNewlines)
        guard endpoint.hasPrefix("http://") || endpoint.hasPrefix("https://") else {
            appendColored("❌ Endpoint must start with http:// or https://\n\n", color: cRed)
            return
        }

        providerEndpointOverrides[providerKey] = endpoint
        saveProviderPreferences()
        appendColored("✅ Custom endpoint set for \(providerKey)\n", color: cGreen, bold: true)
        appendColored("  \(endpoint)\n\n", color: cGray)
    }

    // MARK: - Run CLI

    func runCLI(cli: String, prompt: String, oldLevel: Int = 0) {
        let provider = AIProvider(rawValue: cli.lowercased()) ?? .claude

        brain.learn(from: prompt)
        promptJournal.record(source: provider.rawValue, prompt: prompt)

        let rawContext = brain.buildContext(level: pet.level)
        let optimization = tokenOptimizer.optimize(prompt: prompt, brainContext: rawContext, cli: provider.rawValue)
        lastTokenOptimization = optimization
        let enhancedPrompt = optimization.finalPrompt
        let billedInputChars = enhancedPrompt.count
        if tokenOptimizer.isEnabled && optimization.savedChars > 0 {
            appendColored(
                "🧮 Optimizer \(optimization.mode.rawValue): \(optimization.originalChars) -> \(optimization.optimizedChars) chars (\(optimization.savedPercent)% saved)\n",
                color: cDimGray
            )
        }

        let finalize: (_ success: Bool, _ output: String, _ errorMessage: String?) -> Void = { [weak self] success, output, errorMessage in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.lastResponse = output
                self.personality.recordRun(provider: provider.rawValue, success: success)
                if !output.isEmpty {
                    self.appendOutput(output)
                }
                self.appendOutput("\n")
                if success {
                    self.costTracker.record(
                        provider: provider.rawValue,
                        inputChars: billedInputChars,
                        outputChars: output.count
                    )
                    self.pet.onCommandSuccess()
                    self.pet.save()
                    self.refreshStatsDisplay()
                    self.checkLevelUp(oldLevel: oldLevel)
                    self.setState(.happy, duration: 3)
                    self.bubbleLabel.stringValue = speechBubble(self.personality.successLine())
                    self.playSound("Glass")
                } else {
                    if let errorMessage = errorMessage, !errorMessage.isEmpty {
                        self.appendColored("❌ \(errorMessage)\n\n", color: self.cRed)
                    }
                    self.setState(.error, duration: 3)
                    self.bubbleLabel.stringValue = speechBubble(self.personality.errorLine())
                    self.playSound("Basso")
                }
                self.refreshGitStatus()
            }
        }

        if let shellCommand = shellCommandForProvider(provider, prompt: enhancedPrompt) {
            let process = Process()
            let pipe = Pipe()
            process.executableURL = URL(fileURLWithPath: "/bin/zsh")
            process.arguments = ["-l", "-c", shellCommand]
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
                finalize(false, "", "\(L10n.t("error_launch")) \(provider.rawValue): \(error.localizedDescription)")
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
            finalize(process.terminationStatus == 0, accumulatedOutput, nil)
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.setState(.typing)
        }

        switch provider {
        case .gpt:
            let result = runGPTViaAPI(prompt: enhancedPrompt)
            if let output = result.text {
                finalize(true, output, nil)
            } else {
                finalize(false, "", result.error ?? "GPT request failed")
            }
        case .gemini:
            let result = runGeminiViaAPI(prompt: enhancedPrompt)
            if let output = result.text {
                finalize(true, output, nil)
            } else {
                finalize(false, "", result.error ?? "Gemini request failed")
            }
        default:
            finalize(false, "", "Provider \(provider.rawValue) is not configured")
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
        appendColored("║   Multi-Model Assistant + Tamagotchi  ║\n", color: cCyan)
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
        appendOutput("quick help  ")
        appendColored("/help all ", color: cGreen, bold: true)
        appendOutput("command map  ")
        appendColored("/help all commands ", color: cGreen, bold: true)
        appendOutput("full list  ")
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

            // Detect source language for MyMemory API
            let sourceLang = self.detectSourceLang(text, target: targetLang)
            let langPair = "\(sourceLang)|\(targetLang)"
            var components = URLComponents(string: "https://api.mymemory.translated.net/get")!
            components.queryItems = [
                URLQueryItem(name: "q", value: text),
                URLQueryItem(name: "langpair", value: langPair),
            ]
            guard let url = components.url else {
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

                    // Parse MyMemory JSON: {"responseData":{"translatedText":"..."},...}
                    var translated = ""
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let responseData = json["responseData"] as? [String: Any],
                       let text = responseData["translatedText"] as? String {
                        translated = text
                    }
                    if !translated.isEmpty && translated.uppercased() != text.uppercased() {
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
                    } else {
                        let preview = String(data: data.prefix(300), encoding: .utf8) ?? "binary"
                        self.appendColored("❌ Could not parse translation\n", color: self.cRed)
                        self.appendColored("  Response: \(preview)\n\n", color: self.cDimGray)
                        self.setState(.error)
                    }
                }
            }
            task.resume()
        }
    }

    func detectSourceLang(_ text: String, target: String) -> String {
        // Simple heuristic: if target is "en" and text has Cyrillic → "ru"
        // If target is "ru" and text is Latin → "en"
        let hasCyrillic = text.unicodeScalars.contains { $0.value >= 0x0400 && $0.value <= 0x04FF }
        let hasLatin = text.unicodeScalars.contains { ($0.value >= 0x0041 && $0.value <= 0x005A) || ($0.value >= 0x0061 && $0.value <= 0x007A) }
        let hasCJK = text.unicodeScalars.contains { $0.value >= 0x4E00 && $0.value <= 0x9FFF }

        if target == "en" {
            if hasCyrillic { return "ru" }
            if hasCJK { return "zh" }
            return "auto"
        }
        if target == "ru" {
            if hasLatin { return "en" }
            return "auto"
        }
        if hasCyrillic { return "ru" }
        if hasLatin { return "en" }
        return "auto"
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
        appendColored("⏳ → \(currentProvider.rawValue)...\n", color: cDimGray)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let prompt = "Generate a regex pattern for: \(description). Output format:\nPattern: <regex>\nExample matches: <3 examples>\nExplanation: <brief>"
            let result = self.runProviderSync(self.currentProvider, prompt: prompt)

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
            appendColored("  Use any provider in Agent-O, then run /promptstats again.\n\n", color: cGray)
            return
        }

        var totalChars = 0
        var totalWords = 0
        var sourceCounts: [String: Int] = [:]
        var contextCount = 0
        var formatCount = 0
        var intentCounts: [String: Int] = [:]
        var longest: (chars: Int, source: String, text: String)? = nil

        for entry in entries {
            let chars = entry["chars"] as? Int ?? 0
            let words = entry["words"] as? Int ?? 0
            let source = sourceLabel(entry["source"] as? String ?? "unknown")
            let text = entry["text"] as? String ?? ""

            totalChars += chars
            totalWords += words
            sourceCounts[source, default: 0] += 1
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
        let providerBreakdown = sourceCounts
            .sorted { a, b in
                if a.value == b.value { return a.key < b.key }
                return a.value > b.value
            }
            .map { "\($0.key):\($0.value)" }
            .joined(separator: "  ")
        appendColored("  Providers: ", color: cGray)
        appendColored("\(providerBreakdown)\n", color: cYellow, bold: true)
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
            appendColored("  Longest prompt (\(sourceDisplayLabel(longest.source))): ", color: cGray)
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
            appendColored("  Run prompts with any provider first, then /promptcoach.\n\n", color: cGray)
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

    func showTrainingDashboard(days: Int = 7) {
        let safeDays = max(1, min(30, days))
        let entries = promptJournal.entries(forLastDays: safeDays)
        let promptCount = entries.count
        let contextCount = entries.filter { promptHasContext($0["text"] as? String ?? "") }.count
        let formatCount = entries.filter { promptHasOutputFormat($0["text"] as? String ?? "") }.count
        let contextPct = promptCount > 0 ? (contextCount * 100 / promptCount) : 0
        let formatPct = promptCount > 0 ? (formatCount * 100 / promptCount) : 0

        let topPatterns = brain.patterns
            .sorted { a, b in
                if a.value == b.value { return a.key < b.key }
                return a.value > b.value
            }
            .prefix(3)

        let activityScore = min(40, promptCount * 2)
        let memoryScore = min(35, brain.facts.count * 5 + brain.languages.count * 3 + brain.frameworks.count * 3)
        let qualityScore = min(25, (contextPct + formatPct) / 8)
        let trainScore = min(100, activityScore + memoryScore + qualityScore)
        let topSpecialties = brain.topSpecialties(limit: 3)
        let topLine = topSpecialties.map { "\($0.label)(\($0.score))" }.joined(separator: ", ")
        let modeText = brain.manualSpecialtyKey == nil ? "Auto" : "Manual"

        appendColored("╭── Pet Training ─────────────────────╮\n", color: cCyan)
        appendColored("  Level: ", color: cGray)
        appendColored("\(pet.level)\n", color: cGreen, bold: true)
        appendColored("  Training score: ", color: cGray)
        appendColored("\(trainScore)/100\n", color: cYellow, bold: true)
        appendColored("  Prompt window: last \(safeDays) day(s)\n", color: cGray)
        appendColored("  Prompts analyzed: \(promptCount)\n", color: cGray)
        appendColored("  Context quality: \(contextPct)%\n", color: cGray)
        appendColored("  Output clarity: \(formatPct)%\n", color: cGray)
        appendColored("  Known languages: \(brain.languages.count)\n", color: cGray)
        appendColored("  Known frameworks: \(brain.frameworks.count)\n", color: cGray)
        appendColored("  Learned facts: \(brain.facts.count)\n", color: cGray)
        appendColored("  Specialist mode: \(modeText)\n", color: cGray)
        appendColored("  Active specialist: \(brain.currentSpecialtyLabel())\n", color: cYellow)
        appendColored("  Top specialties: \(topLine)\n", color: cDimGray)
        appendColored("  Token optimizer: \(tokenOptimizer.mode.rawValue.uppercased())\n", color: cGray)
        appendColored("  Token savings: \(tokenOptimizer.totalSavedPercent)% (\(tokenOptimizer.totalSavedChars) chars)\n", color: cDimGray)

        if topPatterns.isEmpty {
            appendColored("  Top prompt patterns: (not enough data yet)\n", color: cDimGray)
        } else {
            appendColored("  Top prompt patterns:\n", color: cPurple, bold: true)
            for (pattern, count) in topPatterns {
                appendColored("    • \(pattern)  (\(count)x)\n", color: cDimGray)
            }
        }

        appendColored("\n  Improve faster:\n", color: cPurple, bold: true)
        appendColored("    1) Use /promptcoach for wording feedback\n", color: cDimGray)
        appendColored("    2) Use /train <fact> for persistent preferences\n", color: cDimGray)
        appendColored("    3) Add file/error context in each complex prompt\n", color: cDimGray)
        appendColored("╰────────────────────────────────────╯\n\n", color: cCyan)
    }

    func showSpecialistCatalog() {
        appendColored("╭── Specialist Catalog ───────────────╮\n", color: cPurple)
        for row in PetBrain.specialtyList() {
            appendColored("  \(row.key.padding(toLength: 18, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("→ \(row.label)\n")
        }
        appendColored("\n  Commands:\n", color: cCyan, bold: true)
        appendColored("  /specialist\n", color: cYellow)
        appendColored("    show current specialist + signals\n", color: cGray)
        appendColored("  /specialist set <key>\n", color: cYellow)
        appendColored("    force manual specialist by key\n", color: cGray)
        appendColored("  /specialist auto\n", color: cYellow)
        appendColored("    return to auto mode from learned prompts\n", color: cGray)
        appendColored("╰────────────────────────────────────╯\n\n", color: cPurple)
    }

    func showSpecialistStatus() {
        let top = brain.topSpecialties(limit: 5)
        let modeLabel = brain.manualSpecialtyKey == nil ? "Auto" : "Manual"

        appendColored("╭── Pet Specialist ───────────────────╮\n", color: cCyan)
        appendColored("  Mode: \(modeLabel)\n", color: cGray)
        appendColored("  Active: \(brain.currentSpecialtyLabel())\n", color: cGreen, bold: true)
        if let manualKey = brain.manualSpecialtyKey {
            appendColored("  Manual key: \(manualKey)\n", color: cDimGray)
        } else {
            appendColored("  Manual key: (none)\n", color: cDimGray)
        }
        appendColored("\n  Signals:\n", color: cPurple, bold: true)
        for row in top {
            appendColored("    \(row.label.padding(toLength: 24, withPad: " ", startingAt: 0))", color: cGray)
            appendColored("\(row.score)\n", color: cYellow)
        }
        appendColored("\n  Use /specialist list for all keys\n", color: cDimGray)
        appendColored("  Use /specialist set <key> to lock specialist\n", color: cDimGray)
        appendColored("  Use /specialist auto to unlock auto-learning\n", color: cDimGray)
        appendColored("╰────────────────────────────────────╯\n\n", color: cCyan)
    }

    func handleSpecialistCommand(args: String) {
        let trimmed = args.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty || trimmed.lowercased() == "status" {
            showSpecialistStatus()
            return
        }

        let lower = trimmed.lowercased()
        if lower == "help" || lower == "list" {
            showSpecialistCatalog()
            return
        }
        if lower == "auto" || lower == "reset" || lower == "set auto" {
            brain.setManualSpecialty(nil)
            appendColored("✅ Specialist mode set to auto-learning\n", color: cGreen, bold: true)
            appendColored("  Active now: \(brain.currentSpecialtyLabel())\n\n", color: cGray)
            return
        }
        if lower.hasPrefix("set ") {
            let rawKey = String(trimmed.dropFirst(4))
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()
                .replacingOccurrences(of: "-", with: "_")
                .replacingOccurrences(of: " ", with: "_")
            if PetBrain.isValidSpecialtyKey(rawKey) {
                brain.setManualSpecialty(rawKey)
                appendColored("✅ Specialist locked: \(PetBrain.specialtyLabel(for: rawKey))\n", color: cGreen, bold: true)
                appendColored("  Key: \(rawKey)\n\n", color: cGray)
            } else {
                appendColored("❌ Unknown specialist key: \(rawKey)\n", color: cRed)
                showSpecialistCatalog()
            }
            return
        }

        let fallbackKey = lower
            .replacingOccurrences(of: "-", with: "_")
            .replacingOccurrences(of: " ", with: "_")
        if PetBrain.isValidSpecialtyKey(fallbackKey) {
            brain.setManualSpecialty(fallbackKey)
            appendColored("✅ Specialist locked: \(PetBrain.specialtyLabel(for: fallbackKey))\n\n", color: cGreen, bold: true)
            return
        }

        appendColored("❌ Usage: /specialist [status|list|auto|set <key>]\n", color: cRed)
        appendColored("  Example: /specialist set stake_game_dev\n\n", color: cGray)
    }

    func showTokenOptimizerStatus() {
        let modeLabel: String
        switch tokenOptimizer.mode {
        case .off: modeLabel = "OFF"
        case .balanced: modeLabel = "BALANCED"
        case .aggressive: modeLabel = "AGGRESSIVE"
        }

        appendColored("╭── Token Optimizer ──────────────────╮\n", color: cCyan)
        appendColored("  Mode: \(modeLabel)\n", color: cGreen, bold: true)
        appendColored("  Runs: \(tokenOptimizer.totalRuns) total", color: cGray)
        appendColored(" | Claude \(tokenOptimizer.claudeRuns)", color: cDimGray)
        appendColored(" | Codex \(tokenOptimizer.codexRuns)\n", color: cDimGray)
        appendColored("  Provider-level usage: /usage\n", color: cDimGray)
        appendColored("  Saved chars: \(tokenOptimizer.totalSavedChars) (\(tokenOptimizer.totalSavedPercent)%)\n", color: cYellow)
        if let last = lastTokenOptimization {
            appendColored("  Last run: \(last.originalChars) -> \(last.optimizedChars) chars", color: cGray)
            appendColored(" (\(last.savedPercent)% saved)\n", color: cDimGray)
        } else {
            appendColored("  Last run: (no data yet)\n", color: cDimGray)
        }
        appendColored("\n  Commands:\n", color: cPurple, bold: true)
        appendColored("  /optimizer on\n", color: cYellow)
        appendColored("  /optimizer off\n", color: cYellow)
        appendColored("  /optimizer balanced\n", color: cYellow)
        appendColored("  /optimizer aggressive\n", color: cYellow)
        appendColored("  /optimizer reset\n", color: cYellow)
        appendColored("╰────────────────────────────────────╯\n\n", color: cCyan)
    }

    func handleTokenOptimizerCommand(args: String) {
        let value = args.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if value.isEmpty || value == "status" || value == "stats" {
            showTokenOptimizerStatus()
            return
        }

        switch value {
        case "on", "auto", "balanced":
            tokenOptimizer.mode = .balanced
            tokenOptimizer.save()
            appendColored("✅ Token optimizer mode: BALANCED\n", color: cGreen, bold: true)
            appendColored("  Applies to active provider prompt + Brain context.\n\n", color: cGray)
        case "aggressive":
            tokenOptimizer.mode = .aggressive
            tokenOptimizer.save()
            appendColored("✅ Token optimizer mode: AGGRESSIVE\n", color: cGreen, bold: true)
            appendColored("  Maximum token savings, strongest compression.\n\n", color: cGray)
        case "off", "disable":
            tokenOptimizer.mode = .off
            tokenOptimizer.save()
            appendColored("✅ Token optimizer disabled\n\n", color: cYellow, bold: true)
        case "reset", "stats reset":
            tokenOptimizer.resetStats()
            appendColored("✅ Token optimizer stats reset\n\n", color: cGreen, bold: true)
        default:
            appendColored("❌ Usage: /optimizer [status|on|off|balanced|aggressive|reset]\n\n", color: cRed)
        }
    }

    func printHelpRows(_ rows: [(String, String)]) {
        for (cmd, desc) in rows {
            appendColored("  \(cmd.padding(toLength: 16, withPad: " ", startingAt: 0))", color: cYellow)
            appendOutput("\(desc)\n")
        }
    }

    func showHelp() {
        appendColored("╭── Help ─────────────────────────────╮\n", color: cCyan)
        appendColored("  Active provider: \(currentProvider.rawValue)\n", color: cGreen, bold: true)
        appendColored("  Quick start:\n", color: cPurple, bold: true)
        printHelpRows([
            ("text", "→ send prompt to active provider"),
            ("/model", "→ provider/model status"),
            ("/compare <p>", "→ compare outputs"),
            ("/suggest", "→ proactive next action"),
            ("/quests", "→ daily quests"),
            ("/leaderboard", "→ publish to leaderboard"),
        ])
        appendColored("\n  Categories:\n", color: cPurple, bold: true)
        appendColored("  /help ai      /help tools    /help pet\n", color: cGray)
        appendColored("  /help social  /help focus    /help all\n", color: cGray)
        appendColored("  /help all commands (full catalog)\n", color: cDimGray)
        appendColored("╰─────────────────────────────────────╯\n\n", color: cCyan)
    }

    func handleHelpCommand(args: String) {
        let key = args.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if key.isEmpty {
            showHelp()
            return
        }
        if key == "all" {
            showHelpAll()
            return
        }
        if key == "all commands" || key == "full" || key == "catalog" {
            showHelpCatalog()
            return
        }

        switch key {
        case "ai", "models", "model":
            appendColored("🤖 AI commands\n", color: cCyan, bold: true)
            printHelpRows([
                ("text", "→ prompt active provider"),
                ("/claude <p>", "→ force Claude"),
                ("/codex <p>", "→ force Codex"),
                ("/gpt <p>", "→ force OpenAI GPT"),
                ("/gemini <p>", "→ force Gemini"),
                ("/ollama <p>", "→ force Ollama"),
                ("/model", "→ current provider/model"),
                ("/model <p>", "→ set provider"),
                ("/model <p> <m>", "→ set model override"),
                ("/model endpoint ...", "→ custom API endpoint"),
                ("/compare <p>", "→ compare providers"),
                ("/usage [N]", "→ provider usage"),
                ("/cost", "→ cost summary"),
                ("/optimizer", "→ token optimizer status"),
            ])
            appendOutput("\n")
        case "tools", "dev":
            appendColored("🛠 Tools\n", color: cCyan, bold: true)
            printHelpRows([
                ("/diff", "→ AI review of git diff"),
                ("/commit", "→ generate commit message"),
                ("/ask <file>", "→ analyze file"),
                ("/screenshot", "→ capture + analyze"),
                ("/regex <desc>", "→ build regex"),
                ("/sh <desc>", "→ NL → shell command"),
                ("/watch", "→ clipboard watcher on"),
                ("/unwatch", "→ clipboard watcher off"),
                ("/save /snippets", "→ snippet knowledge base"),
                ("/export", "→ export snippets markdown"),
                ("/update", "→ download/apply latest release"),
            ])
            appendOutput("\n")
        case "pet", "brain":
            appendColored("🐾 Pet + Brain\n", color: cCyan, bold: true)
            printHelpRows([
                ("/feed /play /rest", "→ core pet actions"),
                ("/stats /evo /ach", "→ status/evolution/achievements"),
                ("/training", "→ training dashboard"),
                ("/specialist", "→ specialist profile"),
                ("/train <fact>", "→ train memory"),
                ("/memory", "→ learned facts/skills"),
                ("/personality", "→ behavior profile"),
                ("/suggest", "→ proactive suggestion"),
                ("/optimizer", "→ token optimizer"),
            ])
            appendOutput("\n")
        case "social", "pvp":
            appendColored("🌐 Social + PvP\n", color: cCyan, bold: true)
            printHelpRows([
                ("/name <name>", "→ set leaderboard name"),
                ("/leaderboard", "→ publish stats"),
                ("/market", "→ rental market snapshot"),
                ("/rent help", "→ rental commands"),
                ("/battle <user>", "→ send challenge"),
                ("/challenges", "→ incoming challenges"),
                ("/accept <user>", "→ accept challenge"),
                ("/move <atk> <def>", "→ submit duel move"),
                ("/battles", "→ battle history"),
            ])
            appendOutput("\n")
        case "focus", "fun":
            appendColored("🎯 Focus + Fun\n", color: cCyan, bold: true)
            printHelpRows([
                ("/quests", "→ daily quests"),
                ("/inventory", "→ your items"),
                ("/pomo /pomo10", "→ focus timer"),
                ("/break /stoppomo", "→ break/timer stop"),
                ("/game /trivia /typing", "→ mini games"),
                ("/daily", "→ daily summary"),
            ])
            appendOutput("\n")
        default:
            appendColored("❌ Unknown help section: \(key)\n", color: cRed)
            appendColored("  Use: /help ai | /help tools | /help pet | /help social | /help focus | /help all\n", color: cGray)
            appendColored("       /help all commands for full catalog\n\n", color: cGray)
        }
    }

    func showHelpAll() {
        appendColored("╭── Command Map ──────────────────────╮\n", color: cCyan)
        appendColored("  AI\n", color: cPurple, bold: true)
        printHelpRows([
            ("/model", "→ active provider and model"),
            ("/models", "→ all providers/models"),
            ("/compare <p>", "→ compare provider answers"),
            ("/usage [N]", "→ provider usage"),
            ("/cost", "→ estimated spend"),
        ])
        appendColored("  Pet + Learning\n", color: cPurple, bold: true)
        printHelpRows([
            ("/stats", "→ pet state and progress"),
            ("/training", "→ learning dashboard"),
            ("/specialist", "→ active specialty"),
            ("/personality", "→ personality profile"),
            ("/suggest", "→ proactive next action"),
        ])
        appendColored("  Social\n", color: cPurple, bold: true)
        printHelpRows([
            ("/leaderboard", "→ publish profile"),
            ("/market", "→ rental market"),
            ("/rent help", "→ rental commands"),
            ("/battle <user>", "→ send challenge"),
            ("/battles", "→ recent duel history"),
        ])
        appendColored("  Dev Tools\n", color: cPurple, bold: true)
        printHelpRows([
            ("/diff", "→ AI review of git diff"),
            ("/commit", "→ commit message generator"),
            ("/watch", "→ clipboard watcher on"),
            ("/save", "→ save last answer"),
            ("/export", "→ export snippets to markdown"),
        ])
        appendColored("  Focus + Fun\n", color: cPurple, bold: true)
        printHelpRows([
            ("/quests", "→ daily quests"),
            ("/pomo", "→ 25-minute focus timer"),
            ("/game", "→ number game"),
            ("/trivia", "→ trivia mini-game"),
            ("/typing", "→ typing speed test"),
        ])
        appendColored("\n  Need everything? /help all commands\n", color: cDimGray)
        appendColored("╰─────────────────────────────────────╯\n\n", color: cCyan)
    }

    func showHelpCatalog() {
        appendColored("╭── Full Command Catalog ─────────────╮\n", color: cCyan)
        appendColored("  AI + Routing\n", color: cPurple, bold: true)
        printHelpRows([
            ("text", "→ send to active provider (\(currentProvider.rawValue))"),
            ("/claude <p>", "→ force Claude"),
            ("/codex <p>", "→ force Codex"),
            ("/gpt <p>", "→ force GPT"),
            ("/gemini <p>", "→ force Gemini"),
            ("/ollama <p>", "→ force Ollama"),
            ("/model", "→ active provider/model"),
            ("/models", "→ list providers"),
            ("/model endpoint ...", "→ set/clear endpoint"),
            ("/compare <p>", "→ compare outputs"),
            ("/usage [N]", "→ provider usage"),
            ("/cost", "→ token/cost tracker"),
            ("/paste", "→ analyze clipboard text"),
        ])

        appendColored("  Pet + Brain\n", color: cPurple, bold: true)
        printHelpRows([
            ("/feed /play /rest", "→ core pet actions"),
            ("/stats /evo /ach", "→ status + progression"),
            ("/training", "→ training dashboard"),
            ("/personality", "→ personality status/mode"),
            ("/suggest", "→ proactive suggestion"),
            ("/specialist", "→ specialist profile"),
            ("/specialist list", "→ specialist keys"),
            ("/specialist set <k>", "→ lock specialist"),
            ("/optimizer", "→ optimizer status"),
            ("/train <fact>", "→ memory training (+XP)"),
            ("/teach <fact>", "→ teach alias"),
            ("/memory", "→ show pet memory"),
            ("/brain", "→ export brain JSON"),
            ("/forget <fact>", "→ remove fact"),
        ])

        appendColored("  Social + PvP + Market\n", color: cPurple, bold: true)
        printHelpRows([
            ("/name <name>", "→ set leaderboard name"),
            ("/leaderboard", "→ publish profile"),
            ("/market", "→ rental market view"),
            ("/rent help", "→ rental commands"),
            ("/rent publish ...", "→ publish listing"),
            ("/rent take ...", "→ rent a pet"),
            ("/rent my [role]", "→ rental history"),
            ("/rent end <id>", "→ finish rental"),
            ("/battle <user>", "→ send challenge"),
            ("/challenges", "→ pending challenges"),
            ("/accept <user>", "→ accept challenge"),
            ("/decline <user>", "→ decline challenge"),
            ("/move <atk> <def>", "→ submit duel move"),
            ("/battles", "→ battle history"),
        ])

        appendColored("  Dev + Utility\n", color: cPurple, bold: true)
        printHelpRows([
            ("/screenshot", "→ capture + analyze"),
            ("/diff", "→ AI diff review"),
            ("/commit", "→ generate commit message"),
            ("/ask <file>", "→ analyze file"),
            ("/watch /unwatch", "→ clipboard monitor"),
            ("/save", "→ save snippet"),
            ("/snippets", "→ list snippets"),
            ("/search <q>", "→ search snippets"),
            ("/export", "→ export snippets markdown"),
            ("/share", "→ export SVG card"),
            ("/chat new|list|<N>", "→ chat sessions"),
            ("/remind <t> <text>", "→ reminder"),
            ("/reminders", "→ reminder list"),
            ("/standup", "→ standup report"),
            ("/sh <desc>", "→ NL to shell"),
            ("/clipboard", "→ clipboard history"),
            ("/calc <expr>", "→ quick conversions"),
            ("/regex <desc>", "→ regex helper"),
            ("/daily", "→ day summary"),
            ("/promptstats [N]", "→ prompt stats"),
            ("/promptcoach [N]", "→ prompt feedback"),
            ("/git", "→ git status snapshot"),
            ("/ps", "→ process monitor"),
            ("/tip", "→ random tip"),
            ("/history", "→ command history"),
            ("/update", "→ update to latest"),
            ("/version", "→ current version"),
            ("/clear", "→ clear output"),
        ])

        appendColored("  Focus + Games\n", color: cPurple, bold: true)
        printHelpRows([
            ("/quests", "→ daily quests"),
            ("/inventory", "→ unlocked items"),
            ("/pomo /pomo10", "→ focus timers"),
            ("/break /stoppomo", "→ break and stop"),
            ("/game /trivia /typing", "→ mini-games"),
            ("/dance", "→ dance animation"),
            ("/compact /full", "→ switch UI density"),
        ])
        appendColored("╰─────────────────────────────────────╯\n\n", color: cCyan)
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
        let specialistMode = brain.manualSpecialtyKey == nil ? "Auto" : "Manual"
        appendColored("  Specialist mode: \(specialistMode)\n", color: cGray)
        appendColored("  Active specialist: \(brain.currentSpecialtyLabel())\n", color: cYellow)
        let topSpecialties = brain.topSpecialties(limit: 3).map { "\($0.label)(\($0.score))" }.joined(separator: ", ")
        appendColored("  Top specialties: \(topSpecialties)\n", color: cDimGray)

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
            "specialtyScores": brain.specialtyScores,
            "manualSpecialtyKey": brain.manualSpecialtyKey as Any,
            "activeSpecialtyKey": brain.currentSpecialtyKey(),
            "activeSpecialtyLabel": brain.currentSpecialtyLabel(),
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

    func leaderboardSignature() -> String {
        let data = [
            playerUsername.lowercased(),
            String(pet.level),
            String(pet.xp),
            String(pet.totalCommands),
            String(pet.streak),
            String(pet.unlockedAchievements.count),
            String(pet.hunger),
            String(pet.happiness),
            String(pet.energy),
            currentSkin.rawValue
        ]
        return data.joined(separator: "|")
    }

    func maybeShowSilentLeaderboardError(_ text: String) {
        let now = Date()
        if let last = lastSilentLeaderboardErrorAt, now.timeIntervalSince(last) < 300 {
            return
        }
        lastSilentLeaderboardErrorAt = now
        appendColored("⚠️  Auto-sync failed: \(text)\n", color: cYellow)
        appendColored("  Run /leaderboard to retry and see details.\n\n", color: cDimGray)
    }

    func syncLeaderboardIfNeeded() {
        guard !playerUsername.isEmpty else { return }
        let currentSignature = leaderboardSignature()
        if currentSignature == lastLeaderboardSubmittedSignature { return }
        submitToLeaderboard(silent: true)
    }

    func submitToLeaderboard(silent: Bool = false) {
        if playerUsername.isEmpty {
            if !silent {
                appendColored("❌ Set your name first: /name YourName\n\n", color: cRed)
            }
            return
        }

        if !silent {
            setState(.thinking)
            bubbleLabel.stringValue = speechBubble("Publishing to leaderboard...")
            appendColored("🏆 Submitting to leaderboard...\n", color: cYellow)
        }

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
            if !silent {
                appendColored("❌ Failed to create request\n\n", color: cRed)
                setState(.error)
            }
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
                    if silent {
                        self.maybeShowSilentLeaderboardError(error.localizedDescription)
                    } else {
                        self.appendColored("❌ \(error.localizedDescription)\n\n", color: self.cRed)
                        self.setState(.error)
                    }
                    return
                }

                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if statusCode >= 400 {
                        let errorText = json["error"] as? String ?? "Submit failed (HTTP \(statusCode))"
                        if silent {
                            self.maybeShowSilentLeaderboardError(errorText)
                        } else {
                            self.appendColored("❌ \(errorText)\n", color: self.cRed)
                            if errorText.lowercased().contains("protected by another device token") {
                                self.appendColored("  Your saved token does not match server owner token.\n", color: self.cDimGray)
                                self.appendColored("  Quick fix: set new name with /name NewName, then /leaderboard.\n", color: self.cDimGray)
                            }
                            self.appendOutput("\n")
                            self.setState(.error)
                        }
                        return
                    }

                    if let token = json["token"] as? String, !token.isEmpty {
                        self.playerAuthToken = token
                        UserDefaults.standard.set(token, forKey: "agento_player_token")
                        self.pet.leaderboardToken = token
                        self.pet.leaderboardUsername = self.playerUsername
                        self.pet.save()
                    }
                    self.lastLeaderboardSubmittedSignature = self.leaderboardSignature()
                    self.lastSilentLeaderboardErrorAt = nil

                    if !silent {
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
                        if self.onboardingStep == 5 {
                            self.finishOnboardingFlow()
                        }
                    }
                } else if statusCode >= 400 {
                    let msg = "Submit failed (HTTP \(statusCode))"
                    if silent {
                        self.maybeShowSilentLeaderboardError(msg)
                    } else {
                        self.appendColored("❌ \(msg)\n\n", color: self.cRed)
                        self.setState(.error)
                    }
                } else {
                    self.lastLeaderboardSubmittedSignature = self.leaderboardSignature()
                    self.lastSilentLeaderboardErrorAt = nil
                    if !silent {
                        self.appendColored("✅ Submitted!\n\n", color: self.cGreen, bold: true)
                        self.setState(.happy)
                        if self.onboardingStep == 5 {
                            self.finishOnboardingFlow()
                        }
                    }
                }
            }
        }
        task.resume()
    }

    // MARK: - Pet Marketplace

    func boolFromAny(_ value: Any?, default defaultValue: Bool = false) -> Bool {
        if let v = value as? Bool { return v }
        if let v = value as? Int { return v != 0 }
        if let v = value as? Double { return v != 0 }
        if let v = value as? String {
            let s = v.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            if s == "true" || s == "1" || s == "yes" || s == "on" { return true }
            if s == "false" || s == "0" || s == "no" || s == "off" { return false }
        }
        return defaultValue
    }

    func queryEncoded(_ value: String) -> String {
        return value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
    }

    func socialJSONRequest(
        path: String,
        method: String = "GET",
        payload: [String: Any]? = nil,
        completion: @escaping (_ statusCode: Int, _ json: [String: Any]?, _ errorText: String?) -> Void
    ) {
        guard let url = URL(string: "\(AgentODelegate.leaderboardURL)\(path)") else {
            completion(0, nil, "Failed to build request URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        if let payload = payload {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion((response as? HTTPURLResponse)?.statusCode ?? 0, nil, error.localizedDescription)
                    return
                }

                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                var json: [String: Any]?
                if let data = data {
                    json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                }

                if statusCode >= 400 {
                    let serverError = json?["error"] as? String
                    completion(statusCode, json, serverError ?? "HTTP \(statusCode)")
                    return
                }

                completion(statusCode, json, nil)
            }
        }.resume()
    }

    func ensureRentIdentity() -> Bool {
        if playerUsername.isEmpty {
            appendColored("❌ Set your name first: /name YourName\n", color: cRed)
            appendColored("  Then publish once: /leaderboard\n\n", color: cGray)
            return false
        }
        if playerAuthToken.isEmpty {
            appendColored("❌ Missing owner token. Publish once first: /leaderboard\n\n", color: cRed)
            return false
        }
        return true
    }

    func showRentHelp() {
        appendColored("╭── Pet Rent Commands ────────────────╮\n", color: cPurple)
        appendColored("  /market\n", color: cYellow)
        appendColored("    show marketplace summary + listings\n", color: cGray)
        appendColored("  /rent publish <pricePerDay> <maxDays> <title>\n", color: cYellow)
        appendColored("    publish or update your pet listing\n", color: cGray)
        appendColored("  /rent off\n", color: cYellow)
        appendColored("    disable your listing\n", color: cGray)
        appendColored("  /rent take <ownerUsername> <days>\n", color: cYellow)
        appendColored("    rent another player's pet\n", color: cGray)
        appendColored("  /rent my [owner|renter|both]\n", color: cYellow)
        appendColored("    show your rental history\n", color: cGray)
        appendColored("  /rent end <rentalId>\n", color: cYellow)
        appendColored("    finish your active rental as owner\n", color: cGray)
        appendColored("╰────────────────────────────────────╯\n\n", color: cPurple)
    }

    func handleRentCommand(args: String) {
        let trimmed = args.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            showRentHelp()
            return
        }

        let lower = trimmed.lowercased()
        if lower == "help" {
            showRentHelp()
            return
        }
        if lower == "off" {
            rentDisableListing()
            return
        }
        if lower.hasPrefix("publish ") {
            let payload = String(trimmed.dropFirst(8)).trimmingCharacters(in: .whitespacesAndNewlines)
            rentPublish(args: payload)
            return
        }
        if lower.hasPrefix("take ") {
            let payload = String(trimmed.dropFirst(5)).trimmingCharacters(in: .whitespacesAndNewlines)
            rentTake(args: payload)
            return
        }
        if lower == "my" {
            rentMy(role: "both")
            return
        }
        if lower.hasPrefix("my ") {
            let role = String(trimmed.dropFirst(3)).trimmingCharacters(in: .whitespacesAndNewlines)
            rentMy(role: role)
            return
        }
        if lower.hasPrefix("end ") {
            let rentalId = String(trimmed.dropFirst(4)).trimmingCharacters(in: .whitespacesAndNewlines)
            rentEnd(rentalId: rentalId)
            return
        }

        appendColored("❌ Unknown /rent command\n", color: cRed)
        showRentHelp()
    }

    func showMarketOverview() {
        setState(.thinking)
        bubbleLabel.stringValue = speechBubble("Loading pet marketplace...")
        appendColored("🏪 Marketplace snapshot\n", color: cCyan, bold: true)

        socialJSONRequest(path: "/api/pets/market/summary?limit=6") { [weak self] _, summaryJson, summaryError in
            guard let self = self else { return }
            if let summaryError = summaryError {
                self.appendColored("❌ \(summaryError)\n\n", color: self.cRed)
                self.setState(.error)
                return
            }

            let counts = summaryJson?["counts"] as? [String: Any]
            let activeListings = self.intFromAny(counts?["activeListings"], default: 0)
            let activeRentals = self.intFromAny(counts?["activeRentals"], default: 0)
            let totalRentals = self.intFromAny(counts?["totalRentals"], default: 0)

            self.appendColored("  Listings: \(activeListings) | Active rentals: \(activeRentals) | Total rentals: \(totalRentals)\n", color: self.cGray)
            self.appendColored("  Web: \(AgentODelegate.leaderboardURL)/marketplace\n\n", color: self.cCyan)

            self.socialJSONRequest(path: "/api/pets/market/listings?limit=8") { [weak self] _, listingsJson, listingsError in
                guard let self = self else { return }
                if let listingsError = listingsError {
                    self.appendColored("❌ \(listingsError)\n\n", color: self.cRed)
                    self.setState(.error)
                    return
                }

                let listings = listingsJson?["listings"] as? [[String: Any]] ?? []
                if listings.isEmpty {
                    self.appendColored("No public listings yet.\n", color: self.cDimGray)
                    self.appendColored("  Publish yours: /rent publish 50 7 CyberPet\n\n", color: self.cGray)
                    self.setState(.idle)
                    return
                }

                self.appendColored("Top listings:\n", color: self.cYellow, bold: true)
                for row in listings.prefix(8) {
                    let owner = row["ownerUsername"] as? String ?? "?"
                    let title = (row["title"] as? String ?? "\(owner)'s Pet").trimmingCharacters(in: .whitespacesAndNewlines)
                    let pricePerDay = self.intFromAny(row["pricePerDay"], default: 0)
                    let minDays = max(1, self.intFromAny(row["minDays"], default: 1))
                    let maxDays = max(minDays, self.intFromAny(row["maxDays"], default: minDays))
                    let rented = self.boolFromAny(row["rented"], default: false)
                    let active = self.boolFromAny(row["active"], default: false)
                    let status = rented ? "rented" : (active ? "available" : "offline")

                    self.appendColored("  • \(owner)", color: self.cCyan, bold: true)
                    self.appendColored("  \(title)  [\(status)]\n", color: self.cGray)
                    self.appendColored("    \(pricePerDay) XP/day | \(minDays)-\(maxDays)d | /rent take \(owner) \(minDays)\n", color: self.cDimGray)
                }
                self.appendOutput("\n")
                self.setState(.idle)
            }
        }
    }

    func rentPublish(args: String) {
        guard ensureRentIdentity() else { return }
        let parts = args.split(maxSplits: 2, whereSeparator: { $0.isWhitespace || $0.isNewline }).map(String.init)
        guard parts.count >= 2 else {
            appendColored("❌ Usage: /rent publish <pricePerDay> <maxDays> <title>\n", color: cRed)
            appendColored("  Example: /rent publish 50 7 CyberCat\n\n", color: cGray)
            return
        }

        guard let pricePerDay = Int(parts[0]), pricePerDay > 0 else {
            appendColored("❌ pricePerDay must be a positive number\n\n", color: cRed)
            return
        }
        guard let maxDays = Int(parts[1]), maxDays > 0 else {
            appendColored("❌ maxDays must be a positive number\n\n", color: cRed)
            return
        }

        let titleRaw = parts.count > 2 ? parts[2] : "\(playerUsername)'s Pet"
        let title = titleRaw.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalTitle = title.isEmpty ? "\(playerUsername)'s Pet" : title
        let specialty = brain.currentSpecialtyLabel()
        let topSpecialties = brain.topSpecialties(limit: 2).map { $0.label }.joined(separator: ", ")
        let listingDescription = "Lv.\(pet.level) \(currentSkin.rawValue) companion | Specialist: \(specialty) | Signals: \(topSpecialties)"

        let payload: [String: Any] = [
            "username": playerUsername,
            "token": playerAuthToken,
            "title": finalTitle,
            "description": listingDescription,
            "pricePerDay": pricePerDay,
            "minDays": 1,
            "maxDays": maxDays,
            "active": true,
        ]

        setState(.thinking)
        appendColored("📤 Publishing listing...\n", color: cYellow)

        socialJSONRequest(path: "/api/pets/market/listings", method: "POST", payload: payload) { [weak self] _, json, errorText in
            guard let self = self else { return }
            if let errorText = errorText {
                self.appendColored("❌ \(errorText)\n\n", color: self.cRed)
                self.setState(.error)
                return
            }

            let listing = json?["listing"] as? [String: Any]
            let savedTitle = listing?["title"] as? String ?? finalTitle
            let savedPrice = self.intFromAny(listing?["pricePerDay"], default: pricePerDay)
            let savedMaxDays = self.intFromAny(listing?["maxDays"], default: maxDays)
            let savedMinDays = self.intFromAny(listing?["minDays"], default: 1)
            let note = json?["note"] as? String

            self.appendColored("✅ Listing published\n", color: self.cGreen, bold: true)
            self.appendColored("  \(savedTitle) | \(savedPrice) XP/day | \(savedMinDays)-\(savedMaxDays)d\n", color: self.cGray)
            if let note = note, !note.isEmpty {
                self.appendColored("  \(note)\n", color: self.cDimGray)
            }
            self.appendColored("  View: \(AgentODelegate.leaderboardURL)/marketplace\n\n", color: self.cCyan)
            self.bubbleLabel.stringValue = speechBubble("Listing is live!")
            self.setState(.happy)
        }
    }

    func rentDisableListing() {
        guard ensureRentIdentity() else { return }
        let payload: [String: Any] = [
            "username": playerUsername,
            "token": playerAuthToken,
            "active": false,
        ]

        setState(.thinking)
        appendColored("⏸️  Disabling listing...\n", color: cYellow)

        socialJSONRequest(path: "/api/pets/market/listings", method: "POST", payload: payload) { [weak self] _, _, errorText in
            guard let self = self else { return }
            if let errorText = errorText {
                self.appendColored("❌ \(errorText)\n\n", color: self.cRed)
                self.setState(.error)
                return
            }

            self.appendColored("✅ Listing disabled\n", color: self.cGreen, bold: true)
            self.appendColored("  Enable again with /rent publish <price> <maxDays> <title>\n\n", color: self.cGray)
            self.setState(.idle)
        }
    }

    func rentTake(args: String) {
        guard ensureRentIdentity() else { return }
        let parts = args.split(whereSeparator: { $0.isWhitespace || $0.isNewline }).map(String.init)
        guard parts.count >= 2 else {
            appendColored("❌ Usage: /rent take <ownerUsername> <days>\n\n", color: cRed)
            return
        }

        let ownerUsername = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
        guard !ownerUsername.isEmpty else {
            appendColored("❌ Missing owner username\n\n", color: cRed)
            return
        }
        if ownerUsername.lowercased() == playerUsername.lowercased() {
            appendColored("❌ You can't rent your own pet\n\n", color: cRed)
            return
        }
        guard let days = Int(parts[1]), days > 0 else {
            appendColored("❌ days must be a positive number\n\n", color: cRed)
            return
        }

        setState(.thinking)
        appendColored("🧾 Creating rental...\n", color: cYellow)

        let payload: [String: Any] = [
            "ownerUsername": ownerUsername,
            "renterUsername": playerUsername,
            "token": playerAuthToken,
            "days": days,
        ]

        socialJSONRequest(path: "/api/pets/market/rent", method: "POST", payload: payload) { [weak self] _, json, errorText in
            guard let self = self else { return }
            if let errorText = errorText {
                self.appendColored("❌ \(errorText)\n\n", color: self.cRed)
                self.setState(.error)
                return
            }

            let rental = json?["rental"] as? [String: Any]
            let rentalId = rental?["id"] as? String ?? "unknown"
            let title = rental?["title"] as? String ?? "\(ownerUsername)'s Pet"
            let pricePerDay = self.intFromAny(rental?["pricePerDay"], default: 0)
            let actualDays = self.intFromAny(rental?["days"], default: days)
            let totalPrice = self.intFromAny(rental?["totalPrice"], default: max(1, actualDays) * max(1, pricePerDay))
            let endAt = rental?["endAt"] as? String ?? "-"

            self.appendColored("✅ Rental started\n", color: self.cGreen, bold: true)
            self.appendColored("  ID: \(rentalId)\n", color: self.cCyan)
            self.appendColored("  \(title) from \(ownerUsername)\n", color: self.cGray)
            self.appendColored("  \(actualDays)d × \(pricePerDay) XP = \(totalPrice) XP\n", color: self.cGray)
            self.appendColored("  Ends at: \(endAt)\n\n", color: self.cDimGray)
            self.bubbleLabel.stringValue = speechBubble("Rental confirmed!")
            self.setState(.happy)
        }
    }

    func rentMy(role rawRole: String) {
        guard ensureRentIdentity() else { return }
        let normalizedRole = rawRole.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let role: String
        if normalizedRole.isEmpty || normalizedRole == "both" {
            role = "both"
        } else if normalizedRole == "owner" || normalizedRole == "renter" {
            role = normalizedRole
        } else {
            appendColored("❌ role must be owner, renter, or both\n\n", color: cRed)
            return
        }

        setState(.thinking)
        let safeUser = queryEncoded(playerUsername)
        let safeToken = queryEncoded(playerAuthToken)
        socialJSONRequest(path: "/api/pets/market/rentals?username=\(safeUser)&token=\(safeToken)&role=\(role)&limit=20") { [weak self] _, json, errorText in
            guard let self = self else { return }
            if let errorText = errorText {
                self.appendColored("❌ \(errorText)\n\n", color: self.cRed)
                self.setState(.error)
                return
            }

            let counts = json?["counts"] as? [String: Any]
            let active = self.intFromAny(counts?["active"], default: 0)
            let ownerCount = self.intFromAny(counts?["owner"], default: 0)
            let renterCount = self.intFromAny(counts?["renter"], default: 0)
            let rentals = json?["rentals"] as? [[String: Any]] ?? []

            self.appendColored("╭── My Rentals (\(role)) ───────────────╮\n", color: self.cPurple)
            self.appendColored("  Active: \(active) | Owner: \(ownerCount) | Renter: \(renterCount)\n\n", color: self.cCyan, bold: true)

            if rentals.isEmpty {
                self.appendColored("  No rentals found.\n", color: self.cDimGray)
                self.appendColored("╰────────────────────────────────────╯\n\n", color: self.cPurple)
                self.setState(.idle)
                return
            }

            for row in rentals.prefix(10) {
                let rentalId = row["id"] as? String ?? "?"
                let owner = row["ownerUsername"] as? String ?? "?"
                let renter = row["renterUsername"] as? String ?? "?"
                let status = (row["status"] as? String ?? "unknown").lowercased()
                let days = self.intFromAny(row["days"], default: 0)
                let totalPrice = self.intFromAny(row["totalPrice"], default: 0)
                let createdAt = row["createdAt"] as? String ?? "-"
                self.appendColored("  • \(rentalId)\n", color: self.cYellow, bold: true)
                self.appendColored("    \(renter) -> \(owner) | \(status) | \(days)d | \(totalPrice) XP\n", color: self.cGray)
                self.appendColored("    \(createdAt)\n", color: self.cDimGray)
            }
            self.appendColored("╰────────────────────────────────────╯\n\n", color: self.cPurple)
            self.setState(.idle)
        }
    }

    func rentEnd(rentalId: String) {
        guard ensureRentIdentity() else { return }
        let cleanId = rentalId.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanId.isEmpty else {
            appendColored("❌ Usage: /rent end <rentalId>\n\n", color: cRed)
            return
        }

        setState(.thinking)
        appendColored("🛑 Finishing rental \(cleanId)...\n", color: cYellow)

        let payload: [String: Any] = [
            "ownerUsername": playerUsername,
            "token": playerAuthToken,
            "rentalId": cleanId,
        ]

        socialJSONRequest(path: "/api/pets/market/rent/finish", method: "POST", payload: payload) { [weak self] _, json, errorText in
            guard let self = self else { return }
            if let errorText = errorText {
                self.appendColored("❌ \(errorText)\n\n", color: self.cRed)
                self.setState(.error)
                return
            }

            let rental = json?["rental"] as? [String: Any]
            let status = rental?["status"] as? String ?? "ended"
            let endedAt = rental?["endedAt"] as? String ?? rental?["updatedAt"] as? String ?? "-"
            let note = json?["note"] as? String
            self.appendColored("✅ Rental \(cleanId) -> \(status)\n", color: self.cGreen, bold: true)
            if let note = note, !note.isEmpty {
                self.appendColored("  \(note)\n", color: self.cDimGray)
            }
            self.appendColored("  Finished at: \(endedAt)\n\n", color: self.cGray)
            self.setState(.idle)
        }
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

    func hasLeaderboardProfileBound() -> Bool {
        return !playerUsername.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !playerAuthToken.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func showOnboardingNameStep() {
        appendColored("  Nice! Now set your public pet name.\n", color: cGreen)
        appendColored("  Type: ", color: cGray)
        appendColored("/name YourName\n\n", color: cYellow, bold: true)
        bubbleLabel.stringValue = speechBubble("Set your name with /name")
    }

    func showOnboardingLeaderboardStep() {
        appendColored("  Final step: publish to leaderboard.\n", color: cGreen)
        appendColored("  Type: ", color: cGray)
        appendColored("/leaderboard\n\n", color: cYellow, bold: true)
        bubbleLabel.stringValue = speechBubble("Publish with /leaderboard")
    }

    func finishOnboardingFlow() {
        onboardingStep = 0
        pet.hasCompletedOnboarding = true
        pet.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.appendColored("\n  ✅ Onboarding complete! You're ready.\n", color: self.cGreen, bold: true)
            self.appendColored("  Type /help to see all commands\n", color: self.cGray)
            self.appendColored("  Type /quests to see daily quests\n\n", color: self.cGray)
            self.bubbleLabel.stringValue = speechBubble("Let's go! 🚀")
            self.playSound("Glass")
        }
    }

    func startOnboarding() {
        onboardingStep = 1
        appendColored("\n", color: cGray)
        appendColored("  ╔══════════════════════════════════════╗\n", color: cCyan)
        appendColored("  ║     Welcome to Agent-O! 🤖           ║\n", color: cCyan)
        appendColored("  ║   Feed, play, name, and publish      ║\n", color: cCyan)
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
                    self.appendColored("  Awesome! Now try asking your active provider a question.\n", color: self.cGreen)
                    self.appendColored("  Type anything, e.g.: ", color: self.cGray)
                    self.appendColored("what is swift?\n\n", color: self.cYellow, bold: true)
                    self.bubbleLabel.stringValue = speechBubble("Fun! Now ask me anything!")
                }
                return false
            }
        case 3:
            if !cmd.hasPrefix("/") {
                if playerUsername.isEmpty {
                    onboardingStep = 4
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.showOnboardingNameStep()
                    }
                    return false
                }
                if !hasLeaderboardProfileBound() {
                    onboardingStep = 5
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.showOnboardingLeaderboardStep()
                    }
                    return false
                }
                finishOnboardingFlow()
                return false
            }
        case 4:
            if cmd.hasPrefix("/name ") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    if !self.playerUsername.isEmpty {
                        self.onboardingStep = 5
                        self.showOnboardingLeaderboardStep()
                    }
                }
                return false
            }
        case 5:
            if cmd == "/leaderboard" {
                appendColored("  Publishing profile... wait for confirmation.\n\n", color: cDimGray)
                bubbleLabel.stringValue = speechBubble("Publishing profile...")
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

    func findFirstAppBundle(in rootPath: String) -> String? {
        let fm = FileManager.default
        let rootURL = URL(fileURLWithPath: rootPath)
        guard let enumerator = fm.enumerator(
            at: rootURL,
            includingPropertiesForKeys: [.isDirectoryKey, .nameKey],
            options: [.skipsHiddenFiles]
        ) else {
            return nil
        }

        for case let fileURL as URL in enumerator {
            if fileURL.pathExtension.lowercased() == "app" {
                return fileURL.path
            }
        }
        return nil
    }

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

                    if AgentODelegate.compareVersions(remoteVersion, AgentODelegate.currentVersion) <= 0 {
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
            guard unzipProc.terminationStatus == 0 else {
                appendColored("❌ Failed to unzip update archive\n\n", color: cRed)
                setState(.error)
                return
            }

            // Find .app in extracted folder (including nested dirs)
            guard let newAppPath = findFirstAppBundle(in: tmpDir) else {
                appendColored("❌ No .app found in update\n\n", color: cRed)
                setState(.error)
                return
            }

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
            guard proc.terminationStatus == 0 else {
                appendColored("❌ Failed to unzip update archive\n\n", color: cRed)
                setState(.error)
                return
            }

            // Remove quarantine
            let xattr = Process()
            xattr.executableURL = URL(fileURLWithPath: "/usr/bin/xattr")
            xattr.arguments = ["-cr", destDir]
            try xattr.run()
            xattr.waitUntilExit()

            guard let appPath = findFirstAppBundle(in: destDir) else {
                appendColored("❌ No .app found after extraction\n", color: cRed)
                appendColored("  Folder: \(destDir)\n\n", color: cDimGray)
                setState(.error)
                return
            }

            appendColored("✅ Downloaded v\(version) to:\n", color: cGreen, bold: true)
            appendColored("  \(appPath)\n", color: cCyan)
            appendColored("  Opening it now...\n\n", color: cGray)
            setState(.happy)
            bubbleLabel.stringValue = speechBubble("Updated! v\(version)")

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                let proc = Process()
                proc.executableURL = URL(fileURLWithPath: "/usr/bin/open")
                proc.arguments = [appPath]
                try? proc.run()
            }
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
                guard AgentODelegate.compareVersions(remoteVersion, AgentODelegate.currentVersion) > 0 else { return }

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

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        if sender === window {
            // Don't close — switch to walking pet mode
            toggleWindow()
            return false
        }
        return true
    }
}

// MARK: - Main

let app = NSApplication.shared
let delegate = AgentODelegate()
app.delegate = delegate
app.run()
