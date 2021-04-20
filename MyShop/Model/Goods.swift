//
//  Goods.swift
//  MyShop
//
//  Created by Lena Soroka on 15.04.2021.
//

import Foundation

// class for one product
class Goods: Codable {
    public var name: String
    public var price: Int
    public var image: String  // here is just image name got from JSON
    
    init(productName: String, productPrice: Int, productImage: String) {
        self.name = productName
        self.price = productPrice
        self.image = productImage
    }
}
