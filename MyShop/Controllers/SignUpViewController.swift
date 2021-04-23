//
//  SignUpViewController.swift
//  MyShop
//
//  Created by Lena Soroka on 13.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet private var firstName: UITextField!
    @IBOutlet private var lastName: UITextField!
    @IBOutlet private var email: UITextField!
    @IBOutlet private var password: UITextField!
    @IBOutlet private var errorMessage: UILabel!
    @IBOutlet private var signUp: UIButton!
    
    @IBAction private func signUpTapped(_ sender: Any) {
        // validate all fields
        let error = validateFields()
        
        if error != nil {
            Utilities.showError(error!, errorMessage)
        } else {
            let userFirstName = firstName.text!
            let userLastName = lastName.text!
            let userEmail = email.text!
            let userPassword = password.text!
            // create a user
            Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (result, err) in
                if err != nil {
                    Utilities.showError(err!.localizedDescription, self.errorMessage)
                } else {
                    // user signs up successfully
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName": userFirstName, "lastName": userLastName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            Utilities.showError(error!.localizedDescription, self.errorMessage)
                        }
                    }
                    // transition to the tab bar controller
                    self.transitionToMainVC()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makeClearNavigationBar()
        signUp.makeRoundedEdges()
    }
    
    // move to main tab bar controller
    private func transitionToMainVC() {
        let mainVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController)
        
        view.window?.rootViewController = mainVC
        view.window?.makeKeyAndVisible()
    }
    
    // validating all fields: return nil if everything is ok and String - if there is any error
    private func validateFields() -> String? {
        if Utilities.isTextFieldEmpty(firstName.text) ||
            Utilities.isTextFieldEmpty(lastName.text) ||
            Utilities.isTextFieldEmpty(email.text) ||
            Utilities.isTextFieldEmpty(password.text) {
            return "Fill all fields, please!"
        }
        if !Utilities.isValidEmail(email.text) {
            return "Your email has incorrect form!"
        }
        if !Utilities.isPasswordValid(password.text) {
            return "Password should contain at least 1 upper and lower case letters, 1 special character and 1 digit."
        }
        return nil
    }
    
    private func makeClearNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}
