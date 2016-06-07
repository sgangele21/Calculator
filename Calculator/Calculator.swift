//
//  File.swift
//  Calculator
//
//  Created by Sahil Gangele on 5/27/16.
//  Copyright © 2016 Sahil Gangele. All rights reserved.
//




// MARK: Properties
enum CalculatorButtons: String {
    case One = "1"
    case Two = "2"
    case Three = "3"
    case Four = "4"
    case Five = "5"
    case Six = "6"
    case Seven = "7"
    case Eight = "8"
    case Nine = "9"
    case Zero = "0"
    case Addition = "+"
    case Subtraction = "−"
    case Multiplication = "*"
    case Division = "/"
    case Equals = "="
    
    var change: String {
        return "Sahil"
    }
}

// MARK: Errors
enum Error: ErrorType {
    case DivideByZero
}


// MARK: Protocols
protocol Addition {
    func add(num1: Float, num2: Float)
}

protocol Subtraction {
    func subtract(num1: Float, num2: Float)
}

protocol Multiplication {
    func multiply(num1: Float, num2: Float)
}

protocol Division {
    func divide(num1: Float, num2: Float) throws
}

protocol Equals {
    func equals() throws
}

protocol CalculatorProperties {
    var total: Float { get set }
    var currentNumber: String { get set }
    var numberTape: [String] { get set }
}

protocol Calcutable {
    func getTotal() -> Float
    func setTotal(number: Float)
    func getCurrentNumber() -> String
    func negateCurrentNumber()
    func addDecimal()
    func addToCurrentNumber(numberString: String)
    func resetCurrentNumber()
    func resetTotal()
}


// MARK: Main Calculator Class
class Calculator: Addition, Subtraction, Multiplication, Division, CalculatorProperties, Equals, Calcutable {
    var total: Float = 0.0
    var currentNumber: String = ""
    var numberTape: [String] = []
    
    // Operations ---------------------------
    func divide(num1: Float, num2: Float) throws {
        if(num2 == 0) {
            throw Error.DivideByZero
        }
        total = num1 / num2
    }
    
    func subtract(num1: Float, num2: Float) {
        total = num1 - num2
    }
    
    func add(num1: Float, num2: Float) {
        total = num1 + num2
    }
    
    func multiply(num1: Float, num2: Float) {
        total = num1 * num2
    }
    
    // Iterates through the array, finding the total
    // Ex: ["3", "+", "3"]
    func equals() throws {
        for i in 0..<numberTape.count {
            switch numberTape[i] {
            case CalculatorButtons.Addition.rawValue:
                if let num1 = Float(numberTape[i-1]), let num2 = Float(numberTape[i+1]) {
                    // Adds value to total
                    add(num1, num2: num2)
                    // Makes total the new value to compare
                    numberTape[i+1] = String(total)
                }
            case CalculatorButtons.Subtraction.rawValue:
                if let num1 = Float(numberTape[i-1]) , let num2 = Float(numberTape[i+1]) {
                    // Subtracts value from total
                    subtract(num1, num2: num2)
                    // Makes total the new value to compare
                    numberTape[i+1] = String(total)
                }
            case CalculatorButtons.Multiplication.rawValue:
                if let num1 = Float(numberTape[i-1]) , let num2 = Float(numberTape[i+1]) {
                    // Multiplies value to total
                    multiply(num1, num2: num2)
                    // Makes total the new value to compare
                    numberTape[i+1] = String(total)
                }
            case CalculatorButtons.Division.rawValue:
                if let num1 = Float(numberTape[i-1]) , let num2 = Float(numberTape[i+1]) {
                    // Divides value from total
                    do {
                        try divide(num1, num2: num2)
                    }catch Error.DivideByZero {
                        // Throw the error to be handled by the view
                        throw Error.DivideByZero
                    }catch let error {
                        print(error)
                    }
                    // Makes total the new value to compare
                    numberTape[i+1] = String(total)
                }
                
            default:
                continue
            }
        }
        // Assign the final, total number
        if let finalNumber = Float(numberTape[numberTape.count-1]) {
            self.setTotal(finalNumber)
        }
        
    }
    
    func negateCurrentNumber() {
        if(currentNumber == "") {
            currentNumber += "-"
        } else if(!currentNumber.containsString("-")) {
            currentNumber = "-" + currentNumber
        }else if(currentNumber.containsString("-")) {
            let newCurrentNumber: String = String(currentNumber.characters.dropFirst())
            currentNumber = newCurrentNumber
        }
        
    }
    
    func addDecimal() {
        // If the currentNumber doesn't contain a decimal, add one
        if(!currentNumber.containsString(".")) {
            currentNumber += "."
        }
    }
    
    
    // Helper Methods ---------------------------
    func getTotal() -> Float {
        return total
    }
    
    func setTotal(number: Float) {
        total = number
    }
    
    func getCurrentNumber() -> String {
        return currentNumber
    }
    
    func resetCurrentNumber() {
        currentNumber = ""
    }
    
    func resetTotal() {
        total = 0.0
    }
    
    func addToCurrentNumber(numberString: String) {
        currentNumber += numberString
    }
}

