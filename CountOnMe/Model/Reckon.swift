//
//  Reckon.swift
//  CountOnMe
//
//  Created by Morgan on 25/08/2018.
//

import Foundation

/** Reckon binary operations
 - return result if they are valid
 - reject if they are invalid
 */
class Reckon {
    /// Store numbers
    var numberArray = [String()]

    /// Store binary operation symbols
    var operationSymbolArray = ["+"]

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
    func appendOperationSymbol(with symbol: String) {
        switch symbol {
        case "plus":
            operationSymbolArray.append("+")
            numberArray.append("")
        case "minus":
            operationSymbolArray.append("-")
            numberArray.append("")
        default:
            break
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
    func canAddOperationSymbol(_ symbol: String) -> Bool {
        if let stringNumber = numberArray.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        appendOperationSymbol(with: symbol)
        return true
    }

    /**
     Verify the validity of the binary operations to be calculated
     - Returns: Int
         - O and 1 describe two different invalid input
         - 2 is a valid input
     */
    func isExpressionCorrect() -> Int {
        if numberArray.count == 1 {
            return 0
        } else if numberArray.last == "" {
            return 1
        }
        return 2
    }

    // MARK: - reset

    /// Set arrays to their default values
    func resetArrays() {
        numberArray = [String()]
        operationSymbolArray = ["+"]
    }
}
