//
//  Customer.swift
//  MyShop
//
//  Created by Lena Soroka on 15.04.2021.
//

import Foundation

class Customer {
    public var chosenProducts: [Goods] = []
    
    init() {
    }
    
    public func addProduct(product: Goods) {
        chosenProducts.append(product)
    }
}

