//
//  ProductDetailCell.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 20/04/24.
//

import UIKit

class ProductDetailCell: UICollectionViewCell {

    // MARK: - Outlet
    
    @IBOutlet weak var productImage: UIImageView! // Outlet for displaying the product image
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Configuration Method
    
    func setUpCell(_ image: String) {
        if let url = URL(string: image) { // Validate or handle non-URL string (optional)
            productImage.load(url: url)
        }
    }
}
