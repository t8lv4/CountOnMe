//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let reckon = Reckon()

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        recordTappedNumber(from: sender)
        updateDisplay()
    }


    @IBAction func operationTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            inputOperationSymbol(with: "plus")
        case 1:
            inputOperationSymbol(with: "minus")
        case 2:
            inputEqual()
        default:
            return
        }
    }

    // MARK: - Methods

    private func inputOperationSymbol(with symbol: String) {
        if reckon.canAddOperationSymbol(symbol) {
            updateDisplay()
        } else {
            presentVCAlert(with: "Expression incorrecte !")
        }
    }

    private func inputEqual() {
        switch reckon.isExpressionCorrect() {
        case 0:
            presentVCAlert(with: "Démarrez un nouveau calcul !")
        case 1:
            presentVCAlert(with: "Entrez une expression correcte !")
        default:
            renderReckon()
        }
    }

    private func renderReckon() {
        textView.text = textView.text + "=\(reckon.returnResult())"
        reckon.resetArrays()
    }

    private func recordTappedNumber(from sender: UIButton) {
        for (counter, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                reckon.addNewNumber(counter)
            }
        }
    }

    private func updateDisplay() {
        var text = ""
        for (index, stringNumber) in reckon.numberArray.enumerated() {
            // Add operator
            if index > 0 {
                text += reckon.operationSymbolArray[index]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }

}
