//
//  LoginViewController.swift
//  MyShop
//
//  Created by Lena Soroka on 11.04.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet private var email: UITextField!
    @IBOutlet private var password: UITextField!
    @IBOutlet private var logInButton: UIButton!
    @IBOutlet private var errorMessage: UILabel!
    @IBOutlet private var forgotPasswordButton: UIButton!
    
    @IBAction private func login(_ sender: UIButton) {
        // validate all fields (check if they aren't empty)
        let error = validateFields()
        
        if error != nil {
            Utilities.showError(error!, errorMessage)
        } else {
            // signing in
            let userEmail = email.text!
            let userPassword = password.text!
            Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (result, err) in
                if err != nil {
                    Utilities.showError("Something went wrong", self.errorMessage)
                } else {
                    self.transitionToMainVC()
                }
            }
        }
    }
    
    @IBAction private func forgotPasswordTapped(_ sender: UIButton) {
        // TO-DO: later!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.makeRoundedEdges()
        makeClearNavigationBar()
    }
    
    private func validateFields() -> String? {
        if Utilities.isTextFieldEmpty(email.text) || Utilities.isTextFieldEmpty(password.text) {
            return "Please, fill all the fields."
        }
        return nil
    }
    
    private func transitionToMainVC() {
        let mainVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController)
        view.window?.rootViewController = mainVC
        view.window?.makeKeyAndVisible()
    }
    
    private func makeClearNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
}

