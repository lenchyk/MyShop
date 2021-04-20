//
//  StoreCollectionViewController.swift
//  MyShop
//
//  Created by Lena Soroka on 14.04.2021.
//

import UIKit
import FirebaseAuth

class StoreCollectionViewController: UIViewController {
    
    @IBOutlet var logoutButton: UIButton!
    @IBAction func logout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let introVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.introViewController)
            
            view.window?.rootViewController = introVC
            view.window?.makeKeyAndVisible()
        } catch let error {
            print("Failed to log out: ", error)
        }
    }
    
    private enum SortingMethod {
        case lowToHigh, highToLow, noSorting
    }
    
    @IBOutlet private var sortButton: UIButton!
    private var sortingMethod: SortingMethod = .noSorting

    @IBOutlet private var collectionView: UICollectionView!
    
    private var collection = GoodsCollection()
    private var customer = Customer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.menu = createMenu()
        
        collectionView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let tabBarVC = tabBarController as! MainViewController
        tabBarVC.chosenProducts = customer.chosenProducts
    }
}

extension StoreCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.goods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        var product: Goods
        if sortingMethod == .highToLow || sortingMethod == .lowToHigh {
            product = collection.filteredGoods[indexPath.item]
        } else {
            product = collection.goods[indexPath.item]
        }
        cell.setup(for: product)
        return cell
    }
    
    //context menu for adding product to cutomer's cart
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            
            let addAction = UIAction(title: "Add to a cart", image: .add, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) { [weak self] _ in
                guard let self = self else { return }
                self.customer.addProduct(product: self.collection.goods[indexPath.item])
                let tabBarVC = self.tabBarController as! MainViewController
                tabBarVC.chosenProducts = self.customer.chosenProducts
            }
            return UIMenu(children: [addAction])
        }
    }

    // resizing for different devices
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maximumNumberOfCells = 3
        let spacingForCells = 3
        let width  = Int(collectionView.frame.width) / maximumNumberOfCells - (spacingForCells * (maximumNumberOfCells + 1))
        let height = width + 30
        return CGSize(width: width, height: height)
    }
    
}

extension StoreCollectionViewController {
    private func createMenu() -> UIMenu {
        let highToLowSortAction = UIAction(title: "High to low", image: UIImage(systemName: "arrow.down")) { [weak self] _ in
            guard let self = self else { return }
            self.sortingMethod = .highToLow
            self.collection.filterCollection(isHighToLow: true)
            self.collectionView.reloadData()
        }
        
        let lowToHighSortAction = UIAction(title: "Low to high", image: UIImage(systemName: "arrow.up")) { [weak self] _ in
            guard let self = self else { return }
            self.sortingMethod = .lowToHigh
            self.collection.filterCollection(isHighToLow: false)
            self.collectionView.reloadData()
        }
        
        let resetAction = UIAction(title: "Reset", image: UIImage(systemName: "arrow.counterclockwise.icloud")) {
            [weak self] _ in
            guard let self = self else { return }
            self.sortingMethod = .noSorting
            self.collection.filterCollection(isHighToLow: nil)
            self.collectionView.reloadData()
        }
        let menu = UIMenu(title: "", children: [highToLowSortAction, lowToHighSortAction, resetAction])
        return menu
    }
}
