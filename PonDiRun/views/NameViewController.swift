import UIKit
import Firebase

class NameViewController: UIViewController {
    @IBOutlet weak var nameTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        guard let user = Auth.auth().currentUser else { return }
        let changeRequest =    user.createProfileChangeRequest()
        changeRequest.displayName = nameTextfield.text
        changeRequest.commitChanges { profileError in
            if let profileError = profileError {
                // Handle profile update error
                print("something wrong")
            } else {
                // Profile updated successfully
                self.saveUserDetailsToFirestore(user: user, displayName: changeRequest.displayName!)
                               print("User created and profile updated successfully")
                self.performSegue(withIdentifier: "NameToMenu", sender: self)
            }
        }
    }
    
    func saveUserDetailsToFirestore(user: User, displayName: String) {
             let db = Firestore.firestore()
             db.collection("users").document(user.uid).setData([
                 "displayName": displayName
             ]) { error in
                 if let error = error {
                     print("Error saving user details: \(error.localizedDescription)")
                 } else {
                     print("User details saved successfully")
                 }
             }
         }
    
}








