//
//  Utilities.swift
//  MyShop
//
//  Created by Lena Soroka on 14.04.2021.
//

import Foundation
import UIKit

struct Utilities {
    
    static func isValidEmail(_ email: String?) -> Bool {
        if let userEmail = email {
            let validEmail = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            return validEmail.evaluate(with: userEmail)
        }
        return false
    }
    
    static func isPasswordValid(_ password: String?) -> Bool {
        if let userPassword = password {
            let validPassword = NSPredicate(format:"SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[_!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$")
            return validPassword.evaluate(with: userPassword)
        }
        return false
    }
    
    static func isTextFieldEmpty(_ text: String?) -> Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    static func showError(_ message: String, _ errorLabel: UILabel) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
