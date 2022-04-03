//
//  MainCoordinator.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navController : UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewModel = ItemsListViewModel()
        let viewController = storyBoard.instantiateViewController(identifier: "HomeViewController") {
            HomeViewController(coder: $0, andViewModel: viewModel)
        }
        viewController.coordinator  = self
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func openItemsDetail(_ itemViewModel : ShoppingItemsViewModel, _ viewModel : ItemsListViewModel){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(identifier: "AddToBagViewController") {
            AddToBagViewController(coder: $0, andViewModel:viewModel ,andItem: itemViewModel)
        }
        self.navigationController.pushViewController(vc, animated: true)
    }
    func openWishlistVC(_ itemViewModel : [ShoppingItemsViewModel], _ viewModel : ItemsListViewModel){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(identifier: "WishlistViewController") {
            WishlistViewController(coder: $0, andViewModel:viewModel ,andItem: itemViewModel)
        }
        self.navigationController.pushViewController(vc, animated: true)
    }
}
