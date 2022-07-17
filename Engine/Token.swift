import SwiftUI

enum Token {
    // Literal
    case literal(String)
    case symbol(SymbolToken)
    case prefix(PrefixToken)
    case infix(InfixToken)
    case postfix(PostfixToken)
    case function(FunctionToken)
    
    init(_ literal: String) {
        self = .literal(literal)
    }
    
    init(_ symbol: SymbolToken) {
        self = .symbol(symbol)
    }
    
    init(_ prefix: PrefixToken) {
        self = .prefix(prefix)
    }
    
    init(_ infix: InfixToken) {
        self = .infix(infix)
    }
    
    init(_ postfix: PostfixToken) {
        self = .postfix(postfix)
    }
    
    init(_ function: FunctionToken) {
        self = .function(function)
    }
    

    var expr: String {
        switch self {
        case let .literal(value):
            return value
        case let .symbol(token):
            return token.expr
        case let .prefix(token):
            return token.expr
        case let .infix(token):
            return token.expr
        case let .postfix(token):
            return token.expr
        case let .function(token):
            return token.expr
        }
    }
}

enum SymbolToken: String {
    case zero = "0", one = "1", two = "2", three = "3", four = "4"
    case five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    
    case e = "e", pi = "pi", phi = "phi", tau = "tau"
    
    case dot = ".", comma = ","
    case open = "(", close = ")"
    
    var expr: String { rawValue }
}

enum PrefixToken: String {
    case sqrt = "-<", cbrt = "--<"
    case antiln = "->", antilog = "-->", antilog2 = "--->"
    
    var expr: String { rawValue }
}

enum InfixToken: String {
    case plus = "+", times = "*", minus = "-", divide = "/"
    case exp = "^", ee = "$ee$"
    
    var expr: String { rawValue }
}

enum PostfixToken: String {
    case factorial = "!"
    case square = "$square$", cube = "$cube$"
    case reciprocal = "$reciprocal$"
    case percent = "%"
    
    var expr: String { rawValue }
}

enum FunctionToken: String {
    case log, log2, ln, logn
    case nthroot
    case sin, cos, tan, asin, acos, atan, atan2
    case sinh, cosh, tanh, asinh, acosh, atanh
    case rand
    case sum, product
    case count
    case min, max
    case mean, median, mode, stddev
    
    var expr: String { "\(rawValue)(" }
}
