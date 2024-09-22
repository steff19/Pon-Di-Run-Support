import UIKit
import Firebase
import CoreData

class AdminViewController: UITableViewController {
    var orders: [Orders] = []
    var cart = Cart.shared
    var checkedOrders = [Bool]()

    @IBAction func clearCartButton(_ sender: UIButton) {
        presentAreYouSureAlert(on: self) { confirmed in
                if confirmed {
                    // Proceed with clearing the cart
                    self.clearCoreData()
                    self.orders.removeAll()
                    self.tableView.reloadData()
                } else {
                    // Handle the case where the user canceled
                    print("User canceled the action")
                }
            }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        orders = cart.getAllOrders()
        checkedOrders = [Bool](repeating: false, count: orders.count) // Initialize checkedOrders array
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OrderCell")
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        let order = orders[indexPath.row]
        cell.textLabel?.text = "\(order.title ?? "") - \(order.side ?? "none") - \(order.name ?? "")"
        
        // Configure checkmark based on checkedOrders array
       cell.accessoryType = checkedOrders[indexPath.row] ? .checkmark : .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleCheckmark(at: indexPath)
    }

    // MARK: - Helper Methods

    private func toggleCheckmark(at indexPath: IndexPath) {
        checkedOrders[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func clearCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // Get the names of all entities in your Core Data model
        if let entities = appDelegate.persistentContainer.managedObjectModel.entities as [NSEntityDescription]? {
            
            for entity in entities {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                do {
                    try context.execute(batchDeleteRequest)
                    print("Cleared all data from \(entity.name!)")
                } catch {
                    print("Failed to clear data from \(entity.name!): \(error)")
                }
            }
        }
        
        // Save context to persist deletions
        do {
            try context.save()
        } catch {
            print("Failed to save context after clearing: \(error)")
        }
    }
    
    
    func presentAreYouSureAlert(on viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Are you sure?", message: "This action cannot be undone.", preferredStyle: .alert)
        
        // Confirm action
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            completion(true) // Execute completion with true if confirmed
        }
        alert.addAction(confirmAction)
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false) // Execute completion with false if canceled
        }
        alert.addAction(cancelAction)
        
        // Present the alert
        viewController.present(alert, animated: true, completion: nil)
    }
    
   
}

