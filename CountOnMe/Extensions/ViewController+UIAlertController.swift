//
//  ViewController+UIAlertController.swift
//  CountOnMe
//
//  Created by Morgan on 30/08/2018.
//

import UIKit

/// Extend the ViewController with a UIAlertController display
extension ViewController: VCAlertDelegate {

    func presentVCAlert(with message: String) {
        let alertVC = UIAlertController(title: "Erreur !", message: message, preferredStyle: .alert)

        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alertVC, animated: true, completion: nil)
    }
}
