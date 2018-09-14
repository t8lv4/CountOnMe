//
//  ViewController+UIAlertController.swift
//  CountOnMe
//
//  Created by Morgan on 30/08/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import UIKit

/// Extend the ViewController with a UIAlertController display
extension ViewController {

    /**
     Implement a UIAlertController called by the ViewController when the user input is invalid
        - A message is displayed according to the input
        - The user dismiss the alert by clicking a "OK" button

     - Note: This method calls `resetArrays()` and erase the display

     - Parameter message: The error message to be displayed
     */
    func presentVCAlert(with message: String) {
        let alertVC = UIAlertController(title: "Erreur !", message: message, preferredStyle: .alert)

        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alertVC, animated: true, completion: {
            self.reckon.resetArrays()
            self.textView.text = ""
        })
    }
}
