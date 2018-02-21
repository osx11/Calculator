//
//  ViewController.swift
//  calc
//
//  Created by admin on 07.01.2018.
//  Copyright © 2018 osxevelen_. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResult: UILabel!
    var stillTyping = false //Вводиться новое число
    var firstNubmer: Double = 0 //Первое число
    var secondNumber: Double = 0 //Второе число
    var operation: String = ""
    var dotActivePlaced = false
    var currentInput: Double {
        get {
            return Double(displayResult.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")

            if valueArray.count > 1 {
                if valueArray[1] == "0" {
                    displayResult.text = "\(valueArray[0])"
                } else {
                    displayResult.text = "\(newValue)"
                }
            } else if valueArray.count <= 1 {
                displayResult.text = "\(valueArray[0])"
            }
            
            stillTyping = false
        }
    }

    @IBAction func numberActive(_ sender: UIButton) {
    
        let number = sender.currentTitle!
        
        if stillTyping {
            if (displayResult.text?.characters.count)! < 20 {
                displayResult.text = displayResult.text! + number
            }
        } else {
            displayResult.text = number
            stillTyping = true
        }
    }
    
    @IBAction func operators(_ sender: UIButton) {
        operation = sender.currentTitle!
        
        firstNubmer = currentInput
        stillTyping = false
        dotActivePlaced = false
    }
    
    func operationInProgress(operation: (Double, Double) -> Double) {
        currentInput = operation(firstNubmer, secondNumber)
        stillTyping = false
    }
    
    @IBAction func equalsActive(_ sender: UIButton) {
        
        if stillTyping {
            secondNumber = currentInput
        }
        
        dotActivePlaced = false
        
        switch operation {
        case "+":
            operationInProgress {$0 + $1}
        case "-":
            operationInProgress {$0 - $1}
        case "×":
            operationInProgress {$0 * $1}
        case "÷":
            operationInProgress {_,_ in firstNubmer / secondNumber}
        default: break
        }
        
    }
    
    @IBAction func clearActive(_ sender: UIButton) {
        firstNubmer = 0
        secondNumber = 0
        currentInput = 0
        displayResult.text = "0"
        stillTyping = false
        dotActivePlaced = false
        operation = ""
    }
    
    @IBAction func plusMinusActive(_ sender: UIButton) {
        currentInput = -currentInput
        
    }
    
    @IBAction func squareActive(_ sender: UIButton) {
        currentInput = pow(currentInput, 2)
            
    }
    
    @IBAction func squareRootActive(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
        
    }
    
    @IBAction func dotActive(_ sender: UIButton) {
        if stillTyping && !dotActivePlaced {
            displayResult.text = displayResult.text! + "."
            dotActivePlaced = true
        } else if !stillTyping && !dotActivePlaced {
            displayResult.text = "0."
        }
        
    }
    
}
