//
//  HomeViewController.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 18/04/24.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets and Properties
    
    @IBOutlet weak var productTableView: UITableView! // Outlet for the table view displaying products
    var viewCartButton: UIBarButtonItem! // View model instance for data and logic
    let viewModel = HomeViewModel(httpClient: HttpClient())
    private var activityIndicator: UIActivityIndicatorView! // Activity indicator for loading state
    var products: [Product] = [] // Array to store product data
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupTableView()
        setUpNavigationBar()
        initViewModel()
    }
    
    // MARK: - Setup Methods
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setupTableView() {
        self.productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    private func setUpNavigationBar() {
        self.navigationItem.title = "Products"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.fill"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(navigationButtonTapped))
    }
    
    private func initViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] data in
               DispatchQueue.main.async {
                   self?.productTableView.reloadData()
                   self?.activityIndicator.stopAnimating()
               }
           }
        viewModel.fetchProductList()
    }

    // MARK: - Action Methods
    
    @objc func navigationButtonTapped() {
        let products = CoreDataManager.shared.getCartProducts()
        let productDetail = products.map { coreDataObject in
            return Product(
                id: coreDataObject.id,
                title: coreDataObject.title ?? "",
                description: coreDataObject.details ?? "",
                price: coreDataObject.price,
                discountPercentage: coreDataObject.discountPercentage, 
                rating: coreDataObject.rating,
                brand: coreDataObject.brand,
                category: coreDataObject.category,
                thumbnail: coreDataObject.thumbnail ?? "",
                images: [coreDataObject.imageString ?? ""])
        }
        let cartViewModel = CartViewModel(initialProducts: productDetail)
        let cartViewController = CartViewController(viewModel: cartViewModel)
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    func navigateToProductDetails(_ productId: Int) {
        if let productDetails = self.viewModel.retriveProduct(with: productId) {
            let productDetailsViewModel = ProductDetailViewModel(product: productDetails)
            let productDetailsViewController = ProductDetailViewController(viewModel: productDetailsViewModel)
            self.navigationController?.pushViewController(productDetailsViewController, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Return the number of sections (usually 1 for a product list)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Set the desired height for each product cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            productCell.setUpCell(product: self.viewModel.products[indexPath.row])
            return productCell
        } else {
            // Handle case where cell dequeue fails (optional)
            return UITableViewCell()  // Or return a default cell
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product =  self.viewModel.products[indexPath.row]
        self.navigateToProductDetails(Int(product.id))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if contentHeight <= 0 { return }

        if offsetY > contentHeight - screenHeight {
            let contentHeight = scrollView.contentSize.height
            let scrollOffset = scrollView.contentOffset.y + scrollView.frame.size.height
            if contentHeight > 0 && scrollOffset >= contentHeight {
                viewModel.fetchProductList()
            }
        }
    }
}
