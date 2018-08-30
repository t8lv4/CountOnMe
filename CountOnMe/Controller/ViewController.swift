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
        displayTappedNumber(from: sender)
        updateDisplay()
    }

    @IBAction func plus() {
        if canAddOperator() {
            reckon.appendPlusOperator()
            updateDisplay()
        }
    }

    @IBAction func minus() {
        if canAddOperator() {
            reckon.appendMinusOperator()
            updateDisplay()
        }
    }

    @IBAction func equal() {
        if isExpressionCorrect() {
            renderReckon()
        }
    }


    // MARK: - Methods

    //check input validity
    private func canAddOperator() -> Bool {
        if let stringNumber = reckon.stringNumbers.last {
            if stringNumber.isEmpty {
                presentVCAlert(with: "expression incorrecte !")
            }
        }
        return true
    }

    private func isExpressionCorrect() -> Bool {
        if reckon.stringNumbers.count == 1 {
            presentVCAlert(with: "Démarrez un nouveau calcul !")
            return false
        } else if reckon.stringNumbers.last == "" {
            presentVCAlert(with: "Entrez une expression correcte !")
            return false
        }
        return true
    }


    // display

    private func presentVCAlert(with alert: String) {
        let alertVC = UIAlertController(title: "Erreur !", message: alert, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }


    private func renderReckon() {
        textView.text = textView.text + "=\(reckon.calculate())"
        reckon.clear()
    }

    private func displayTappedNumber(from sender: UIButton) {
        for (counter, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                reckon.addNewNumber(counter)
            }
        }
    }

    private func updateDisplay() {
        var text = ""
        for (index, stringNumber) in reckon.stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += reckon.operators[index]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }

}
