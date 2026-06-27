//
//  GameOverView.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//

import SwiftUI

struct GameOverView: View {
    @Environment(GameState.self) private var gameState
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("☠️")
                .font(.system(size: 120))
            Text("Has muerto paquete")
                .bold()
                .font(.largeTitle)
            VStack(spacing: 8) {
                Text("Nivel alcanzado: \(gameState.hero.level)")
                Text("XP acumulada: \(gameState.hero.xp)")
                Text("Objetos restantes: \(gameState.inventory.count)")
            }
            .font(.title3)
            .foregroundStyle(.secondary)
            VStack(spacing: 12) {
                Spacer()
                Button("🔁 Nueva partida") {
                    gameState.newGame()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                Button("🏠 Volver al menú") {
                    gameState.returnToMenu()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.9))
        .foregroundStyle(.white)
        
    }
       
    
}

#Preview {
    GameOverView()
        .environment(GameState())
}
