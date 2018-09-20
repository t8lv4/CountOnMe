//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//

import UIKit

/**
 Owns the View
 - Receives input from the UI
 - Call model's methods
 - Update UI
 */
class ViewController: UIViewController {
    // MARK: - Properties

    /// Instance of Reckon
    let reckon = Reckon()

    // MARK: - Outlets

    /// Where input and result are displayed
    @IBOutlet weak var textView: UITextView!
    /// An array of numbers keyboard
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    /// Called when the user thouch up inside the numbers keyboard
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        recordTappedNumber(from: sender)
        updateDisplay()
    }

    /// Called when the user touch up inside an operation symbol
    @IBAction func operationTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            inputOperationSymbol(with: "plus")
        case 2:
            inputOperationSymbol(with: "minus")
        case 3:
            inputEqual()
        default:
            return
        }
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        reckon.resetArrays()
    }

    /**
     Call a method to check the input validity
        - if valid, update display
        - if invalid, call an alert with an appropriate message
    - parameter symbol: The user input
     */
    private func inputOperationSymbol(with symbol: String) {
        if reckon.canAddOperationSymbol(symbol) {
            updateDisplay()
        } else {
            presentVCAlert(with: "Expression incorrecte !")
        }
    }

    /**
     Call a method to check the input validity
     - if invalid, call an alert with the appropriate message
     - if valid call for calculation and display the result
     */
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

    /**
     Concatenate the displayed text with the result of a calculation
     Call a method to restore default values
     */
    private func renderReckon() {
        textView.text! += "=\(reckon.returnResult())"
        reckon.resetArrays()
    }

    /**
     Call a method to concatenate the input numbers
     - parameter sender: The tapped button
     */
    private func recordTappedNumber(from sender: UIButton) {
        for (counter, numberButton) in numberButtons.enumerated() where sender == numberButton {
                reckon.concatenateNumbers(counter)
            }
        }
    /// Update display with the user input
    private func updateDisplay() {
        var text = ""
        for (index, stringNumber) in reckon.numberArray.enumerated() {
            /// Update display with an operation symbol
            if index > 0 {
                text += reckon.operationSymbolArray[index]
            }
            /// Update display with a number
            text += stringNumber
        }
        textView.text = text
    }

}
