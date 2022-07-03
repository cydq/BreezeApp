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
                guard let subExpr = toExpression(skip(&i, tokens: tokens)) else {
                    return nil
                }
                
                flat.append(._expression(subExpr))
                continue
            }
            
            if case let .operation(op) = token, case .function(_) = op {
                let skipped: [[InputToken]] = skip(&i, tokens: tokens)
                var expressions: [Expression]
                
                do {
                    try expressions = skipped.map { t in
                        guard let expression = toExpression(t) else {
                            struct e: Error {}
                            throw e()
                        }
                        
                        return expression
                    }
                } catch {
                    return nil
                }
                
                flat.append(._expression(Expression.expression(op, expressions)))
                continue
            }
            
            flat.append(token)
        }
        
        // + -
        var l1: [Expression] = []
        var current: [InputToken] = []
        
        for token in tokens {
            if case let .operation(o) = token, case let .infix(op) = o {
                if case .plus = op {
                    guard let expr = toExpression(current) else {
                        return nil
                    }
                    
                    l1.append(expr)
                    current = []
                    continue
                }
                
                if case .minus = op {
                    guard let expr = toExpression(current) else {
                        return nil
                    }
                    
                    l1.append(.expression(.prefix(.negative), [expr]))
                    current = []
                    continue
                }
            }
            
            current.append(token)
        }
        
        if (!l1.isEmpty) {
            return .expression(.infix(.plus), l1)
        }
        
        // * /
        
        var l2: [Expression] = []
        current = []
        
        for token in tokens {
            if case let .operation(o) = token, case let .infix(op) = o {
                if case .times = op {
                    guard let expr = toExpression(current) else {
                        return nil
                    }
                    
                    l2.append(expr)
                    current = []
                    continue
                }
                
                if case .divide = op {
                    guard let expr = toExpression(current) else {
                        return nil
                    }
                    
                    l2.append(.expression(.postfix(.reciprocal), [expr]))
                    current = []
                    continue
                }
            }
            
            current.append(token)
        }
        
        if (!l2.isEmpty) {
            return .expression(.infix(.times), l2)
        }
        
        // ^
        
        var l3: [Expression] = []
        current = []
        
        for token in tokens {
            if case let .operation(o) = token, case let .infix(op) = o {
                if case .exp = op {
                    guard let expr = toExpression(current) else {
                        return nil
                    }
                    
                    l3.append(expr)
                    current = []
                    continue
                }
            }
            
            current.append(token)
        }
        
        if (!l3.isEmpty) {
            return .expression(.infix(.exp), l3)
        }
        
        // Prefix
        
        // Postifx
        
        // EE
        
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
            
            i += 1
        }
        
        if depth == 0 {
            let _ = sub.popLast()
        }
        
        return sub
    }
    
    private func skip(_ i: inout Int, tokens: [InputToken]) -> [[InputToken]] {
        var subs: [[InputToken]] = []
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
            
            if depth == 0, case .comma = tok {
                subs.append(sub)
                sub = []
            }
        }
        
        if depth == 0 {
            let _ = sub.popLast()
        }
        
        return subs
    }
    
    func toLiteralInput() -> [InputToken]? {
        var newTokens: [InputToken] = []
        
        for token in tokens {
            // Handle decimal point
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
        
        var newTokens2: [InputToken] = []
        
        for token in newTokens {
            if case let .constant(c) = token {
                newTokens2.append(._literal(c.value, decimal: -1))
                continue
            }
            
            newTokens.append(token)
        }
        
        return newTokens2
    }
}
