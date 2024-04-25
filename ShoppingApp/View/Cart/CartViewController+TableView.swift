//
//  CartViewController+TableView.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 20/04/24.
//

import Foundation
import UIKit

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartCell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        cartCell.setUpCell(product: self.viewModel.cartProducts[indexPath.row])
        return cartCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cartProducts.count
    }
}
