//
//  ProyectoEjemploApp.swift
//  ProyectoEjemplo
//
//  Created by Juanjo on 22/06/2026.
//

import SwiftUI

@main
struct ProyectoEjemploApp: App {
    @State private var gameState = GameState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gameState)
        }
    }
}
