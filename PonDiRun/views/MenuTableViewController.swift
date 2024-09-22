import UIKit
import CoreData
import Firebase


class MenuTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray: [Items] = [
         Items(price: 08.0, title: "Soup"),
         Items(price: 03.0, title: "Corn"),
         Items(price: 15.0, title: "Jerk Chicken"),
         Items(price: 25.0, title: "Fish"),
         Items(price: 20.0, title: "Curry Goat")
       ]
    override func viewDidLoad() {
        super.viewDidLoad()
//        clearCoreData()
       }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemsCell", for: indexPath)
        let order = itemArray[indexPath.row]
               cell.textLabel?.text = "\(order.title) - $\(order.price)"
        return cell
    }
    //Selection Pressed method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = itemArray[indexPath.row].copy()
        if (selectedProduct.title != "Soup" && selectedProduct.title != "Corn" ){
            let alert1 = UIAlertController(title: "Add A Side", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Festival", style: .default) { (action) in
                selectedProduct.addSide(side: "Festival")
            }
            alert1.addAction(action)
            let action2 = UIAlertAction(title: "Bammy", style: .default) { (action) in
                selectedProduct.addSide(side: "Bammy")
            }
            alert1.addAction(action2)
            let action3 = UIAlertAction(title: "Rice&Peas", style: .default) { (action) in
                selectedProduct.addSide(side: "Rice&Peas")
            }
            alert1.addAction(action3)
            let action4 = UIAlertAction(title: "White Rice", style: .default) { (action) in
                selectedProduct.addSide(side: "White Rice")
            }
            alert1.addAction(action4)
            present(alert1, animated: true)
        }
        Cart.shared.addOrder(selectedProduct)
                let alert = UIAlertController(title: "Added to Cart", message: "\(selectedProduct.title) has been added to your cart.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
    }


}






