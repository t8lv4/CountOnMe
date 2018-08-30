//
//  ViewController+UIAlertController.swift
//  CountOnMe
//
//  Created by Morgan on 30/08/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import UIKit

extension ViewController {
    func presentVCAlert(with message: String) {
        let alertVC = UIAlertController(title: "Erreur !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: {
            self.reckon.resetArrays()
            self.textView.text = ""
        })
    }
}
