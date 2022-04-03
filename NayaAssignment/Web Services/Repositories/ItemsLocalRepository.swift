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
}
