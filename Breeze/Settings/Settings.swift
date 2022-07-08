import Foundation

struct Settings {
    static let standard = Settings(defaults: UserDefaults.standard)
    
    let defaults: UserDefaults
    
    var theme: Theme {
        get { Theme.get(id: defaults.string(forKey: "theme")) }
        set(v) { defaults.set(v.id, forKey: "theme") }
    }
}
