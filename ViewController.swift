//
//  ViewController.swift
//  Calculator
//
//  Created by Muhammadali on 12/09/2016.
//  Copyright © 2016 Muhammadali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var display: UILabel!
    
    fileprivate var middleOfTyping = false
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if middleOfTyping {
            let currentTextDisplayed = display.text!
            display.text = currentTextDisplayed + digit
        } else {
            if (digit != "0") {
                display.text = digit
                middleOfTyping = true
            }
        }
    }
    
    fileprivate var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }

    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        if middleOfTyping {
            brain.setOperand(displayValue)
        }
        middleOfTyping = false
        if let touchedOperation = sender.currentTitle {
            brain.performOperation(symbol: touchedOperation)
            displayValue = brain.result
        }
    }
    
    fileprivate var savedProgram: CalculatorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
}

