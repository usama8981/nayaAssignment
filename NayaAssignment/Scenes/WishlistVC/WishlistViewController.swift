//
//  WishlistViewController.swift
//  NayaAssignment
//
//  Created by Usama Ali on 03/04/2022.
//

import UIKit

class WishlistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items: [ShoppingItemsViewModel]
    var viewModel : ItemsListViewModel
    
    required init?(
        coder: NSCoder,
        andViewModel viewModel: ItemsListViewModel ,
        andItem item : [ShoppingItemsViewModel]
    ) {
        self.viewModel = viewModel
        self.items = item
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.hidesBackButton = true
        let addButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(backPressed(_:)))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
        self.title = "Wishlist (\(items.count))".uppercased()
    }
    
    @objc func removeAction(_ sender: UIButton){
        let item  = items[sender.tag]
        item.isAddedToWishList = !item.isAddedToWishList
        viewModel.updateWishlistItemWithItem(item: item)
        items.remove(at: sender.tag)
        tableView.reloadData()
        self.title = "Wishlist (\(items.count))".uppercased()
    }
    @objc private func backPressed(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension WishlistViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell") as! WishlistTableViewCell
        cell.configureCell(item: items[indexPath.row])
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(removeAction(_:)), for: .touchUpInside)
        return cell
    }
    
}
