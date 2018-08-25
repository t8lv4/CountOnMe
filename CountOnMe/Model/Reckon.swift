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
}
