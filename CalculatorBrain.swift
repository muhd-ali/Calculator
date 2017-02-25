//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Muhammadali on 12/09/2016.
//  Copyright © 2016 Muhammadali. All rights reserved.
//

import Foundation

class CalculatorBrain {
    fileprivate var accumulator = 0.0
    
    func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    fileprivate enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case BackSpace
    }
    
    fileprivate var operations: Dictionary<String, Operation> = [
        "π" : .Constant(M_PI),
        "e" : .Constant(M_E),
        "√" : .UnaryOperation(sqrt),
        "sin" : .UnaryOperation(sin),
        "+" : .BinaryOperation({ $0 + $1 }),
        "−" : .BinaryOperation({ $0 - $1 }),
        "×" : .BinaryOperation({ $0 * $1 }),
        "÷" : .BinaryOperation({ $0 / $1 }),
        "=" : .Equals,
        "⌫": .BackSpace,
        ]
    
    fileprivate func deleteCurrent() {
        accumulator = 0
    }
    
    fileprivate struct PendingOperation {
        var binaryFunction: (Double, Double) -> Double
        var firstArg: Double
        func resolve(secondArg: Double) -> Double {
            return binaryFunction(firstArg, secondArg)
        }
    }
    
    fileprivate func executePending() {
        if pending != nil {
            accumulator = pending!.resolve(secondArg: accumulator)
            pending = nil
        }
    }
    
    fileprivate var pending: PendingOperation? = nil
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePending()
                pending = PendingOperation(binaryFunction: function, firstArg: accumulator)
            case .Equals:
                executePending()
            case .BackSpace:
                deleteCurrent()
            }
        }
    }
    
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
