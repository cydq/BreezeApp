//
//  InputToken.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-01.
//

import Foundation

enum InputToken {
    // 0-9
    case digit(Int)
    
    // Used for expression parsing
    case _literal(Double, decimal: Int)
    case _expression(Expression)
    
    // Constants
    case constant(Constant)
    enum Constant {
        case e
        case pi
        case phi
        case tau
        
        var value: Double {
            switch self {
            case .e:
                return 2.71828182845904523536028747135266249775724709369995
            case .pi:
                return 3.14159265358979323846264338327950288419716939937510
            case .phi:
                return 1.6180339887498948482045868343656381177203091798058
            case .tau:
                return 6.28318530717958647692528676655900576839433879875021
            }
        }
    }
    
    // Operations
    case operation(Operation)
    
    // Misc.
    case dot
    case comma
    case openParen
    case closeParen
}

enum Operation {
    // Operators
    case prefix(Prefix)
    enum Prefix {
        case negative
        case sqrt
        case cbrt
        case antiln
        case antilog
        case antilog2
    }

    case infix(Infix)
    enum Infix {
        case plus
        case times
        case minus
        case divide
        case exp
        case ee
        
    }

    case postfix(Postfix)
    enum Postfix {
        case factorial
        case square
        case cube
        case reciprocal
        case percent
    }

    // Functions
    case function(Function)
    enum Function {
        case log, log2, ln, logn
        case nthroot
        case sin, cos, tan, asin, acos, atan, atan2
        case sinh, cosh, tanh, asinh, acosh, atanh
        case rand
        case sum, product
        case count
        case min, max
        case mean, median, mode, stddev
    }
}
