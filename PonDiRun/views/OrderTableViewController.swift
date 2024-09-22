import UIKit
import CoreData
import Firebase

class OrderTableViewController: UITableViewController {
    
    var cart = Cart.shared
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let nameOfCus =  Auth.auth().currentUser?.displayName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath)
            let order = cart.items[indexPath.row]
            cell.textLabel?.text = "\(order.title) - $\(order.price) \(order.side)"
            return cell
        }
    //delete item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               cart.removeOrder(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .automatic)
           }
       }
    
    @IBAction func checkOut(_ sender: UIButton) {
        let total = cart.getTotal()
        
        cart.checkGo(n: nameOfCus ?? "")
        cart.clearCart()
        saveItems()
        let alert = UIAlertController(title: "Checkout", message: "Total: $\(total). Order placed!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true) {
            self.tableView.reloadData()
        }
    }
    
    func saveItems() {
          
          do {
            try context.save()
          } catch {
             print("Error saving context \(error)")
          }
          
          self.tableView.reloadData()
      }
    }
    
   
    


