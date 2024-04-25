//
//  ProductCell.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 18/04/24.
//

import UIKit

class ProductCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingButton: UIButton!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configuration Method
    
    func setUpCell(product: Product) {
        if let url = URL(string: product.thumbnail) {
            productImageView.load(url: url)
        } else {
            // set placeholder image
        }
        
        titleLabel.text = product.title
        priceLabel.text = String("$\(product.price)")
        categoryLabel.text = product.category
        ratingButton.setTitle(String("\(product.rating)"), for: .normal)
    }
}
