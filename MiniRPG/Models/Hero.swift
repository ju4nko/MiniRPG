//
//  Hero.swift
//  MiniRPG
//
//  Created by Juanjo on 22/06/2026.
//
import Foundation

struct Hero: Codable  {
    var name: String
    var maxHP: Int
    var currentHP: Int
    var attack: Int
    var defense: Int
    var level: Int
    var xp: Int
    var gold: Int
}

