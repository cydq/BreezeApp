//
//  Settings.swift
//  Breeze
//
//  Created by Brian Shao on 2022/07/08.
//

import Foundation

struct Settings {
    static let standard = Settings(defaults: UserDefaults.standard)
    
    let defaults: UserDefaults
    
    var theme: Theme {
        get { return Theme.get(id: defaults.string(forKey: "theme")) }
        set(v) { defaults.set(v.id, forKey: "theme") }
    }
}
