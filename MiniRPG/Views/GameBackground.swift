//
//  GameBackground.swift
//  MiniRPG
//
//  Created by Juanjo on 29/06/2026.
//

import SwiftUI

struct GameBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            content
                .foregroundStyle(.white)
        }
    }
}

extension View {
    func gameBackground() -> some View {
        modifier(GameBackground())
    }
}
