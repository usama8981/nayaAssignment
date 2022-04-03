//
//  AdToBagViewController.swift
//  NayaAssignment
//
//  Created by Usama Ali on 03/04/2022.
//

import UIKit
import Combine

class AddToBagViewController: UIViewController {
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var itemImage: AsyncImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orignalPriceLabel: UILabel!
    @IBOutlet weak var addtoBagButton: UIButton!
    
    var item: ShoppingItemsViewModel
    var viewModel : ItemsListViewModel
    required init?(
        coder: NSCoder,
        andViewModel viewModel: ItemsListViewModel ,
        andItem item : ShoppingItemsViewModel
    ) {
        self.viewModel = viewModel
        self.item = item
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavButton()
        self.configureView()
    }
    
    private func configureView(){
        self.itemImage.loadUrl(item.imageURL, completion: nil)
        self.brandLabel.text = item.brand
        self.nameLabel.text = item.name
        self.priceLabel.text = "\(item.price)".paymentFormatted()
        self.orignalPriceLabel.text = "\(item.originalPrice)".paymentFormatted()
        
        if item.isAddedToBag{
            self.addtoBagButton.isUserInteractionEnabled = false
            self.addtoBagButton.alpha = 0.5
        }
        
    }
    private func setupNavButton() {
        self.title = ""
        if item.isAddedToWishList{
            let addWishlistButton = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .done, target: self, action: #selector(tappedWishlist(_:)))
            addWishlistButton.tintColor = .black
            navigationItem.rightBarButtonItem = addWishlistButton
        }
        else{
            let addWishlistButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action: #selector(tappedWishlist(_:)))
            addWishlistButton.tintColor = .black
            navigationItem.rightBarButtonItem = addWishlistButton
        }
        
        let addBackButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(tappedBack(_:)))
        addBackButton.tintColor = .black
        navigationItem.leftBarButtonItem = addBackButton
    }
    
    @IBAction func addToBagAction(_ sender: Any) {
        item.isAddedToBag = !item.isAddedToBag
        if item.isAddedToBag{
            self.addtoBagButton.isUserInteractionEnabled = false
            self.addtoBagButton.alpha = 0.5
        }
        viewModel.updateWishlistItemWithItem(item: item)
    }
    @objc private func tappedWishlist(_ sender: UIButton){
        
        item.isAddedToWishList = !item.isAddedToWishList
        viewModel.updateWishlistItemWithItem(item: item)
        if item.isAddedToWishList{
            let addWishlistButton = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .done, target: self, action: #selector(tappedWishlist(_:)))
            addWishlistButton.tintColor = .black
            navigationItem.rightBarButtonItem = addWishlistButton
        }
        else{
            let addWishlistButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action: #selector(tappedWishlist(_:)))
            addWishlistButton.tintColor = .black
            navigationItem.rightBarButtonItem = addWishlistButton
        }
        
    }
    @objc private func tappedBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
