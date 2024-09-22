//
//  Orders.swift
//  PonDiRun
//
//  Created by stefan mcdonald on 5/28/24.
//

import Foundation
import CoreData
import UIKit

@objc(Orders)
public class Orders: NSManagedObject {

     
}


extension Orders {
    func addSide(side: String){
        self.side = side
               }
}

class Items {
    
    var price: Double
    var title: String
    var side: String = ""
    
    // Initializer
    init( price: Double, title: String) {
        
        self.price = price
        self.title = title
        
    }
    func addSide(side: String){
        self.side = side
    }
    func copy() -> Items {
            return Items(price: self.price, title: self.title)
        }
}



class Cart {
    static let shared = Cart()
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    private(set) var items: [Items] = []
    private(set) var orders: [Orders] = []
    private init() {}
    
    func addOrder(_ item: Items) {
        items.append(item)
    }
    
    func removeOrder(at index: Int) {
        if index >= 0 && index < items.count {
            items.remove(at: index)
        }
    }
    
    func getTotal() -> Double {
        return items.reduce(0) { $0 + $1.price }
    }
    
    func checkGo(n: String) {
        // Create a new Orders object for each order
        for item in items {
            let newOrder = Orders(context: self.context)
            newOrder.title = item.title
            newOrder.price = item.price
            newOrder.side = item.side
            newOrder.name = n
            // Save the new order
            orders.append(newOrder)
        }
        
        saveItems()
        clearCart() // Clear the cart after checkout
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func getAllOrders() -> [Orders] {
        let fetchRequest: NSFetchRequest<Orders> = Orders.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch orders: \(error)")
            return []
        }
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}


class Name {
    static let shared = Name()
    private(set) var name: String = " "
    
    func addName(name: String){
        self.name = name
    }
    
    func  getName() -> String {
        return name
    }
    
}


