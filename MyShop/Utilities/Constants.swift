//
//  Constants.swift
//  MyShop
//
//  Created by Lena Soroka on 14.04.2021.
//

import Foundation

struct Constants {
    
    static let dataFileName = "Data"
    static let cellIdentifier = "ProductCollectionViewCell"
    static let tableViewCellIdentifier = "ProductTableViewCell"
    
    struct Storyboard {
        static let mainViewController = "MainViewController"
        static let introViewController = "IntroViewController"
        static let loginViewController = "LoginViewController"
        static let introNavigationController = "IntroNavigationController"
        static let passwordResetController = "PasswordResetViewController"
    }
    
    struct UserDefaults {
        static let keyForData = "products"
    }
}
