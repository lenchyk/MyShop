//
//  IntroViewController.swift
//  MyShop
//
//  Created by Lena Soroka on 13.04.2021.
//

import UIKit
import FirebaseAuth

class IntroViewController: UIViewController {

    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeClearNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        signUpButton.makeRoundedEdges()
    }
    
    private func makeClearNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}
