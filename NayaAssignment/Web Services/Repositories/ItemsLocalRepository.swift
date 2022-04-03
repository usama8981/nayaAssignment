//
//  ItemsLocalRepository.swift
//  NayaAssignment
//
//  Created by Usama Ali on 03/04/2022.
//


import UIKit
import Combine
protocol ItemsLocalRepositoryProtocol {
    func fetchItems() -> [ShoppingItemLocal]
}

final class ItemsLocalRepository : ItemsLocalRepositoryProtocol {
    
    var subscriptions: Set<AnyCancellable> = []
    private var context = (UIApplication.shared.delegate  as! AppDelegate).persistentContainer.viewContext
    
    
    func fetchItems() -> [ShoppingItemLocal] {
        
        let storedData = try! context.fetch(ShoppingItemLocal.fetchRequest())
        return storedData
    }
    
    
    
    func updateWishlistItemWithItem(item:ShoppingItemsViewModel) -> [ShoppingItemLocal]{
        let storedData = fetchItems()
        if let object = storedData.filter({ $0.id == item.id }).first {
            object.isAddedToWishList = item.isAddedToWishList
            object.isAddedToBag = item.isAddedToBag
            try! self.context.save()
        }
        let updateData = self.fetchItems()
        return updateData
    }
}
