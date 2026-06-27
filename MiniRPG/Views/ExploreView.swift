//
//  ExploreView.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//

import SwiftUI

struct ExploreView: View {
    @Environment(GameState.self) private var gameState
    @State private var exploreMessage: String = "Estás en un bosque oscuro..."
    
    var body: some View {
        VStack(spacing: 20) {
            // 1. Stats del héroe
            heroStats
            
            Spacer()
            
            // 2. Icono ambiental
            Text("🌲🌳🌲")
                .font(.system(size: 60))
            
            // 3. Mensaje
            Text(exploreMessage)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            // 4. Botones de acción
            actionButtons
            
        }
    }
    
    private var heroStats: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(gameState.hero.name) - Nv. \(gameState.hero.level)")
                .font(.headline)
            Text("❤️ \(gameState.hero.currentHP) / \(gameState.hero.maxHP)")
            Text("⚔️ ATK: \(gameState.hero.attack)    🛡️ DEF: \(gameState.hero.defense)")
            Text("✨ XP: \(gameState.hero.xp) / \(gameState.hero.level * 20)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
    
    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button("🗺️ Explorar") {
                explore()
            }
            .buttonStyle(.borderedProminent)
            
            Button("🎒 Inventario") {
                gameState.screen = .inventory
            }
            
            Button("🛒 Tienda") {
                gameState.screen = .shop
            }
            
            Button("🏠 Menú principal") {
                gameState.returnToMenu()
            }
            .foregroundStyle(.secondary)
            
            
        }
    }
    
    private func explore() {
        if Double.random(in: 0...1) < 0.7 {
            gameState.startBattle()
        } else {
            exploreMessage = "Caminas tranquilo. No hay rastro de enemigos..."
        }
    }
}

#Preview {
    ExploreView()
        .environment(GameState())
}
