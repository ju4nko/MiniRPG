//
//  VictoryView.swift
//  MiniRPG
//
//  Created by Juanjo on 28/06/2026.
//

import SwiftUI

struct VictoryView: View {
    @Environment(GameState.self) private var gameState
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("🏆")
                .font(.system(size: 120))
            Text("¡VICTORIA!")
                .font(.largeTitle)
                .bold()
            VStack(spacing: 8) {
                Text("Nivel alcanzado: \(gameState.hero.level)")
                Text("XP acumulada: \(gameState.hero.xp)")
                Text("Oro ganado: \(gameState.hero.gold)")
            }
            Spacer()
            .font(.title3)
            .foregroundStyle(.white.opacity(0.85))
            Button("Jugar de nuevo") {
                gameState.newGame()
            }
            .buttonStyle(.borderedProminent)
            Button("Menu principal") {
                gameState.returnToMenu()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.opacity(0.9))
        .foregroundStyle(.white)
    }
}

#Preview {
    VictoryView()
        .environment(GameState())
}
