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
    
    func saveAndUpdateData(_ items: [ShoppingItem]) -> [ShoppingItemsViewModel]{
        var result = [ShoppingItemsViewModel]()
        let storedData = self.fetchItems()
        print(storedData.count)
        items.forEach { (item) in
            if let object = storedData.filter({ $0.id == item.id }).first {
                object.badges = item.badges
                object.name = item.name
                object.orignalPrice = Int64(item.originalPrice ?? 0)
                object.price = Int64(item.price ?? 0)
                object.sku = item.sku
                object.image = item.image
                object.id = item.id
                object.brand = item.brand
                try! self.context.save()
                result.append(ShoppingItemsViewModel(item: object))
            }
            else{
                let newShoppingItem = ShoppingItemLocal(context: self.context)
                newShoppingItem.badges = item.badges
                newShoppingItem.name = item.name
                newShoppingItem.orignalPrice = Int64(item.originalPrice ?? 0)
                newShoppingItem.price = Int64(item.price ?? 0)
                newShoppingItem.sku = item.sku
                newShoppingItem.image = item.image
                newShoppingItem.id = item.id
                newShoppingItem.brand = item.brand
                newShoppingItem.isAddedToWishList = false
                newShoppingItem.isAddedToBag = false
                try! self.context.save()
                result.append(ShoppingItemsViewModel(item: newShoppingItem))
            }
    }
        return result
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
