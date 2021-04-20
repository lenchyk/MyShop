//
//  PasswordResetViewController.swift
//  MyShop
//
//  Created by Lena Soroka on 14.04.2021.
//

import UIKit
import FirebaseAuth

class PasswordResetViewController: UIViewController {

    @IBOutlet private var email: UITextField!
    @IBOutlet private var resetButton: UIButton!
    @IBOutlet private var errorMessage: UILabel!
    
    @IBAction private func resetTapped(_ sender: UIButton) {
        let userEmail = email.text
        
        if userEmail == nil || userEmail == "" {
            Utilities.showError("Please, enter a valid email!", errorMessage)
        } else {
            Auth.auth().sendPasswordReset(withEmail: userEmail!) { (err) in
                if err != nil {
                    Utilities.showError("Error! Incorrect email!", self.errorMessage)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetButton.makeRoundedEdges()
    }

}
