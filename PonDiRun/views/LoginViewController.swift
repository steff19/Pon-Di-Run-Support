import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
                   Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                       if let e = error {
                           print(e)
                       } else if (email == "1@9.com"){
                           self.performSegue(withIdentifier: "LoginToAdmin", sender: self)
                       }
                       else {
                           self.performSegue(withIdentifier: "LoginToMenu", sender: self)
                       }
                   }
               }
    }
}

