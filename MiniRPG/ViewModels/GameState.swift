//
//  GameState.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//
import Foundation
import SwiftUI
import SwiftData

enum GameScreen {
    case mainMenu
    case exploring
    case battle
    case inventory
    case shop
    case gameOver
    case victory
}

@Observable
class GameState {
    var screen: GameScreen = .mainMenu
    var hero: Hero = Hero(name: "Cloud", maxHP: 30, currentHP: 30, attack: 6, defense: 2, level: 1, xp: 0, gold: 0, maxMana: 10, mana: 10)
    var currentEnemy: Enemy? = nil
    var inventory: [Item] = [.healthPotion(), .healthPotion(), .strengthPotion()]
    var battleLog: [String] = []
    var critChance: Double = 0.2
    var lastAttackWasCritical = false
    var dodgeChance: Double = 0.15
    
    var modelContext: ModelContext? = nil
    private var saveGame: SaveGame? = nil
    
    var hasSavedGame: Bool {
        saveGame != nil
    }
    
    func startBattle() {
        let possibleEnemies : [Enemy]
        switch hero.level {
        case 1...2:
            possibleEnemies = [.rat(), .goblin(), .slime()]
        case 3...4:
            possibleEnemies = [.goblin(), .skeleton(), .wolf(), .slime()]
        default:
            possibleEnemies = [.wolf(), .orc(), .dragon()]
        }
        currentEnemy = possibleEnemies.randomElement()
        battleLog = ["¡Un \(currentEnemy?.name ?? "enemigo") aparece!"]
        screen = .battle
    }
    
    func startBossBattle() {
        currentEnemy = .finalBoss()
        battleLog = ["⚠️ ¡El Señor del Caos ha aparecido!"]
        screen = .battle
    }
    
    func heroAttack() {
        guard var enemy = currentEnemy else { return }
        
        var damage = max(1, hero.attack - enemy.defense)
        let isCrit = Double.random(in: 0...1) < critChance
        lastAttackWasCritical = isCrit
        if isCrit {
            damage *= 2
            battleLog.append("💥 ¡CRÍTICO! Haces \(damage) de daño.")
        } else {
            battleLog.append("⚔️ Atacas y haces \(damage) de daño.")
        }
        enemy.currentHP -= damage
        SoundManager.shared.play(.attack)
        
        hero.mana = min(hero.maxMana, hero.mana + 2)
        
        if enemy.currentHP <= 0 {
            defeatEnemy(enemy)
            return
        }
        
        currentEnemy = enemy
        enemyAttack()
        
    }
    
    func defeatEnemy(_ enemy: Enemy) {
        battleLog.append("🏆 ¡Has derrotado a \(enemy.name)! +\(enemy.xpReward) XP +\(enemy.goldReward) 💰")
        SoundManager.shared.play(.victory)
        hero.xp += enemy.xpReward
        hero.gold += enemy.goldReward
        let wasBoss = enemy.isBoss
        currentEnemy = nil
        checkLevelUp()
        save()
        if wasBoss {
            screen = .victory
        }
        
    }
    
    func enemyAttack() {
        guard let enemy = currentEnemy else { return }
        
        let dodged = Double.random(in: 0...1) < dodgeChance
        if dodged {
            battleLog.append("🤸 ¡Esquivas el ataque de \(enemy.name)!")
            return                              // ← sales: 0 daño, no compruebas muerte
        }
        let damage = max(1, enemy.attack - hero.defense)
        hero.currentHP -= damage
        battleLog.append("💥 \(enemy.name) te golpea por \(damage).")
        
        if hero.currentHP <= 0 {
            hero.currentHP = 0
            battleLog.append("☠️ Has caído derrotado...")
            SoundManager.shared.play(.defeat)
            screen = .gameOver
            deleteSave()
        }
    }
    
    func castSpell() {
        guard var enemy = currentEnemy else { return }
        
        let cost = 5
        guard hero.mana >= cost else {
            battleLog.append("🔮 No tienes maná suficiente.")
            return
        }
        
        hero.mana -= cost
        let damage = hero.attack * 2 + 5
        enemy.currentHP -= damage
        battleLog.append("🔮 Lanzas un hechizo y haces \(damage) de daño.")
        SoundManager.shared.play(.levelUp)
        currentEnemy = enemy
        
        if enemy.currentHP <= 0 {
            defeatEnemy(enemy)
            return
        }
        
        enemyAttack()
    }
    
    func checkLevelUp() {
        let xpNeeded = hero.level * 20
        if hero.xp >= xpNeeded {
            hero.level += 1
            hero.xp -= xpNeeded
            hero.maxHP += 5
            hero.currentHP = hero.maxHP
            hero.mana = hero.maxMana
            hero.attack += 2
            hero.defense += 1
            battleLog.append("🌟 ¡Has subido al nivel \(hero.level)!")
            SoundManager.shared.play(.levelUp)
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
        case .boostDefense(let amount):
            hero.defense += amount
            battleLog.append("🛡️ Usas \(item.name). +\(amount) de defensa.")
        case .fullHeal:
            let healed = hero.maxHP - hero.currentHP
            hero.currentHP = hero.maxHP
            battleLog.append("✨ Usas \(item.name). Recuperas \(healed) HP.")
        case .damageEnemy(let amount):
            if var enemy = currentEnemy {
                enemy.currentHP -= amount
                battleLog.append("💣 Usas \(item.name). Haces \(amount) de daño a \(enemy.name).")
                SoundManager.shared.play(.attack)
                currentEnemy = enemy
                if enemy.currentHP <= 0 {
                    defeatEnemy(enemy)
                }
            } else {
                battleLog.append("💣 No hay enemigo al que atacar.")
            }
        }
    
        inventory.remove(at: index)
        
        if currentEnemy != nil {
            enemyAttack()
        }
        save()
    }
    
    func returnToMenu() {
        screen = .mainMenu
    }
    
    func newGame() {
        hero = Hero(name: "Cloud", maxHP: 30, currentHP: 30, attack: 6, defense: 2, level: 1, xp: 0, gold: 0, maxMana: 10, mana: 10)
        currentEnemy = nil
        inventory = [.healthPotion(), .healthPotion(), .strengthPotion()]
        battleLog = []
        screen = .exploring
        save()
    }
    
    func buy(_ item: Item) {
        guard hero.gold >= item.price else { return }
        hero.gold -= item.price
        inventory.append(item)
        SoundManager.shared.play(.coin)
        save()
    }
    
    func configure(_ context: ModelContext) {
        modelContext = context
        load()
    }
    
    func load() {
        guard let modelContext else { return }
        let descriptor = FetchDescriptor<SaveGame>()
        if let existing = try? modelContext.fetch(descriptor).first {
            saveGame = existing
            hero = existing.hero
            inventory = existing.inventory
        }
    }
    
    func save() {
        guard let modelContext else { return }
        if let saveGame {
            saveGame.hero = hero
            saveGame.inventory = inventory
            saveGame.updatedAt = Date()
        } else {
            let newSave = SaveGame(hero: hero, inventory: inventory, updatedAt: Date())
            modelContext.insert(newSave)
            saveGame = newSave
        }
        try? modelContext.save()
    }
    
    func deleteSave() {
        guard let modelContext else { return }
        if let saveGame {
            modelContext.delete(saveGame)
            try? modelContext.save()
            self.saveGame = nil
        }
    }
}

