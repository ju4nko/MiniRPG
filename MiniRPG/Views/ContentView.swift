//
//  ContentView.swift
//  ProyectoEjemplo
//
//  Created by Juanjo on 22/06/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(GameState.self) private var gameState
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        Group {
            switch gameState.screen {
            case .mainMenu: MainMenuView()
            case .exploring: ExploreView()
            case .battle: BattleView()
            case .inventory: InventoryView()
            case .gameOver: GameOverView()
            case .shop: ShopView()
            }
        }
        .task {
            gameState.configure(modelContext)
        }
    }
}

#Preview {
    ContentView()
        .environment(GameState())
}
