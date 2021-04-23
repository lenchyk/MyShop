//
//  StoreCollectionViewController.swift
//  MyShop
//
//  Created by Lena Soroka on 14.04.2021.
//

import UIKit
import FirebaseAuth

class StoreCollectionViewController: UIViewController {
    
    @IBOutlet private var logoutButton: UIButton!
    @IBOutlet private var sortButton: UIButton!
    @IBOutlet private var collectionView: UICollectionView!
    
    @IBAction private func logout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let introVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.introViewController)
            
            view.window?.rootViewController = introVC
            view.window?.makeKeyAndVisible()
        } catch let error {
            print("Failed to log out: ", error.localizedDescription)
        }
    }
    
    private enum SortingMethod {
        case lowToHigh, highToLow, noSorting
    }
    
    private var sortingMethod: SortingMethod = .noSorting
    private var collection = GoodsCollection()
    private var customer = Customer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customer.chosenProducts = getData()
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
                // if there is sorting method, there is filtered collection, not a default collection of goods
                if self.sortingMethod == .highToLow || self.sortingMethod == .lowToHigh {
                    self.customer.addProduct(product: self.collection.filteredGoods[indexPath.item])
                } else {
                    self.customer.addProduct(product: self.collection.goods[indexPath.item])
                }
                let tabBarVC = self.tabBarController as! MainViewController
                tabBarVC.chosenProducts = self.customer.chosenProducts
                self.saveData(self.customer.chosenProducts)
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
    // filtering menu on a button action
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
    
    // saving and getting the cart data
    private func saveData(_ dataArray: [Goods]) {
        if let encoded = try? JSONEncoder().encode(dataArray) {
            UserDefaults.standard.set(encoded, forKey: Constants.UserDefaults.keyForData)
        }
    }
    
    private func getData() -> [Goods] {
        if let data = UserDefaults.standard.data(forKey: Constants.UserDefaults.keyForData) {
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([Goods].self, from: data)
                return products
            } catch {
                print("Unable to Decode (\(error))")
            }
        }
        return [Goods]()
    }
}
