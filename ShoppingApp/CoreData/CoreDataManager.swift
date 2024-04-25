//
//  CoreDataManager.swift
//  ShoppingApp
//
//  Created by Sarika Lande on 21/04/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
        
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getCartProducts() -> [Cart] {
        var products = [Cart]()
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            products = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return products
    }
    
    func getProductQuantity(product: Product) -> Int16 {
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
                
        fetchRequest.predicate = NSPredicate(format: "id == %d", product.id)
        fetchRequest.fetchLimit = 1
        
        do {
          let existingProducts = try context.fetch(fetchRequest)
            if let existingProduct = existingProducts.first {
                return existingProduct.quantity
            }
        } catch {
          print("Error fetching or saving product: \(error)")
        }
        return 0
    }
    
    func addToCart(selectedProduct: ProductDetailViewModel) {
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        
        // Add a predicate to filter by product ID
        
        print("Selected product ID:", selectedProduct.id)

        fetchRequest.predicate = NSPredicate(format: "id == %d", selectedProduct.id)
          
      do {
          // Try to fetch existing product
            let existingProducts = try context.fetch(fetchRequest)
            if let existingProduct = existingProducts.first {
              // Product already exists, update quantity
              existingProduct.quantity += 1
            } else {
              // Product doesn't exist, insert a new one with quantity 1
                insertNewProduct(selectedProduct: selectedProduct)
            }
            
            // Save changes to Core Data
            try context.save()
        } catch {
            print("Error fetching or saving product: \(error)")
        }
    }
    
    func insertNewProduct(selectedProduct: ProductDetailViewModel) {
        let product = Cart(context: context)
        product.id = selectedProduct.id
        product.title = selectedProduct.title
        product.price = selectedProduct.price
        product.rating = selectedProduct.rating
        product.details = selectedProduct.description
        product.brand = selectedProduct.brand
        product.thumbnail = selectedProduct.thumbnail?.absoluteString
        product.imageString = selectedProduct.productImage?.absoluteString
        product.quantity = 1
        saveContext()
    }
}
