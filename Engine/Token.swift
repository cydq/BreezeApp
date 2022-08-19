import SwiftUI

enum Token {
    case literal(String)
    case answer
    
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
        case .answer:
            return "\(previousResult)"
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
    
    var icon: Text {
        switch self {
        case let .literal(value):
            return Text(value)
        case .answer:
            return Text("ANS")
        case let .symbol(token):
            return token.icon
        case let .prefix(token):
            return token.icon
        case let .infix(token):
            return token.icon
        case let .postfix(token):
            return token.icon
        case let .function(token):
            return token.icon
        }
    }
    
    var display: Text {
        switch self {
        case let .literal(value):
            return Text(value)
        case .answer:
            return Text("ANS")
        case let .symbol(token):
            return token.display
        case let .prefix(token):
            return token.display
        case let .infix(token):
            return token.display
        case let .postfix(token):
            return token.display
        case let .function(token):
            return token.display
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
    
    var icon: Text {
        self.display
    }
    
    var display: Text {
        switch self {
        case .pi:
            return Text("π")
        case .phi:
            return Text("φ")
        case .tau:
            return Text("τ")
        case .comma:
            return Text(", ")
        default:
            return Text(self.expr)
        }
    }
}

enum PrefixToken: String {
    case sqrt = "-<", cbrt = "--<"
    case antiln = "->", antilog = "-->", antilog2 = "--->"
    
    var expr: String { rawValue }
    
    var icon: Text {
        switch self {
        case .sqrt:
            return Text(Image(systemName: "x.squareroot"))
        default:
            return self.display
        }
    }
    
    var display: Text {
        switch self {
        case .sqrt:
            return Text("√")
        case .cbrt:
            return Text("3√")
        case .antiln:
            return Text("e^")
        case .antilog:
            return Text("10^")
        case .antilog2:
            return Text("2^")
        }
    }
}

enum InfixToken: String {
    case plus = "+", times = "*", minus = "-", divide = "/"
    case exp = "^", ee = "$ee$"
    
    var expr: String { rawValue }
    
    var icon: Text {
        self.display
    }
    
    var display: Text {
        switch self {
        case .plus:
            return Text(Image(systemName: "plus"))
        case .times:
            return Text(Image(systemName: "multiply"))
        case .minus:
            return Text(Image(systemName: "minus"))
        case .divide:
            return Text(Image(systemName: "divide"))
        case .ee:
            return Text("EE")
        default:
            return Text(self.expr)
        }
    }
}

enum PostfixToken: String {
    case factorial = "!"
    case square = "$square$", cube = "$cube$"
    case reciprocal = "$reciprocal$"
    case percent = "%"
    
    var expr: String { rawValue }
    
    var icon: Text {
        self.display
    }
    
    var display: Text {
        switch self {
        case .square:
            return Text("x²")
        case .cube:
            return Text("x³")
        case .reciprocal:
            return Text("1/x")
        case .percent:
            return Text(Image(systemName: "percent"))
        default:
            return Text(self.expr)
        }
    }
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
    var icon: Text { Text(rawValue) }
    var display: Text { Text(expr) }
}
