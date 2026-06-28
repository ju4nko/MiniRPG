//
//  BattleView.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//
import SwiftUI

struct BattleView: View {
    @Environment(GameState.self) private var gameState
    @State private var enemyShake: CGFloat = 0
    @State private var heroFlash: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            if let enemy = gameState.currentEnemy {
                enemyPanel(enemy)
                    .offset(x: enemyShake)
            }
            
            battleLog
            
            heroPanel
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.red)
                        .opacity(heroFlash ? 0.5: 0)
                }
            
            actionButtons
            
            Button(" <- Volver") {
                gameState.screen = .exploring
            }.buttonStyle(.borderedProminent)
                .tint(.green)
            .disabled(gameState.currentEnemy != nil)
        }
        .padding()
        .onChange(of: gameState.hero.currentHP) { oldValue, newValue in
            if newValue < oldValue {
                flashHero()
            }
        }
    }
    
    private func enemyPanel(_ enemy: Enemy) -> some View {
        VStack(spacing: 8) {
            Text(enemy.emoji)
                .font(.system(size: 80))
            Text(enemy.name)
                .font(.title2)
                .bold()
            ProgressView(value: Double(enemy.currentHP), total: Double(enemy.maxHP))
                .tint(.red)
            Text("❤️ \(enemy.currentHP) / \(enemy.maxHP)")
                .font(.caption)
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
    
    private var battleLog: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(Array(gameState.battleLog.enumerated()), id: \.offset) { index, line in
                        Text(line)
                            .font(.callout)
                            .id(index)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            }
            .frame(height: 120)
            .background(.black.opacity(0.05), in: RoundedRectangle(cornerRadius: 8))
            .onChange(of: gameState.battleLog.count) { _, _ in
                if let last = gameState.battleLog.indices.last {
                    withAnimation { proxy.scrollTo(last, anchor: .bottom) }
                }
            }
        }
    }
    
    private var heroPanel: some View {
        VStack(spacing: 6) {
            Text("\(gameState.hero.name) — Nv. \(gameState.hero.level)")
                .font(.headline)
            ProgressView(value: Double(gameState.hero.currentHP), total: Double(gameState.hero.maxHP))
                .tint(.green)
            Text("❤️ \(gameState.hero.currentHP) / \(gameState.hero.maxHP)")
                .font(.caption)
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
    
    private var actionButtons: some View {
        HStack(spacing: 12) {
            Button("⚔️ Atacar") {
                gameState.heroAttack()
                shakeEnemy()
            }
            .buttonStyle(.borderedProminent)
            
            Button("🧪 Inventario") {
                gameState.screen = .inventory
            }
            .buttonStyle(.bordered)
            
            Button("💨 Huir") {
                gameState.flee()
            }
            .buttonStyle(.bordered)
            .tint(.orange)
        }
    }
    
    private func shakeEnemy() {
        Task {
            for offset in [-12.0, 12.0, -8.0, 8.0, 0.0] {
                withAnimation(.linear(duration: 0.05)) {
                    enemyShake = offset
                }
                try? await Task.sleep(for: .milliseconds(50))
            }
        }
    }
    
    private func flashHero() {
        withAnimation(.easeIn(duration: 0.08)) {
            heroFlash = true
        }
        Task {
            try? await Task.sleep(for: .milliseconds(120))
            withAnimation(.easeOut(duration: 0.2)) {
                heroFlash = false
            }
        }
    }
}


#Preview {
    let state = GameState()
    state.currentEnemy = .goblin()
    state.battleLog = ["¡Un Goblin aparece!", "⚔️ Atacas y haces 3 de daño."]
    return BattleView()
        .environment(state)
}
