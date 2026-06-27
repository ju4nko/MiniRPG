//
//  ContentView.swift
//  ProyectoEjemplo
//
//  Created by Juanjo on 22/06/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(GameState.self) private var gameState
    // Cambio para el commit
    var body: some View {
        switch gameState.screen {
        case .mainMenu:
            MainMenuView()
        case .exploring:
            ExploreView()
        case .battle:
            BattleView()
        case .inventory:
            InventoryView()
        case .gameOver:
            GameOverView()
        }
    }
}

#Preview {
    ContentView()
        .environment(GameState())
}
