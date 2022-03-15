//
//  LoginViewController.swift
//  Kachat
//
//  Created by Gino Tasis on 3/8/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
         
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              
                if let er = error {
                    print(er.localizedDescription)
                    // add error functionality where ypu can see the error popped up in the screen
                } else {
                    self!.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        }
    }
}
