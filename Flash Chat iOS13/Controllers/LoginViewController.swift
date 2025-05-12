//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import FirebaseAuth
import FirebaseCore


import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
      guard let email = self.emailTextfield.text else { return }
      guard let password = self.passwordTextfield.text else { return }
      
      Auth.auth().signIn(withEmail: email, password: password) { result, error in
        guard error == nil else { return }
        
        self.performSegue(withIdentifier: "LoginToChat", sender: nil)
      }
    }
}
