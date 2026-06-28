//
//  SaveGame.swift
//  MiniRPG
//
//  Created by Juanjo on 28/06/2026.
//
import Foundation
import SwiftData

@Model
final class SaveGame {
    var hero: Hero
    var inventory: [Item]
    var updatedAt: Date
    
    init(hero: Hero, inventory: [Item], updatedAt: Date) {
        self.hero = hero
        self.inventory = inventory
        self.updatedAt = updatedAt
    }
}
