//
//  ItemsListViewModel.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import UIKit
import Combine
import CoreData

final class ItemsListViewModel: NSObject {
    
    private var repo:ItemsRemoteRepository
    private var localRepo : ItemsLocalRepository
    private var subscriptions: Set<AnyCancellable> = []
    var articlesReloadPublisher: AnyPublisher<Bool, Never> {
        articlesReloadInternal.eraseToAnyPublisher()
    }
    private var context = (UIApplication.shared.delegate  as! AppDelegate).persistentContainer.viewContext
    private var articlesReloadInternal: PassthroughSubject<Bool, Never> = .init()
    private(set) var currentDisplayedArticles = [ShoppingItemsViewModel]()
    private var shoppingItems : [ShoppingItem]! {
        didSet {
            currentDisplayedArticles = getDataToSaveLocal(shoppingItems)
            articlesReloadInternal.send(true)
            
        }
    }
    // Mark: - Intializater
    init(
        repo:ItemsRemoteRepository = ItemsRemoteRepository(
            service : ServiceApi()
        ), localRepo : ItemsLocalRepository = ItemsLocalRepository()
    ) {
        self.repo = repo
        self.localRepo = localRepo
    }
    
    func fetchItems() {
        repo.fetchItems().sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case  .failure(_):
                self?.articlesReloadInternal.send(false)
            case .finished: break // Nothing to do here, continuation is upon first received value
            }        }, receiveValue: { [weak self] itemResponse in
                self?.shoppingItems = itemResponse.items
                
            }).store(in: &subscriptions)
    }
    
    func fetchLocalItems(){
       
    }
    
    // MARK: Data Transformer
    private func getDataToSaveLocal(_ items: [ShoppingItem]) -> [ShoppingItemsViewModel] {
        var result = [ShoppingItemsViewModel]()
        let storedData = localRepo.fetchItems()
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
    // MARK: - UPDATE Local DATA
    func updateWishlistItem(index:Int){
        
        let item = currentDisplayedArticles[index]
        item.isAddedToWishList = !item.isAddedToWishList
        let updatedData = localRepo.updateWishlistItemWithItem(item: item)
        currentDisplayedArticles[index] = ShoppingItemsViewModel(item: updatedData[index])
        articlesReloadInternal.send(true)

    }
    
    func updateWishlistItemWithItem(item:ShoppingItemsViewModel){

        _ = localRepo.updateWishlistItemWithItem(item: item)
    }
}
