//
//  ProyectoEjemploApp.swift
//  ProyectoEjemplo
//
//  Created by Juanjo on 22/06/2026.
//

import SwiftUI
import SwiftData

@main
struct MiniRPGApp: App {
    @State private var gameState = GameState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gameState)
        }
        .modelContainer(for: SaveGame.self)
    }
}
