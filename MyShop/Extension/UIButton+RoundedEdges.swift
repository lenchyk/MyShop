//
//  UIButton+RoundedEdges.swift
//  MyShop
//
//  Created by Lena Soroka on 11.04.2021.
//

import UIKit

extension UIButton {
    func makeRoundedEdges() {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}


