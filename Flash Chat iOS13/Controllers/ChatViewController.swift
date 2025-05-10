//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

import UIKit

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  private var messages: [Message] = []
  
  let db = Firestore.firestore()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true
    self.title = "Flash chat"
    self.tableView.dataSource = self
    //self.tableView.delegate = self
    self.tableView.register(
      UINib(nibName: K.cellNibName, bundle: nil),
      forCellReuseIdentifier: K.cellIdentifier)
    self.loadMessages()
  }
  
  
  // 복습하기 ⭐️
  @IBAction func logout(_ sender: UIBarButtonItem) {
    do { try Auth.auth().signOut()
      self.navigationController?.popToRootViewController(animated: true)
    }
    catch let error as NSError {
      print(error)
    }
  }
  
  // 복습하기 ⭐️
  @IBAction func sendPressed(_ sender: UIButton) {
    
  }
  
  // 복습하기 ⭐️
  func loadMessages() {
    
  }
  
  
}

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.messages.count
  }
  
  // 복습하기 ⭐️
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  
}
