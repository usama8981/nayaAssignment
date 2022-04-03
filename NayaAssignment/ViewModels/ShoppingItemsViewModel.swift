//
//  ShoppingItemsViewModel.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import UIKit

final class ShoppingItemsViewModel {
    let id : String
    let sku : String
    var imageURL : URL? = nil
    let brand : String
    let name : String
    let price : Int
    let originalPrice : Int
    let badges : [String]
    var isAddedToWishList : Bool = false
    var isAddedToBag : Bool = false
    // MARK:- Init
    init(
        item: ShoppingItemLocal
    ) {
        self.id =  item.id ?? ""
        self.sku =  item.sku ?? ""
        self.brand = item.brand ?? ""
        self.name =  item.name ?? ""
        self.price =  Int(item.price)
        self.originalPrice = Int(item.orignalPrice)
        self.isAddedToWishList = item.isAddedToWishList
        self.isAddedToBag = item.isAddedToBag
        self.badges = item.badges ?? []
        if let urlString = item.image?.replacingOccurrences(of: "httpshttps", with: "https"),
           let url = URL(string: urlString) {
            imageURL = url
        }
    }
}
