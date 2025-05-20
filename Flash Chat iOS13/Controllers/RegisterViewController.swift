//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
      
      guard let email = emailTextfield.text else { return }
      guard let password = passwordTextfield.text else { return }
      
      Auth.auth().signIn(withEmail: email, password: password) { result, error in
        guard error == nil else { return }
        self.performSegue(withIdentifier: "RegisterToChat", sender: nil)
      }
    }
    
}
