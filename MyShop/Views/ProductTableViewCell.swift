//
//  ProductTableViewCell.swift
//  MyCollectionView
//
//  Created by Lena Soroka on 19.04.2021.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet private var productName: UILabel!
    @IBOutlet private var count: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: Constants.tableViewCellIdentifier, bundle: nil)
    }
    
    public func setup(name: String, countProduct: String) {
        productName.text = name
        count.text = countProduct
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
