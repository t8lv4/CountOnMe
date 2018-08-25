//
//  Reckon.swift
//  CountOnMe
//
//  Created by Morgan on 25/08/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

class Reckon {
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]

    func addNewNumber(_ newNumber: Int) {
        print("addNewN")
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
            print("\(stringNumbers[0])")
            print("\(stringNumbers.count)")
        }
    }

    func appendPlusOperator() {
            operators.append("+")
            stringNumbers.append("")
            print("+++++ \(stringNumbers)")
    }

    func appendMinusOperator() {
            operators.append("-")
            stringNumbers.append("")
    }

    func giveResult() -> Int {
        var total = 0

        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        return total
    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
}
