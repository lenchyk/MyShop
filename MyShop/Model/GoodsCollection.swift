//
//  Goods.swift
//  MyShop
//
//  Created by Lena Soroka on 15.04.2021.
//

import Foundation


class GoodsCollection {
    public var goods = [Goods]()
    public var filteredGoods = [Goods]()
    
    init() {
        goods = loadGoodsDataFromJSON(Constants.dataFileName)
    }
    
    func loadGoodsDataFromJSON(_ nameOfFile: String) -> [Goods] {
            guard let path = Bundle.main.path(forResource: nameOfFile, ofType: "json") else { return [] }
            let url = URL(fileURLWithPath: path)
            var goods = [Goods]()
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(Response.self, from: data)
                goods = response.Data
                
            } catch {
                print(error)
            }
            return goods
    }

    func filterCollection(isHighToLow highToLow: Bool?) {
        filteredGoods.removeAll()
        
        if let sortingMethodIsHighToLow = highToLow {
            if sortingMethodIsHighToLow {
                filteredGoods = goods.sorted(by: { $0.price > $1.price })
            } else {
                filteredGoods = goods.sorted(by: { $0.price < $1.price })
            }
        } else {
            // if it's nil - reset to initial state
            filteredGoods = goods
        }
    }
}
