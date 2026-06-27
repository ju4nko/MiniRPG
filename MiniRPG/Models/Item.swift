//
//  Item.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//
import Foundation

enum ItemEffect {
    case heal(amount: Int) // cura x puntos de vida
    case boostAttack(amount: Int) // sube x puntos de ataque
}

struct Item : Identifiable {
    let id = UUID()
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
}
