//
//  RegisterViewController.swift
//  Kachat
//
//  Created by Gino Tasis on 3/8/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text,  let password = passwordTextField.text {

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          
            if let er = error {
                print(er.localizedDescription)
                // to add NSTimer function for a label issue to be added, bolded in red, will go away after 3 seconds
                
                
            } else {
                // Navigate to the Chat view controller
                //segue: registerToChat
                self.performSegue(withIdentifier: Constants.registeSegue, sender: self)
                
            }
            
        }
    }
}
}
