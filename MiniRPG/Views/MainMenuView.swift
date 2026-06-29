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
        VStack(spacing: 20) {
            Spacer()
            
            Text("⚔️ Mini RPG")
                .font(.largeTitle)
                .bold()
            Text("Juego desarrollado por Juanjo")
                .font(.title2)
            Spacer()
            VStack(spacing: 12) {
                Button("Nueva partida") {
                    gameState.newGame()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .frame(maxWidth: 260)
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
                
                Button {
                    SoundManager.shared.isEnabled.toggle()
                } label: {
                    Image(systemName: SoundManager.shared.isEnabled ? "speaker.wave.2.fill" : "speaker.slash.fill")
                }
                
            }
            Spacer()
        }
        .padding()
        .gameBackground()
        
        
    }
}

#Preview {
    MainMenuView()
        .environment(GameState())
}
