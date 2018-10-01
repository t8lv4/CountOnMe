//
//  Reckon.swift
//  CountOnMe
//
//  Created by Morgan on 25/08/2018.
//

import Foundation

/// Defines OperationSymbol type to group arithmetic operation symbols
enum OperationSymbol {
    case plus, minus
}

/// A protocol to display an alert message
protocol VCAlertDelegate: class {
    /**
     Define a UIAlertController called by the ViewController as a delegate of the Model when the user input is invalid
     - A message is displayed according to the input
     - The user dismiss the alert by clicking a "OK" button

     - Parameter message: The error message to be displayed
     */
    func presentVCAlert(with: String)
}

/** Reckon binary operations
 - return result if they are valid
 - reject if they are invalid
 */
class Reckon {
    /// Store numbers
    var numberArray = [String()]

    /// Store binary operation symbols
    var operationSymbolArray = ["+"]

    /// instance of the protocol VCAlertDelegate
    weak var delegateVCAlert: VCAlertDelegate?

    // MARK: - append numbers and operation symbols

    /// - parameter newNumber: The number input by the user
    func concatenateNumbers(_ newNumber: Int) {
        if let stringNumber = numberArray.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            numberArray[numberArray.count-1] = stringNumberMutable
        }
    }

    /**
     Append an operation symbol to an array
     - parameter symbol: A binary operation symbol input by the user
     */
    func appendOperationSymbol(_ symbol: OperationSymbol) {
        switch symbol {
        case .plus:
            operationSymbolArray.append("+")
            numberArray.append("")
        case .minus:
            operationSymbolArray.append("-")
            numberArray.append("")
        }
    }

    // MARK: - calculate

    /// - returns: Integer
    func returnResult() -> Int {
        /// The variable to be calculated
        var result = 0
        for (index, stringNumber) in numberArray.enumerated() {
            calculate(stringNumber, index, &result)
        }
        return result
    }

    /**
     Calculate the parameter result according to a stored sequence of binary operations

     - Parameters:
        - stringNumber: Operand
        - index: Points to a stored operation symbol
        - result: Points to result adress
     */
    private func calculate(_ stringNumber: String, _ index: Int, _ result: inout Int) {
        if let number = Int(stringNumber) {
            if operationSymbolArray[index] == "+" {
                result += number
            } else if operationSymbolArray[index] == "-" {
                result -= number
            }
        }
    }

    // MARK: - check operation validity

    /**
     Verify the user can add an operator symbol to an array
     - parameter symbol: The operation symbol input by the user
     - Returns: Bool
     */
    func canAddOperationSymbol(with symbol: OperationSymbol) -> Bool {
        if let stringNumber = numberArray.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        appendOperationSymbol(symbol)
        return true
    }

    /**
     Verify the validity of the binary operations to be calculated.
     Call delegate method when invalid
     - Returns: Bool
     */
    func isExpressionCorrect() -> Bool {
        if numberArray.count == 1 {
            delegateVCAlert?.presentVCAlert(with: "Démarrez un nouveau calcul !")
            return false
        } else if numberArray.last == "" {
            delegateVCAlert?.presentVCAlert(with: "Entrez une expression correcte !")
            return false
        }
        return true
    }

    // MARK: - reset

    /// Set arrays to their default values
    func resetArrays() {
        numberArray = [String()]
        operationSymbolArray = ["+"]
    }
}
