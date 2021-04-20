//
//  ProductCollectionViewCell.swift
//  MyShop
//
//  Created by Lena Soroka on 16.04.2021.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(for product: Goods) {
        imageView.image = UIImage(named: product.image)
        name.text = product.name
        price.text = String(product.price) + " $"
    }
}
