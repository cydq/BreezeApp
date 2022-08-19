import Foundation
import SwiftUI

struct Input {
    private var tokens: [Token] = []
    
    var expr: String { tokens.map { $0.expr }.reduce("", +) }
    
    var display: Text {
        var result = Text("")
        
        tokens.forEach { result = result + $0.display }
     
        return result
    }
    
    mutating func push(_ token: Token) {
        tokens.append(token)
    }
    
    mutating func pop() -> Token? {
        tokens.popLast()
    }
    
    mutating func delete() {
        let _ = pop()
    }
    
    mutating func clear() {
        tokens = []
    }
}
