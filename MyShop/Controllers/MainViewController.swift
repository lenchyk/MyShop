//
//  MainViewController.swift
//  MyCollectionView
//
//  Created by Lena Soroka on 19.04.2021.
//

import UIKit
import Firebase

class MainViewController: UITabBarController {
    
    public var chosenProducts = [Goods]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        if user == nil {
            DispatchQueue.main.async {
                let introVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.introNavigationController)
                self.view.window?.rootViewController = introVC
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
