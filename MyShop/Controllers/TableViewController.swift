//
//  TableViewController.swift
//  MyCollectionView
//
//  Created by Lena Soroka on 19.04.2021.
//

import UIKit

class TableViewController: UIViewController {
    
    private var products = [Goods]()
    private var countedItems = [String: Int]()
    private var productNames = [String]()
    
    @IBOutlet private var chosenProductsLabel: UILabel!
    @IBOutlet private var totalPrice: UILabel!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarVC = tabBarController as! MainViewController
        products = tabBarVC.chosenProducts
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.nib(), forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabBarVC = tabBarController as! MainViewController
        products = tabBarVC.chosenProducts
        update()
    }
    
    private func update() {
        if products.count == 0 {
            totalPrice.isHidden = true
            scrollView.isHidden = true
            chosenProductsLabel.text = "You have no items chosen!"
        } else {
            totalPrice.isHidden = false
            scrollView.isHidden = false
            chosenProductsLabel.text = "Your products:"
            updatePriceLabel()
            countedItems = dictionaryOfItems()
            productNames = getProductNames()
            tableView.reloadData()
        }
    }
    
    private func updatePriceLabel() {
        totalPrice.text = "Total price: " + String(calculatePrice()) + "$"
    }
    
    private func calculatePrice() -> Int {
        var price = 0
        for product in products {
            price += product.price
        }
        return price
    }
    
    // dictionary of [productName: amountOfThisProduct]
    private func dictionaryOfItems() -> [String: Int] {
        var items = [String: Int]()
        for product in products {
            items[product.name, default: 0] += 1
        }
        return items
    }
    
    private func getProductNames() -> [String] {
        return Array(countedItems.keys)
    }

}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as! ProductTableViewCell
        let name = productNames[indexPath.item]
        cell.setup(name: name, countProduct: String(countedItems[name]!))
        return cell
    }
}
