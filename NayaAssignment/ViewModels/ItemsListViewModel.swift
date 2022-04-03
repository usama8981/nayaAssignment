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
        
        let results = localRepo.saveAndUpdateData(items)
        
        return results
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
