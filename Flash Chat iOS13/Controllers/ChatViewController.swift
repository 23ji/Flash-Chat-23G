//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

import UIKit

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  var messages: [Message] = []
  
  let db = Firestore.firestore()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.setHidesBackButton(true, animated: true)
    
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    self.loadMessages()
  }
  
  
  @IBAction func logout(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
      self.navigationController?.popToRootViewController(animated: true)}
    catch let error as NSError {
      print(error)
    }
  }
  
  @IBAction func sendPressed(_ sender: UIButton) {
  }
  
  func loadMessages() {
    self.db.collection(K.FStore.collectionName).addSnapshotListener { querySnapShot, error in
      guard error == nil else { return }
      
      self.messages = []
      
      if let document = querySnapShot?.documents{
        for doc in document{
          let data = doc.data()
          
          let sender = data["sender"] as! String
          let body = data["body"] as! String
          
          // Message 모델 객체를 하나 만든다.
          let message = Message(sender: sender, body: body)
          // messages에 append 한다.
          self.messages.append(message)
          print(self.messages)
        }
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
}

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
    
    cell.label.text = messages[indexPath.row].body
    return cell
  }
  
  
}
