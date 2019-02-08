//
//  Delegate.swift
//  CountOnMe
//
//  Created by Morgan on 01/10/2018.
//

import Foundation

/// A protocol to display an alert message
protocol VCAlertDelegate: class {
    /**
     Define a UIAlertController called by the ViewController as a delegate of the Model when the user input is invalid
     - A message is displayed according to the input
     - The user dismiss the alert by clicking a "OK" button

     - Parameter with: The error message to be displayed
     */
    func presentVCAlert(with: String)
}
