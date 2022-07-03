//
//  Input.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-01.
//

import Foundation

struct Input {
    var tokens: [InputToken] = []
    
    mutating func push(_ token: InputToken) {
        tokens.append(token)
    }
    
    mutating func pop() -> InputToken? {
        return tokens.popLast()
    }
    
    func toExpression() -> Expression? {
        guard let literalInput = toLiteralInput() else {
            return nil
        }
        
        return nil
    }
    
    func toLiteralInput() -> [InputToken]? {
        var newTokens: [InputToken] = []
        
        for token in tokens {
            if case .dot = token, case let .literal(literal, decimal: decimal) = newTokens.last {
                if decimal > 0 {
                    return nil
                }
                
                let _ = newTokens.popLast()
                newTokens.append(.literal(literal, decimal: 1))
                continue
            }
            
            // Handle digits
            guard case let .digit(digit) = token else {
                newTokens.append(token)
                continue
            }
            
            guard case let .literal(literal, decimal: decimal) = newTokens.last else {
                newTokens.append(.literal(Double(digit), decimal: 0))
                continue
            }
            
            let _ = newTokens.popLast()
            
            if decimal == 0 {
                newTokens.append(.literal(literal * 10 + Double(digit), decimal: 0))
                continue
            }
            
            newTokens.append(.literal(literal + Double(digit) * pow(10, -1 * Double(decimal)), decimal: decimal + 1))
        }
        
        return newTokens
    }
}
