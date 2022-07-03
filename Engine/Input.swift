//
//  Input.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-03.
//

import Foundation

struct Input {
    private var tokens: [Token] = []
    
    var string: String {
        var s = ""
        
        for token in tokens {
            s += token.rawValue
        }
        
        return s
    }
    
    mutating func push(_ token: Token) {
        tokens.append(token)
    }
    
    mutating func pop() -> Token? {
        return tokens.popLast()
    }
    
    mutating func delete() {
        let _ = pop()
    }
}
