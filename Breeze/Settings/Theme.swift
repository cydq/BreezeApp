//
//  Theme.swift
//  Breeze
//
//  Created by Brian Shao on 2022/07/07.
//

import Foundation
import SwiftUI

struct Theme {
    // Theme
    let id: String
    var name: String = "Theme"
    
    var background: Color {
        return Color("\(id)BackgroundColor")
    }
    
    var backgroundDisplay: Color {
        return Color("\(id)BackgroundColorDisplay")
    }
    
    var primary: Color {
        return Color("\(id)ColorPrimary")
    }
    
    var textAccent: Color {
        return Color("\(id)TextColorAccent")
    }
    
    var textHighlight: Color {
        return Color("\(id)TextColorHighlight")
    }
    
    var textPrimary: Color {
        return Color("\(id)TextColorPrimary")
    }
    
    // Static
    static let themes: [Theme] = [
        Theme(id: "Green", name: "Green")
    ]

    static func get(name: String?) -> Theme {
        return themes.first { t in t.name == name } ?? themes[0]
    }

    static func get(id: String?) -> Theme {
        return themes.first { t in t.id == id } ?? themes[0]
    }
}
