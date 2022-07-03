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
        
        return toExpression(literalInput)
    }
    
    private func toExpression(_ tokens: [InputToken]) -> Expression? {
        if tokens.isEmpty {
            return nil // What the hell?
        }
        
        // Recurse parentheses and functions
        var flat: [InputToken] = []
        
        var i = tokens.startIndex
        while i < tokens.endIndex {
            let token = tokens[i]
            i += 1
            
            if case .openParen = token {
                let skipped = skip(&i, tokens: tokens)
                
                guard let subExpr = toExpression(skipped) else {
                    return nil
                }
                
                flat.append(._expression(subExpr))
                continue
            }
            
//            if case let .operation(op) = token, case let .function(fn) = op {
//                let skipped = skip(&i, tokens: tokens)
//                flat.append(._expression(Expression.expression(<#T##Operation#>, [Expression])))
//                continue
//            }
            
            flat.append(token)
        }
        
        
        return nil
    }
    
    private func skip(_ i: inout Int, tokens: [InputToken]) -> [InputToken] {
        var sub: [InputToken] = []
        var depth = 1
        
        while depth > 1 && i < tokens.endIndex {
            let tok = tokens[i]
            sub.append(tok)
            
            if case .openParen = tok {
                depth += 1
            }
            
            if case let .operation(op) = tok, case .function(_) = op {
                depth += 1
            }
            
            if case .closeParen = tok {
                depth -= 1
            }
        }
        
        if depth == 0 {
            let _ = sub.popLast()
        }
        
        return sub
    }
    
//    private func skip
    
    func toLiteralInput() -> [InputToken]? {
        var newTokens: [InputToken] = []
        
        for token in tokens {
            if case .dot = token, case let ._literal(literal, decimal: decimal) = newTokens.last {
                if decimal > 0 {
                    return nil
                }
                
                let _ = newTokens.popLast()
                newTokens.append(._literal(literal, decimal: 1))
                continue
            }
            
            // Handle digits
            guard case let .digit(digit) = token else {
                newTokens.append(token)
                continue
            }
            
            guard case let ._literal(literal, decimal: decimal) = newTokens.last else {
                newTokens.append(._literal(Double(digit), decimal: 0))
                continue
            }
            
            let _ = newTokens.popLast()
            
            if decimal == 0 {
                newTokens.append(._literal(literal * 10 + Double(digit), decimal: 0))
                continue
            }
            
            newTokens.append(._literal(literal + Double(digit) * pow(10, -1 * Double(decimal)), decimal: decimal + 1))
        }
        
        return newTokens
    }
}
