//
//  Token.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-03.
//

import Foundation

enum Token: String {
    // Digits
    case zero = "0", one = "1", two = "2", three = "3", four = "4"
    case five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    
    case e = "e", pi = "pi", phi = "phi", tau = "tau"
    
    // Prefix
    // case negative = "-"
    case sqrt = "-<", cbrt = "--<"
    case antiln = "->", antilog = "-->", antilog2 = "--->"
    
    // Infix
    case plus = "+", times = "*", minus = "-", divide = "/"
    case exp = "^", ee = "$ee$"
    
    // Postfix
    case factorial = "!"
    case square = "$square$", cube = "$cube$"
    case reciprocal = "$reciprocal$"
    case percent = "%"
    
    // Functions
    case log, log2, ln, logn
    case nthroot
    case sin, cos, tan, asin, acos, atan, atan2
    case sinh, cosh, tanh, asinh, acosh, atanh
    case rand
    case sum, product
    case count
    case min, max
    case mean, median, mode, stddev
    
    // Misc.
    case dot = ".", comma = ","
    case open = "(", close = ")"
    
    var rawValueFn: String {
        return "\(rawValue)("
    }
}
