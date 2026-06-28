//
//  SoundManager.swift
//  MiniRPG
//
//  Created by Juanjo on 28/06/2026.
//
import AudioToolbox

enum GameSound: SystemSoundID {
    case attack  = 1104    // "Tock" corto
    case coin    = 1057    // "Tink" (compra)
    case victory = 1327    // "Fanfare" (derrotar enemigo)
    case levelUp = 1333    // "Spell" (subir nivel)
    case defeat  = 1326    // "Descent" (morir)
}

final class SoundManager {
    static let shared = SoundManager()
    private init() {}
    
    var isEnabled = true
    
    func play(_ sound: GameSound) {
        guard isEnabled else { return }
        AudioServicesPlaySystemSound(sound.rawValue)
    }
}



