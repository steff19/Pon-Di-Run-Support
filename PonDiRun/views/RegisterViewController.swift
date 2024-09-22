//
//  ViewController.swift
//  PonDiRun
//
//  Created by stefan mcdonald on 5/16/24.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
//   


    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                }
                else {
                    self.performSegue(withIdentifier: "RegisterToName", sender: self)
                    }
                
                }}
                
            }

}
