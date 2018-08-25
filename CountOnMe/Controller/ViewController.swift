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

    var operators: [String] = ["+"]
    var index = 0
    var isExpressionCorrect: Bool {
        if let stringNumber = reckon.stringNumbers.last {
            if stringNumber.isEmpty {
                if reckon.stringNumbers.count == 1 {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
                return false
            }
        }
        return true
    }

    var canAddOperator: Bool {
        if let stringNumber = reckon.stringNumbers.last {
            if stringNumber.isEmpty {
                let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                return false
            }
        }
        return true
    }


    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                reckon.addNewNumber(i)
            }
        }
        updateDisplay()
    }

    @IBAction func plus() {
        if canAddOperator {
        	operators.append("+")
        	reckon.stringNumbers.append("")
            print("+++++ \(reckon.stringNumbers)")
            updateDisplay()
        }
    }

    @IBAction func minus() {
        if canAddOperator {
            operators.append("-")
            reckon.stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func equal() {
        calculateTotal()
    }


    // MARK: - Methods



    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }

        var total = 0
        for (i, stringNumber) in reckon.stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }

        textView.text = textView.text + "=\(total)"

        clear()
    }

    func updateDisplay() {
        var text = ""
        for (i, stringNumber) in reckon.stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }

    func clear() {
        reckon.stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
}
