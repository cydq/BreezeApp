import Expression
import Foundation

let e   = 2.71828182845904523536028747135266249775724709369995
let pi  = 3.14159265358979323846264338327950288419716939937510
let phi = 1.6180339887498948482045868343656381177203091798058
let tau = 6.28318530717958647692528676655900576839433879875021

func expression(expr: String) -> Expression {
    Expression(Expression.parse(expr), pureSymbols: { symbol in
        switch symbol {
        
        // Variables
        case .variable(SymbolToken.e.expr):
            return { _ in e }
        case .variable(SymbolToken.pi.expr):
            return { _ in pi }
        case .variable(SymbolToken.phi.expr):
            return { _ in phi }
        case .variable(SymbolToken.tau.expr):
            return { _ in tau }
            
        // Prefix
        case .prefix(PrefixToken.sqrt.expr):
            return { a in sqrt(a[0]) }
        case .prefix(PrefixToken.cbrt.expr):
            return { a in pow(a[0], 1.0 / 3) }
        case .prefix(PrefixToken.antiln.expr):
            return { a in pow(e, a[0]) }
        case .prefix(PrefixToken.antilog.expr):
            return { a in pow(10, a[0]) }
        case .prefix(PrefixToken.antilog2.expr):
            return { a in pow(2, a[0]) }
        case .prefix(InfixToken.minus.expr):
            return { a in a[0] * -1.0 }
            
        // Infix
        case .infix(InfixToken.plus.expr):
            return { a in a[0] + a[1] }
        case .infix(InfixToken.times.expr):
            return { a in a[0] * a[1] }
        case .infix(InfixToken.minus.expr):
            return { a in a[0] - a[1] }
        case .infix(InfixToken.divide.expr):
            return { a in a[0] / a[1] }
        case .infix(InfixToken.exp.expr):
            return { a in pow(a[0], a[1]) }
        case .infix(InfixToken.ee.expr):
            return { a in a[0] * pow(10, a[1]) }
            
        // Posftix
        case .postfix(PostfixToken.factorial.expr):
            return { a in (1...Int(a[0])).map(Double.init).reduce(1.0, *) }
        case .postfix(PostfixToken.square.expr):
            return { a in pow(a[0], 2) }
        case .postfix(PostfixToken.cube.expr):
            return { a in pow(a[0], 3) }
        case .postfix(PostfixToken.reciprocal.expr):
            return { a in 1 / a[0] }
        case .postfix(PostfixToken.percent.expr):
            return { a in a[0] * 0.01 }
            
        // Functions
        case .function(FunctionToken.log.rawValue, arity: 1):
            return { a in log10(a[0]) }
        case .function(FunctionToken.log2.rawValue, arity: 1):
            return { a in log2(a[0]) }
        case .function(FunctionToken.ln.rawValue, arity: 1):
            return { a in log(a[0]) }
        case .function(FunctionToken.logn.rawValue, arity: 2):
            return { a in log(a[0]) / log(a[1]) }
        case .function(FunctionToken.nthroot.rawValue, arity: 2):
            return { a in pow(a[0], 1 / a[1]) }
            
        case .function(FunctionToken.sin.rawValue, arity: 1):
            return { a in sin(a[0]) }
        case .function(FunctionToken.cos.rawValue, arity: 1):
            return { a in cos(a[0]) }
        case .function(FunctionToken.tan.rawValue, arity: 1):
            return { a in tan(a[0]) }
        case .function(FunctionToken.asin.rawValue, arity: 1):
            return { a in asin(a[0]) }
        case .function(FunctionToken.acos.rawValue, arity: 1):
            return { a in acos(a[0]) }
        case .function(FunctionToken.atan.rawValue, arity: 1):
            return { a in atan(a[0]) }
        case .function(FunctionToken.atan2.rawValue, arity: 2):
            return { a in atan2(a[0], a[1]) }
            
        case .function(FunctionToken.sinh.rawValue, arity: 1):
            return { a in sinh(a[0]) }
        case .function(FunctionToken.cosh.rawValue, arity: 1):
            return { a in cosh(a[0]) }
        case .function(FunctionToken.tanh.rawValue, arity: 1):
            return { a in tanh(a[0]) }
        case .function(FunctionToken.asinh.rawValue, arity: 1):
            return { a in asinh(a[0]) }
        case .function(FunctionToken.acosh.rawValue, arity: 1):
            return { a in acosh(a[0]) }
        case .function(FunctionToken.atanh.rawValue, arity: 1):
            return { a in atanh(a[0]) }
            
        case .function(FunctionToken.rand.rawValue, arity: 2):
            return { a in
                let low = Int(a[0].rounded(.up))
                let high = Int(a[1].rounded(.down))
                
                return low > high
                    ? Double.nan
                    : Double(Int.random(in: low...high))
            }
        
        case .function(FunctionToken.sum.rawValue, arity: _):
            return { a in a.count < 1 ? Double.nan : a.reduce(0, +) }
        case .function(FunctionToken.product.rawValue, arity: _):
            return { a in a.count < 1 ? Double.nan : a.reduce(1, *) }
        case .function(FunctionToken.count.rawValue, arity: _):
            return { a in a.count < 1 ? Double.nan : Double(a.count) }
        
        case .function(FunctionToken.min.rawValue, arity: _):
            return { a in a.count < 1 ? Double.nan : a.min() ?? Double.nan }
        case .function(FunctionToken.max.rawValue, arity: _):
            return { a in a.count < 1 ? Double.nan : a.max() ?? Double.nan }
            
        case .function(FunctionToken.mean.rawValue, arity: _):
            return { a in a.count < 1 ? Double.nan : a.reduce(0, +) / Double(a.count) }
        case .function(FunctionToken.median.rawValue, arity: _):
            return { a in a.count < 1 ? Double.nan : calculateMedian(array: a) }
        case .function(FunctionToken.mode.rawValue, arity: _):
            return { a in
                if a.count < 1 {
                    return Double.nan
                }
                let set = NSCountedSet(array: a)
                return set.max { set.count(for: $0) < set.count(for: $1) } as! Double
            }
        case .function(FunctionToken.stddev.rawValue, arity: _):
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
