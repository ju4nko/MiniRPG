//
//  MainMenuView.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//

import SwiftUI

struct MainMenuView: View {
    @Environment(GameState.self) private var gameState
    var body: some View {
        VStack {
            Text("⚔️ Mini RPG")
                .font(.largeTitle)
                .bold()
            Text("Juego desarrollado por Juanjo")
                .font(.title2)
            VStack(spacing: 12) {
                Button("Nueva partida") {
                    gameState.newGame()
                }
                .buttonStyle(.borderedProminent)
                if gameState.hasSavedGame {
                    Button("Continuar") {
                        gameState.screen = .exploring
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Borrar partida") {
                        gameState.deleteSave()
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
                
            }
        }
        .padding()
    }
}

#Preview {
    MainMenuView()
        .environment(GameState())
}
