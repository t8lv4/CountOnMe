//
//  Reckon.swift
//  CountOnMe
//
//  Created by Morgan on 25/08/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

class Reckon {
    var numberArray: [String] = [String()]
    var operatorArray: [String] = ["+"]

    //MARK: - append numbers abd operators

    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = numberArray.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            numberArray[numberArray.count-1] = stringNumberMutable
        }
    }

    func appendPlusOperator() {
        operatorArray.append("+")
        numberArray.append("")
    }

    func appendMinusOperator() {
        operatorArray.append("-")
        numberArray.append("")
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
            if operatorArray[index] == "+" {
                result += number
            } else if operatorArray[index] == "-" {
                result -= number
            }
        }
    }

    //MARK: - reset

    func resetArrays() {
        numberArray = [String()]
        operatorArray = ["+"]
    }
}
