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
  
  @IBAction func sendPressed(_ sender: UIButton) {
  }
  
  func loadMessages() {
    db.collection(K.FStore.collectionName).getDocuments { querySnapShot, error in
      guard let snapShotData = querySnapShot?.documents else { return }
      for document in snapShotData {
        let doc = document.data()
        
        if let sender = doc["sender"] as? String ,
           let body = doc["body"] as? String {
          let message = Message(sender: sender, body: body)
          self.messages.append(message)
        }
      }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  
}

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = self.tableView.dequeueReusableCell(
      withIdentifier: K.cellIdentifier,
      for: indexPath) as? MessageCell else { return UITableViewCell()}
    cell.label.text = self.messages[indexPath.row].body
    return cell
  }
  
  
}
