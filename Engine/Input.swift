//
//  Input.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-03.
//

import Foundation

struct Input {
    private var tokens: [String] = []
    
    var string: String {
        return tokens.reduce("", +)
    }
    
    mutating func push(_ token: Token) {
        tokens.append(token.rawValue)
    }
    
    mutating func pushFn(_ token: Token) {
        tokens.append(token.rawValueFn)
    }
    
    mutating func push(_ str: String) {
        tokens.append(str)
    }
    
    mutating func pop() -> String? {
        return tokens.popLast()
    }
    
    mutating func delete() {
        let _ = pop()
    }
    
    mutating func clear() {
        tokens = []
    }
}
