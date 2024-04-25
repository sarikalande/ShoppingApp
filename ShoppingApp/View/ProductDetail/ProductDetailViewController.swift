//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 19/04/24.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var viewModel: ProductDetailViewModel
    
    @IBOutlet weak var productDetailsCollectionView: UICollectionView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.productDetailsCollectionView.register(UINib.init(nibName: "ProductDetailCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailCell")
        setupUI()
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        self.viewModel.addToCart()
        showAlert(title: "Success", message: "Added to the cart")
    }
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ProductDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let product = self.viewModel.productDetails
        brandLabel.text = product.brand
        descriptionLabel.text = product.description
        priceLabel.text = String("$\(product.price) (\(product.discountPercentage)% OFF)")
        ratingButton.setTitle(String(product.rating), for: .normal)
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = viewModel.productDetails.images.count
        return viewModel.productDetails.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailCell", for: indexPath) as! ProductDetailCell
        cell.setUpCell(viewModel.productDetails.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width , height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard  scrollView == productDetailsCollectionView else { return }
        
        let pageWidth = scrollView.frame.width
        let pageNumber = Int(self.productDetailsCollectionView.contentOffset.x / pageWidth)
        
        self.pageControl.currentPage = pageNumber
    }
}
