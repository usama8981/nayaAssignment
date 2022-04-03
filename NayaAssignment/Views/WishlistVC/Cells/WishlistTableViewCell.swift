//
//  WishlistTableViewCell.swift
//  NayaAssignment
//
//  Created by Usama Ali on 03/04/2022.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: AsyncImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 14),
          .foregroundColor: UIColor.darkGray,
          .underlineStyle: NSUnderlineStyle.single.rawValue
      ] // .double.rawValue, .thick.rawValue
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: ShoppingItemsViewModel){
        let attributeString = NSMutableAttributedString(
                string: "Remove",
                attributes: yourAttributes
             )
        removeButton.setAttributedTitle(attributeString, for: .normal)
        itemImageView.loadUrl(item.imageURL, completion: nil)
        brandLabel.text = item.brand
        nameLabel.text = item.name
        priceLabel.text = "\(item.price)".paymentFormatted()
    }

}
