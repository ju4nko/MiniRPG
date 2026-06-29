//
//  MiniRPGTests.swift
//  MiniRPGTests
//
//  Created by Juanjo on 29/06/2026.
//

import Testing
@testable import MiniRPG

struct MiniRPGTests {

    @Test func comprarRestaOroYAñadeAlInventario() {
        // 1. Preparar (Arrange)
        let game = GameState()
        game.hero.gold = 100
        let inventarioInicial = game.inventory.count
        
        // 2. Actuar (Act)
        game.buy(.healthPotion()) // Poción cuesta 10 oro
        
        // 3. Comprobar (Assert)
        #expect(game.hero.gold == 90)
        #expect(game.inventory.count == inventarioInicial + 1)
    }
    
    @Test func noPuedesComprarSinOroSuficiente() {
        let game = GameState()
        game.hero.gold = 5
        let inventarioInicial = game.inventory.count
        
        game.buy(.healthPotion())
        
        #expect(game.hero.gold == 5)
        #expect(game.inventory.count == inventarioInicial)
    }
    
    @Test func fullHealCuraAlMaximo() {
        let game = GameState()
        game.hero.currentHP = 5
        game.hero.maxHP = 30
        game.inventory = [.elixir()]
        
        game.useItem(at: 0) // Usamos el elixir, debería curarnos toda la vida
        
        #expect(game.hero.currentHP == game.hero.maxHP)
        
    }
    
    @Test func defeatEnemyDaRecompensa() {
        let game = GameState()
        game.currentEnemy = .goblin()
        let oroAntesDeDerrotarEnemigo = game.hero.gold
        
        game.defeatEnemy(.goblin())
        
        #expect(game.hero.gold == oroAntesDeDerrotarEnemigo + 5)
        
    }
    
    @Test func elDañoNuncaBajaDeUno() throws{
        let game = GameState()
        var enemigo = Enemy.dragon()
        enemigo.defense = 999
        game.currentEnemy = enemigo
        
        game.heroAttack()
        
        let enemy = try #require(game.currentEnemy)   // ← desenvuelve el ENEMIGO
        #expect(enemy.currentHP < enemy.maxHP)         // ← ahora enemy.xxx son Int normales    }
    }
    
    @Test func criticoForzadoHaceDobleDaño() throws {
        let game = GameState()
        game.critChance = 1.0
        game.hero.attack = 10
        let enemy = Enemy.dragon()
        game.currentEnemy = enemy
        
        game.heroAttack()
        
        let enemigo = try #require(game.currentEnemy)
        #expect(enemigo.currentHP == enemigo.maxHP - 10)
        
    }
    
    @Test func dañoSinCritico() throws {
        let game = GameState()
        game.critChance = 0.0
        game.hero.attack = 10
        let enemy = Enemy.dragon()
        game.currentEnemy = enemy
        
        game.heroAttack()
        
        let enemigo = try #require(game.currentEnemy)
        #expect(enemigo.currentHP == enemigo.maxHP - 5)
        
    }
}
    
