//
//  ShopView.swift
//  MiniRPG
//
//  Created by Juanjo on 27/06/2026.
//

import SwiftUI

struct ShopView: View {
    @Environment(GameState.self) private var gameState
    
    private let catalog: [Item] = [.healthPotion(), .strengthPotion(), .defensePotion(), .elixir(), .bomb()]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("🛒 Tienda")
                .font(.largeTitle)
                .bold()
            Text("💰 Oro: \(gameState.hero.gold)")
                .font(.title)
            
            ForEach(catalog) { item in
                HStack {
                    Text(item.emoji).font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text(item.name).bold()
                        Text(effectDescription(item.effect))
                    }
                    Spacer()
                    Button("\(item.price) 💰") {
                        gameState.buy(item)
                    }.buttonStyle(.borderedProminent)
                        .disabled(gameState.hero.gold < item.price)
                }
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
            
            Button("← Volver") {
                gameState.screen = .exploring
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
    ShopView()
        .environment(GameState())
}
