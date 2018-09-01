//
//  Reckon.swift
//  CountOnMe
//
//  Created by Morgan on 25/08/2018.
//

import Foundation

class Reckon {
    var numberArray = [String()]
    var operationSymbolArray = ["+"]

    //MARK: - append numbers and operation symbols

    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = numberArray.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            numberArray[numberArray.count-1] = stringNumberMutable
        }
    }

    func appendOperationSymbol(with symbol: String) {
        switch symbol {
        case "plus":
            operationSymbolArray.append("+")
            numberArray.append("")
        case "minus":
            operationSymbolArray.append("-")
            numberArray.append("")
        default:
            return
        }
    }

    //MARK: - calculate

    func returnResult() -> Int {
        var result = 0
        for (index, stringNumber) in numberArray.enumerated() {
            calculate(stringNumber, index, &result)
        }
        return result
    }

    private func calculate(_ stringNumber: String, _ index: Int, _ result: inout Int) {
        if let number = Int(stringNumber) {
            if operationSymbolArray[index] == "+" {
                result += number
            } else if operationSymbolArray[index] == "-" {
                result -= number
            }
        }
    }

    //MARK: - check operation validity

    func canAddOperationSymbol(_ symbol: String) -> Bool {
        if let stringNumber = numberArray.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        appendOperationSymbol(with: symbol)
        return true
    }

    func isExpressionCorrect() -> Int {
        if numberArray.count == 1 {
            return 0
        } else if numberArray.last == "" {
            return 1
        }
        return 2
    }


    //MARK: - reset

    func resetArrays() {
        numberArray = [String()]
        operationSymbolArray = ["+"]
    }
}
