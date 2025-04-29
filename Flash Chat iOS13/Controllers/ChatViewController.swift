//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import FirebaseAuth

import UIKit

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  
  private var messages: [Message] = [
      Message(sender: "1@2.com", body: "Hey!"),
      Message(sender: "1@3.com", body: "Hi!"),
      Message(sender: "1@5.com", body: "Hello!")
    ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Flash Chat"
    self.navigationItem.hidesBackButton = true
  }
  
  
  @IBAction func sendPressed(_ sender: UIButton) {
  }
  
  @IBAction func logout(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut() // ?
      self.navigationController?.popToRootViewController(animated: true)
    } catch let error as NSError {
      print(error)
    }
  }
  
}
