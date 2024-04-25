//
//  UIImageViewExtension.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 19/04/24.
//

import UIKit

//Load a remote image URL into UIImageView
extension UIImageView {
    func load(url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let data = try? Data(contentsOf: url) {
                   if let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}
