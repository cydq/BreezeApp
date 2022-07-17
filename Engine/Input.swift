import Foundation

struct Input {
    private var tokens: [Token] = []
    
    var string: String { tokens.map { $0.expr }.reduce("", +) }
    
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
