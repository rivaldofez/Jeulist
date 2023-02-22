//
//  GameConverter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 22/02/23.
//

import Foundation

final class GameConverter {
    enum GameParentPlatform: String {
        case pc = "PC"
        case playstation = "Playstation"
        case xbox = "Xbox"
        case ios = "iOS"
        case android = "Android"
        case mac = "Apple Macintosh"
        case linux = "Linux"
        case nintendo = "Nintendo"
        case atari = "Atari"
        case amiga = "Commodore / Amiga"
        case sega = "SEGA"
        case threedo = "3DO"
        case neogeo = "Neo Geo"
        case web = "Web"
    }
    
    static func platformToIconName(input: String) -> String {
        guard let parentPlatform = GameParentPlatform(rawValue: input) else { return "unknown" }
        switch parentPlatform {
        case .pc:
            return "icon_pc"
        case .playstation:
            return "icon_playstation"
        case .xbox:
            return "icon_xbox"
        case .ios:
            return "icon_ios"
        case .android:
            return "icon_android"
        case .mac:
            return "icon_mac"
        case .linux:
            return "icon_linux"
        case .nintendo:
            return "icon_nintendo"
        case .atari:
            return "icon_atari"
        case.amiga:
            return "icon_amiga"
        case .sega:
            return "icon_sega"
        case .threedo:
            return "icon_threedo"
        case .neogeo:
            return "icon_neogeo"
        case .web:
            return "icon_web"
        }
    }
}
