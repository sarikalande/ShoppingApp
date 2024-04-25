//
//  CartViewController.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 19/04/24.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: - Properties
    
    var viewModel: CartViewModel
    @IBOutlet weak var cartTableView: UITableView! // Outlet for the table view displaying cart items
    
    // MARK: - Initialization
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CartViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        self.cartTableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
    }
    
    // MARK: - Setup Methods
    
    func setUpNavigationBar() {
        self.navigationItem.title = "Cart"
    }
    
    // MARK: - Action Methods
    
    @IBAction func placeOrderAction(_ sender: Any) {
        showAlert(title: "Success", message: "Your order is placed successfully!!")
    }
}
