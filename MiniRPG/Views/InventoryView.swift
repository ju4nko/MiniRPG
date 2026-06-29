//
//  InventoryView.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//

import SwiftUI

struct InventoryView: View {
    @Environment(GameState.self) private var gameState
    
    var body: some View {
        VStack(spacing: 16) {
            Text("🎒 Inventario")
                .font(.largeTitle)
                .bold()
            if gameState.inventory.isEmpty {
                Text("Inventario vacío")
                    .font(.largeTitle)
                    .bold()
            } else {
                ForEach(Array(gameState.inventory.enumerated()), id: \.offset) { index, item in
                    HStack {
                        Text(item.emoji)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(item.name).bold()
                            Text(effectDescription(item.effect))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Usar") {
                            gameState.useItem(at: index)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10))
                    
                }
                

            }
            
            Spacer()
            
            Button("← Volver") {
                gameState.screen = gameState.currentEnemy != nil ? .battle : .exploring
            }
           
        }
        .padding()
        .gameBackground()
    }
    
    private func effectDescription(_ effect: ItemEffect) -> String {
        switch effect {
        case .heal(let amount): return "Cura \(amount) HP"
        case .boostAttack(let amount): return "+\(amount) ATK"
        case .boostDefense(let amount): return "+\(amount) DEF"
        case .fullHeal: return "Cura toda la vida"
        case .damageEnemy(let amount): return "Daña \(amount) al enemigo"
        }
    }
}

#Preview {
    InventoryView()
        .environment(GameState())
}
