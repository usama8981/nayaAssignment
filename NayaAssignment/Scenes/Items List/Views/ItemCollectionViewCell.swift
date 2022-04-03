//
//  ItemCollectionViewCell.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import UIKit
//import SDWebImage
class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: AsyncImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var addToWishlistButton: UIButton!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orignalPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(item:ShoppingItemsViewModel){
        
        itemImageView.loadUrl(item.imageURL, completion: nil)
        skuLabel.text = item.name
        nameLabel.text = item.brand
        priceLabel.text = "\(item.price)".paymentFormatted()
        if item.originalPrice > 0 {
            orignalPriceLabel.isHidden = false
            orignalPriceLabel.attributedText = " \(item.originalPrice)".paymentFormatted().createAttributedString(stringtToStrike: "\(item.originalPrice)".paymentFormatted())
        }
        else{
            orignalPriceLabel.isHidden = true
        }
        
        if item.badges.count == 0 {
            newLabel.superview?.isHidden = true
            saleLabel.superview?.isHidden = true
        }
        if item.badges.count == 1{
            if item.badges.contains("NEW"){
                saleLabel.superview?.isHidden = true
            }
            else{
                newLabel.superview?.isHidden = true
            }
        }
        else{
            newLabel.superview?.isHidden = false
            saleLabel.superview?.isHidden = false
        }
        
        if item.isAddedToWishList {
            self.addToWishlistButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        else{
            self.addToWishlistButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        
    }
    
}
