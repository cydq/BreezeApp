//
//  Theme.swift
//  Breeze
//
//  Created by Brian Shao on 2022/07/07.
//

import Foundation
import SwiftUI

struct Theme {
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
}

let themes: [Theme] = [
    Theme(id: "Green", name: "Green")
]

func getTheme(themeName: String?) -> Theme {
    if themeName != nil {
        for theme in themes {
            if themeName! == theme.name {
                return theme
            }
        }
    }
    return themes[0]
}

func setTheme(theme: Theme) {
    UserDefaults.standard.set(theme.name, forKey: "theme")
}

func setTheme(name: String) {
    UserDefaults.standard.set(name, forKey: "theme")
}

var currentTheme: Theme {
    return getTheme(themeName: UserDefaults.standard.string(forKey: "theme"))
}
