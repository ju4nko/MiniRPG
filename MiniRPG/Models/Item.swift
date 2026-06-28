//
//  Item.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//
import Foundation

enum ItemEffect: Codable {
    case heal(amount: Int) // cura x puntos de vida
    case boostAttack(amount: Int) // sube x puntos de ataque
    case boostDefense(amount: Int) // sube x puntos de defensa
    case fullHeal // Poción curativa máxima
    case damageEnemy(amount: Int) // Daña al enemigo en combate
}

struct Item : Identifiable, Codable {
    var id = UUID()
    var name: String
    var emoji: String
    var effect: ItemEffect
    var price: Int
    
    
    static func healthPotion() -> Item {
        Item(name: "Poción de curación menor", emoji: "🧪", effect: .heal(amount: 15), price: 10)
    }
    
    static func strengthPotion() -> Item {
        Item(name: "Poción de fuerza menor", emoji: "💪", effect: .boostAttack(amount: 3), price: 25)
    }
    
    static func defensePotion() -> Item {
        Item(name: "Poción de defensa", emoji: "🛡️", effect: .boostDefense(amount: 2), price: 20)
    }
    
    static func elixir() -> Item {
        Item(name: "Elixir mayor", emoji: "✨", effect: .fullHeal, price: 40)
    }
    
    static func bomb() -> Item {
        Item(name: "Bomba", emoji: "💣", effect: .damageEnemy(amount: 25), price: 30)
    }
}
