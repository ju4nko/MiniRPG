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
    var emoji: String
    
    static func goblin() -> Enemy {
        Enemy(name: "Felipez360", maxHP: 15, currentHP: 15, attack: 4, defense: 1, xpReward: 10, emoji: "👹")
    }
    
    static func skeleton() -> Enemy {
        Enemy(name: "Xokas", maxHP: 20, currentHP: 20, attack: 5, defense: 2, xpReward: 15, emoji: "💀")
    }
    
    static func wolf() -> Enemy {
        Enemy(name: "Huesoperro", maxHP: 25, currentHP: 25, attack: 7, defense: 1, xpReward: 20, emoji: "🐺")
    }
}

