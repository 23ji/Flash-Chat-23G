//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

import UIKit

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  let db = Firestore.firestore()
  
  
  private var messages: [Message] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    title = "Flash Chat"
    self.navigationItem.hidesBackButton = true
    self.tableView.register(
      UINib(nibName: K.cellNibName, bundle: nil),
      forCellReuseIdentifier: K.cellIdentifier
    )
    self.loadMessages()
  }
  
  private func loadMessages() {
    self.db.collection(K.FStore.collectionName).getDocuments { querySnapShot, error in
      if let snapShotDocuments = querySnapShot?.documents {
        for doc in snapShotDocuments {
          let data = doc.data()
          
          if let sender = data[K.FStore.senderField] as? String,
             let body = data[K.FStore.bodyField] as? String {
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
  
  
  @IBAction func sendPressed(_ sender: UIButton) {
    guard let messageSender = Auth.auth().currentUser?.email else { return }
    guard let messageBody = messageTextfield.text else { return }
    guard messageBody.isEmpty == false else { return }
    
    db.collection(K.FStore.collectionName).addDocument(data: [
      K.FStore.senderField: messageSender,
      K.FStore.bodyField: messageBody
    ])
    
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

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
