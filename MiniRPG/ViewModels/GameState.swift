//
//  GameState.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//
import Foundation
import SwiftUI

enum GameScreen {
    case mainMenu
    case exploring
    case battle
    case inventory
    case shop
    case gameOver
}

@Observable
class GameState {
    var screen: GameScreen = .mainMenu
    var hero: Hero = Hero(name: "Cloud", maxHP: 30, currentHP: 30, attack: 6, defense: 2, level: 1, xp: 0, gold: 0)
    var currentEnemy: Enemy? = nil
    var inventory: [Item] = [.healthPotion(), .healthPotion(), .strengthPotion()]
    var battleLog: [String] = []
    
    
    func startBattle() {
        let possibleEnemies = [Enemy.goblin(), Enemy.skeleton(), Enemy.wolf()]
        currentEnemy = possibleEnemies.randomElement()
        battleLog = ["¡Un \(currentEnemy?.name ?? "enemigo") aparece!"]
        screen = .battle
    }
    
    func heroAttack() {
        guard var enemy = currentEnemy else { return }
        
        let damage = max(1, hero.attack - enemy.defense)
        enemy.currentHP -= damage
        battleLog.append("⚔️ Atacas y haces \(damage) de daño.")
        
        if enemy.currentHP <= 0 {
            battleLog.append("🏆 ¡Has derrotado a \(enemy.name)! +\(enemy.xpReward) XP +\(enemy.goldReward) 💰")
            hero.xp += enemy.xpReward
            hero.gold += enemy.goldReward
            currentEnemy = nil
            checkLevelUp()
            return
        }
        
        currentEnemy = enemy
        enemyAttack()
        
    }
    
    func enemyAttack() {
        guard let enemy = currentEnemy else { return }
        
        let damage = max(1, enemy.attack - hero.defense)
        hero.currentHP -= damage
        battleLog.append("💥 \(enemy.name) te golpea por \(damage).")
        
        if hero.currentHP <= 0 {
            hero.currentHP = 0
            battleLog.append("☠️ Has caído derrotado...")
            screen = .gameOver
        }
    }
    
    func checkLevelUp() {
        let xpNeeded = hero.level * 20
        if hero.xp >= xpNeeded {
            hero.level += 1
            hero.xp -= xpNeeded
            hero.maxHP += 5
            hero.currentHP = hero.maxHP
            hero.attack += 2
            hero.defense += 1
            battleLog.append("🌟 ¡Has subido al nivel \(hero.level)!")
        }
    }
    
    func flee() {
        let escaped = Bool.random()
        if escaped {
            battleLog.append("💨 ¡Has huido con éxito!")
            currentEnemy = nil
            screen = .exploring
        } else {
            battleLog.append("😰 ¡No has podido escapar!")
            enemyAttack()
        }
    }
    
    func useItem(at index: Int) {
        guard index < inventory.count else { return }
        let item = inventory[index]
        
        switch item.effect {
        case .heal(let amount):
            let healed = min(amount, hero.maxHP - hero.currentHP)
            hero.currentHP += healed
            battleLog.append("🧪 Usas \(item.name). Recuperas \(healed) HP.")
        case .boostAttack(let amount):
            hero.attack += amount
            battleLog.append("💪 Usas \(item.name). +\(amount) de ataque.")
        }
        
        inventory.remove(at: index)
        
        if currentEnemy != nil {
            enemyAttack()
        }
    }
    
    func returnToMenu() {
        screen = .mainMenu
    }
    
    func newGame() {
        hero = Hero(name: "Cloud", maxHP: 30, currentHP: 30, attack: 6, defense: 2, level: 1, xp: 0, gold: 0)
        currentEnemy = nil
        inventory = [.healthPotion(), .healthPotion(), .strengthPotion()]
        battleLog = []
        screen = .exploring
    }
    
    func buy(_ item: Item) {
        guard hero.gold >= item.price else { return }
        hero.gold -= item.price
        inventory.append(item)
    }
}

