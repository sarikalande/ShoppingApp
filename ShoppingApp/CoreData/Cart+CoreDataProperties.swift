//
//  Cart+CoreDataProperties.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 21/04/24.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: Int16
    @NSManaged public var price: Double
    @NSManaged public var rating: Double
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var discountPercentage: Double
    @NSManaged public var brand: String
    @NSManaged public var imageString: String?
    @NSManaged public var category: String
    @NSManaged public var quantity: Int16
}

extension Cart : Identifiable {

}
