//
//  Evaluator.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-03.
//

import Expression
import Foundation

let e   = 2.71828182845904523536028747135266249775724709369995
let pi  = 3.14159265358979323846264338327950288419716939937510
let phi = 1.6180339887498948482045868343656381177203091798058
let tau = 6.28318530717958647692528676655900576839433879875021

func expression(expr: String) -> Expression {
    return Expression(Expression.parse(expr), pureSymbols: { symbol in
        switch symbol {
        
        // Variables
        case .variable(Token.e.rawValue):
            return { _ in return e }
        case .variable(Token.pi.rawValue):
            return { _ in return pi }
        case .variable(Token.phi.rawValue):
            return { _ in return phi }
        case .variable(Token.tau.rawValue):
            return { _ in return tau }
            
        // Prefix
        case .prefix(Token.sqrt.rawValue):
            return { a in return sqrt(a[0]) }
        case .prefix(Token.cbrt.rawValue):
            return { a in return pow(a[0], 1.0 / 3)}
        case .prefix(Token.antiln.rawValue):
            return { a in return pow(e, a[0]) }
        case .prefix(Token.antilog.rawValue):
            return { a in return pow(10, a[0]) }
        case .prefix(Token.antilog2.rawValue):
            return { a in return pow(2, a[0]) }
        case .prefix(Token.minus.rawValue):
            return { a in return a[0] * -1.0 }
            
        // Infix
        case .infix(Token.plus.rawValue):
            return { a in return a[0] + a[1] }
        case .infix(Token.times.rawValue):
            return { a in return a[0] * a[1] }
        case .infix(Token.minus.rawValue):
            return { a in return a[0] - a[1] }
        case .infix(Token.divide.rawValue):
            return { a in return a[0] / a[1] }
        case .infix(Token.exp.rawValue):
            return { a in return pow(a[0], a[1]) }
        case .infix(Token.ee.rawValue):
            return { a in return a[0] * pow(10, a[1]) }
            
        // Posftix
        case .postfix(Token.factorial.rawValue):
            return { a in return (1...Int(a[0])).map(Double.init).reduce(1.0, *) }
        case .postfix(Token.square.rawValue):
            return { a in return pow(a[0], 2) }
        case .postfix(Token.cube.rawValue):
            return { a in return pow(a[0], 3) }
        case .postfix(Token.reciprocal.rawValue):
            return { a in return 1 / a[0] }
        case .postfix(Token.percent.rawValue):
            return { a in return a[0] * 0.01 }
            
        // Functions
        case .function(Token.log.rawValue, arity: 1):
            return { a in return log10(a[0]) }
        case .function(Token.log2.rawValue, arity: 1):
            return { a in return log2(a[0]) }
        case .function(Token.ln.rawValue, arity: 1):
            return { a in return log(a[0]) }
        case .function(Token.logn.rawValue, arity: 2):
            return { a in return log(a[0]) / log(a[1]) }
        case .function(Token.nthroot.rawValue, arity: 2):
            return { a in return pow(a[0], 1 / a[1]) }
            
        case .function(Token.sin.rawValue, arity: 1):
            return { a in return sin(a[0]) }
        case .function(Token.cos.rawValue, arity: 1):
            return { a in return cos(a[0]) }
        case .function(Token.tan.rawValue, arity: 1):
            return { a in return tan(a[0]) }
        case .function(Token.asin.rawValue, arity: 1):
            return { a in return asin(a[0]) }
        case .function(Token.acos.rawValue, arity: 1):
            return { a in return acos(a[0]) }
        case .function(Token.atan.rawValue, arity: 1):
            return { a in return atan(a[0]) }
        case .function(Token.atan2.rawValue, arity: 2):
            return { a in return atan2(a[0], a[1]) }
            
        case .function(Token.sinh.rawValue, arity: 1):
            return { a in return sinh(a[0]) }
        case .function(Token.cosh.rawValue, arity: 1):
            return { a in return cosh(a[0]) }
        case .function(Token.tanh.rawValue, arity: 1):
            return { a in return tanh(a[0]) }
        case .function(Token.asinh.rawValue, arity: 1):
            return { a in return asinh(a[0]) }
        case .function(Token.acosh.rawValue, arity: 1):
            return { a in return acosh(a[0]) }
        case .function(Token.atanh.rawValue, arity: 1):
            return { a in return atanh(a[0]) }
            
        case .function(Token.rand.rawValue, arity: 2):
            return { a in
                let low = Int(a[0].rounded(.up))
                let high = Int(a[1].rounded(.down))
                
                return low > high
                    ? Double.nan
                    : Double(Int.random(in: low...high))
            }
        
        case .function(Token.sum.rawValue, arity: _):
            return { a in return a.count < 1 ? Double.nan : a.reduce(0, +) }
        case .function(Token.product.rawValue, arity: _):
            return { a in return a.count < 1 ? Double.nan : a.reduce(1, *) }
        case .function(Token.count.rawValue, arity: _):
            return { a in return a.count < 1 ? Double.nan : Double(a.count) }
        
        case .function(Token.min.rawValue, arity: _):
            return { a in return a.count < 1 ? Double.nan : a.min() ?? Double.nan }
        case .function(Token.max.rawValue, arity: _):
            return { a in return a.count < 1 ? Double.nan : a.max() ?? Double.nan }
            
        case .function(Token.mean.rawValue, arity: _):
            return { a in return a.count < 1 ? Double.nan : a.reduce(0, +) / Double(a.count) }
        case .function(Token.median.rawValue, arity: _):
            return { a in return a.count < 1 ? Double.nan : calculateMedian(array: a) }
        case .function(Token.mode.rawValue, arity: _):
            return { a in
                if a.count < 1 {
                    return Double.nan
                }
                let set = NSCountedSet(array: a)
                return set.max { set.count(for: $0) < set.count(for: $1) } as! Double
            }
        case .function(Token.stddev.rawValue, arity: _):
            return { a in
                if a.count < 1 {
                    return Double.nan
                }
                let mean = a.reduce(0, +) / Double(a.count)
                let v = a.reduce(0, { $0 + ($1-mean)*($1-mean) })
                return sqrt(v / (Double(a.count) - 1))
            }
        
        // Default
        default:
            return { _ in throw Expression.Error.undefinedSymbol(symbol) }
        }
    })
}

func evaluate(expr: String) -> Double? {
    do {
        return try expression(expr: expr).evaluate()
    } catch {
        return nil
    }
}

func evaluate(expr: String) -> String {
    do {
        return try String(expression(expr: expr).evaluate())
    } catch {
        return "\(error)"
    }
}

func evaluateOr(expr: String, err: String = "Error") -> String {
    if expr == "" {
        return ""
    }
    
    do {
        return try String(expression(expr: expr).evaluate())
    } catch {
        return err
    }
}

private func calculateMedian(array: [Double]) -> Double {
    let sorted = array.sorted()
    if sorted.count % 2 == 0 {
        return Double((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
    } else {
        return Double(sorted[(sorted.count - 1) / 2])
    }
}
