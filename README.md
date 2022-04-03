# NayaAssignment


The NayaAssignment task completed with MVVM and Coordinator pattern with showing list of Shopping items, detail of items and wishlist.
# Overview

Controller: Contains HomeViewController . This controller fectch the data from the ItemListViewModel.

AddToBagViewController . This controller will be called on clicking any cell from HomeViewController.

WishlistViewController . This controller will be called on clicking on top bookmark button in HomeViewController.

ItemsListViewModel: Contain ItemsRemoteRepository .This module responsible to get the data from the repo and send it to the viewcontroller and then viewController will send data to respective views

Models: Contains ShoppingResponse , ShoppingItem , ShoppingItemLocal

Coordinator: Contains Coordinator and MainCoordinator . The responsiblity of coordinators is to handle the navigation of the app and setup the start of the app.

Repository: Contains ItemsRemoteRepository and ItemsLocalRepository. ItemsRemoteRepository repo will contact with ServiceApi to fetch the Articles and will send back to respective ViewModel and ItemsLocalRepository is dealing Core Data.

# How To run
To run the project use the 12.5 xcode

# App Features
MVVM with Coordinator pattern
Combine
Storyboard
