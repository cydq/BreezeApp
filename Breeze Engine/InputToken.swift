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
    }
    
    // Operations
    case operation(Operation)
    
    // Misc.
    case negative
    case dot
    case comma
    case openParen
    case closeParen
}

enum Operation {
    // Operators
    case prefix(Prefix)
    enum Prefix {
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
