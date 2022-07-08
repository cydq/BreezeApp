import SwiftUI

struct Theme {
    // Theme
    let id: String
    var name: String = "Theme"
    
    var background: Color { Color("\(id)BackgroundColor") }
    var backgroundDisplay: Color { Color("\(id)BackgroundColorDisplay") }
    var primary: Color { Color("\(id)ColorPrimary") }
    var textAccent: Color { Color("\(id)TextColorAccent") }
    var textHighlight: Color { Color("\(id)TextColorHighlight") }
    var textPrimary: Color { Color("\(id)TextColorPrimary") }
    
    // Static
    static let themes: [Theme] = [
        Theme(id: "Green", name: "Green")
    ]

    static func get(name: String?) -> Theme {
        themes.first { t in t.name == name } ?? themes[0]
    }

    static func get(id: String?) -> Theme {
        themes.first { t in t.id == id } ?? themes[0]
    }
}
