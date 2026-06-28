//
//  Enemy.swift
//  MiniRPG//
//  Created by Juanjo on 22/06/2026.
//
import Foundation

struct Enemy {
    var name: String
    var maxHP: Int
    var currentHP: Int
    var attack: Int
    var defense: Int
    var xpReward: Int
    var goldReward: Int
    var emoji: String
    var isBoss: Bool = false
    
    static func goblin() -> Enemy {
        Enemy(name: "Felipez360", maxHP: 15, currentHP: 15, attack: 4, defense: 1, xpReward: 10, goldReward: 5, emoji: "👹")
    }
    
    static func skeleton() -> Enemy {
        Enemy(name: "Xokas", maxHP: 20, currentHP: 20, attack: 5, defense: 2, xpReward: 15, goldReward: 8, emoji: "💀")
    }
    
    static func wolf() -> Enemy {
        Enemy(name: "Huesoperro", maxHP: 25, currentHP: 25, attack: 7, defense: 1, xpReward: 20, goldReward: 12, emoji: "🐺")
    }
    
    static func rat() -> Enemy {
        Enemy(name: "Rata cloaca", maxHP: 8, currentHP: 8, attack: 3, defense: 0, xpReward: 5, goldReward: 3, emoji: "🐀")
    }

    static func slime() -> Enemy {
        Enemy(name: "Slimecillo", maxHP: 18, currentHP: 18, attack: 4, defense: 3, xpReward: 12, goldReward: 7, emoji: "🟢")
    }

    static func orc() -> Enemy {
        Enemy(name: "Orco Bruto", maxHP: 35, currentHP: 35, attack: 9, defense: 3, xpReward: 30, goldReward: 18, emoji: "👺")
    }

    static func dragon() -> Enemy {
        Enemy(name: "Dragón Ancestral", maxHP: 60, currentHP: 60, attack: 13, defense: 5, xpReward: 60, goldReward: 50, emoji: "🐉")
    }
    
    static func finalBoss() -> Enemy {
        Enemy(name: "Señor del Caos", maxHP: 120, currentHP: 120, attack: 16, defense: 6, xpReward: 200, goldReward: 200, emoji: "👿", isBoss: true)
    }
}

