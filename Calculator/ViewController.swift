//
//  ViewController.swift
//  Calculator
//
//  Created by Sahil Gangele on 5/27/16.
//  Copyright © 2016 Sahil Gangele. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    // Weak because UILabel is a sub reference
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tape: UILabel!
    var calculator: Calculator = Calculator()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
     //MARK: -  Numbered Buttons

    @IBAction func buttonNumberOne(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.One.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberTwo(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Two.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberThree(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Three.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberFour(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Four.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberFive(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Five.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberSix(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Six.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberSeven(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Seven.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberEight(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Eight.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberNine(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Nine.rawValue)
        updateTotalLabel()
    }
    
    @IBAction func buttonNumberZero(sender: AnyObject) {
        calculator.addToCurrentNumber(CalculatorButtons.Zero.rawValue)
        updateTotalLabel()
    }
    
    // MARK: - Operator Buttons
    
    // Operators work by appending the current number, and selected operator to an array
    // Then it resets the current number, so a new number can be stored to the list
    @IBAction func additionButton(sender: AnyObject) {
        if(calculator.getCurrentNumber() != "") {
            calculator.numberTape.append(calculator.getCurrentNumber())
            calculator.numberTape.append(CalculatorButtons.Addition.rawValue)
            calculator.resetCurrentNumber()
            updateTapeLabel()
            print(calculator.numberTape)
        }
        
    }
    
    @IBAction func subtractionButton(sender: AnyObject) {
        if(calculator.getCurrentNumber() != "") {
            calculator.numberTape.append(calculator.getCurrentNumber())
            calculator.numberTape.append(CalculatorButtons.Subtraction.rawValue)
            calculator.resetCurrentNumber()
            updateTapeLabel()
            print(calculator.numberTape)
        }
    }
    
    @IBAction func divisionButton(sender: AnyObject) {
        if(calculator.getCurrentNumber() != "") {
            calculator.numberTape.append(calculator.getCurrentNumber())
            calculator.numberTape.append(CalculatorButtons.Division.rawValue)
            calculator.resetCurrentNumber()
            updateTapeLabel()
            print(calculator.numberTape)
        }
    }
    @IBAction func multiplyButton(sender: AnyObject) {
        if(calculator.getCurrentNumber() != "") {
            calculator.numberTape.append(calculator.getCurrentNumber())
            calculator.numberTape.append(CalculatorButtons.Multiplication.rawValue)
            calculator.resetCurrentNumber()
            updateTapeLabel()
            print(calculator.numberTape)
        }
    }
  
    @IBAction func equalsButton(sender: AnyObject) {
        calculator.numberTape.append(calculator.getCurrentNumber())
        print(calculator.numberTape)
        updateTapeLabel()
        do {
            try calculator.equals()
        }catch Error.DivideByZero {
            alert()
        }catch let error {
            print(error)
        }
        // Make label equal to the final total, instead of currentNumber
        totalLabel.text = "\(calculator.getTotal())"
        // Resets the calculator, with total still showing
        resetCalculator()
        
    }
    
    @IBAction func clearButton(sender: AnyObject) {
        resetCalculator()
        totalLabel.text = String(calculator.getTotal())
        updateTapeLabel()
    }
    
    
    @IBAction func negate(sender: AnyObject) {
        calculator.negateCurrentNumber()
        updateTotalLabel()
    }
    
    @IBAction func decimal(sender: AnyObject) {
        calculator.addDecimal()
        updateTotalLabel()
    }
    

    // MARK: - Helper Methods
    func updateTotalLabel() {
        totalLabel.text = "\(calculator.getCurrentNumber())"
    }
    
    func updateTapeLabel() {
        var tapeString = String()
        for value in calculator.numberTape {
            tapeString += value
            if calculator.numberTape.indexOf(value) != (calculator.numberTape.count-1) {
                tapeString +=  " "
            }
        }
        tape.text = tapeString
    }
    
    func alert() {
        let alert = UIAlertController(title: "Divide By Zero Error", message: "Can not divide by zero", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: resetCalculator))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // This method is called only when the UIAlert is shown
    func resetCalculator(sender: UIAlertAction) {
        calculator.resetCurrentNumber()
        calculator.resetTotal()
        calculator.numberTape.removeAll(keepCapacity: false)
        updateTapeLabel()
    }
    
    func resetCalculator() {
        calculator.resetCurrentNumber()
        calculator.resetTotal()
        calculator.numberTape.removeAll(keepCapacity: false)
    }
    
}

