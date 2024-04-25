//
//  CartCell.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 20/04/24.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quntityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCell(product: Product)
    {
        brandLabel.text = product.brand
        titleLabel.text = product.title
        
        let quantity = CoreDataManager.shared.getProductQuantity(product: product)
        quntityLabel.text = "Qty \(quantity)"
        
        priceLabel.text = "$\(product.price)"
        if let url = URL(string: product.thumbnail) {
            productImageView.load(url: url)
        }
    }
}
