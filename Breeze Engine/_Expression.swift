//
//  Expression.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-02.
//

import Foundation
import RealModule

indirect enum _Expression {
    case value(Double)
    case expression(Operation, [_Expression])
    
    private func evaluateExpression(op: Operation, params: [_Expression]) -> Double {
        return 1
    }
    
    func evaluate() -> Double {
        switch self {
        case .value(let v):
            return v
        case .expression(let op, let params):
            return evaluateExpression(op: op, params: params)
        }
    }
}
