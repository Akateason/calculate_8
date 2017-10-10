//
//  ViewController.swift
//  Calculator
//
//  Created by teason on 2017/10/8.
//  Copyright © 2017年 teason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    var ifUserIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle! // ! 是对 option类型的解包。若nil， 会crash.
        // print("digit = \(String(describing: digit))")
        
        if ifUserIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            ifUserIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        if ifUserIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation() { $0 * $1 }
        case "÷": performOperation   { $1 / $0 }
        case "+": performOperation   { $0 + $1 }
        case "−": performOperation() { $1 - $0 }
        case "√": performOperation() { sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double,Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation( operandStack.removeLast() , operandStack.removeLast() )
            enter()
        }
    }

    func performOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation( operandStack.removeLast() )
            enter()
        }
    }
    
//    func multiply(op1: Double, op2: Double) ->Double {
//        return op1 * op2
//    }
    
    //    var operandStack :Array<Double> = Array<Double>()
    var operandStack = Array<Double>()
    @IBAction func enter() {
        ifUserIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return (display.text! as NSString).doubleValue
        }
        set {
            display.text = "\(newValue)"
            ifUserIsInTheMiddleOfTypingANumber = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

