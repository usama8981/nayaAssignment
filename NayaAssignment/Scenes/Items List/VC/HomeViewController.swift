//
//  ViewController.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private var viewModel: ItemsListViewModel
    private var subscriptions: Set<AnyCancellable> = []
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    required init?(
        coder: NSCoder,
        andViewModel viewModel: ItemsListViewModel
    ) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureViewModel()
    }
    private func setupView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        self.setupNavButton()
    }
    func setupNavButton() {
        self.title = "NEW IN"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action: #selector(tappedWishlist(_:)))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
    }
    private func configureViewModel() {
        viewModel = ItemsListViewModel()
        viewModel.articlesReloadPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let strongSelf = self else { return }
                if status {
                    self?.collectionView.reloadData()
                } else {
                    Utility.showAlert(title: "Error", message: "Some error occurred", on: strongSelf)
                }
                self?.hideActivityIndicator()
            }.store(in: &subscriptions)
        
        fetchItems()
    }
    
    @objc private func fetchItems(){
        self.showActivityIndicator()
        viewModel.fetchItems()
    }
    
    @objc private func tappedWishlist(_ sender: UIButton){
        let wishlistItems = viewModel.currentDisplayedArticles.filter{ $0.isAddedToWishList == true }
        coordinator?.openWishlistVC(wishlistItems, viewModel)
    }
    
    @objc private func tappedAddToWishlist(_ sender: UIButton){
        self.viewModel.updateWishlistItem(index: sender.tag)
    }
    private func openItemsDetail(_ index : Int) {
        let itemViewModel = viewModel.currentDisplayedArticles[index]
        coordinator?.openItemsDetail(itemViewModel, viewModel)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.currentDisplayedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath)as! ItemCollectionViewCell
        cell.configureCell(item: self.viewModel.currentDisplayedArticles[indexPath.row])
        cell.addToWishlistButton.tag = indexPath.row
        cell.addToWishlistButton.addTarget(self, action: #selector(tappedAddToWishlist(_:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openItemsDetail(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 32)/2
        return CGSize(width: width, height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 12, bottom: 0, right: 12)
    }
}
