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
    self.tableView.register(
      UINib(nibName: K.cellNibName, bundle: nil),
      forCellReuseIdentifier: K.cellIdentifier
    )
    self.loadMessages()
  }
  
  
  @IBAction func logout(_ sender: UIBarButtonItem) {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
      self.navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
  }
  
  
  @IBAction func sendPressed(_ sender: UIButton) {
    guard let sender = Auth.auth().currentUser?.email else { return }
    guard let body = self.messageTextfield.text else { return }
    
    // ❗️복습하기
    db.collection(K.FStore.collectionName).addDocument(data: [
      "sender" : sender,
      "body" : body,
      "date" : Date().timeIntervalSince1970
    ])
  }
  
  
  func loadMessages() {
    db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapShot, error in
      guard error == nil else { return }
      
      guard let documents = querySnapShot?.documents else { return }
      
      for doc in documents {
        let data = doc.data()
        
        let sender = data["sender"] as! String
        let body = data["body"] as! String
        let message = Message(sender: sender, body: body)
        self.messages.append(message)
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
    let cell = self.tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
    guard let email = Auth.auth().currentUser?.email else { return UITableViewCell() }
    
//    if email == self.messages[indexPath.row].sender {
//      cell.leftImage.isHidden = true
//      cell.messageBubble.backgroundColor = UIColor(named: "BrandPurple")
//      cell.label.textColor = UIColor(named: "BrandLightPurple")
//    } else {
//      cell.rightImage.isHidden = true
//      cell.messageBubble.backgroundColor = UIColor(named: "BrandLightPurple")
//      cell.label.textColor = UIColor(named: "BrandPurple")
//    }
    
    cell.leftImage.isHidden = self.messages[indexPath.row].sender == email ? true : false
    cell.rightImage.isHidden = self.messages[indexPath.row].sender == email ? false : true
    
    cell.messageBubble.backgroundColor = self.messages[indexPath.row].sender == email ? UIColor(named: "BrandPurple") : UIColor(named: "BrandLightPurple")
    
    cell.label.textColor = self.messages[indexPath.row].sender == email ? UIColor(named: "BrandLightPurple") : UIColor(named: "BrandPurple")
    // ❗️ 복습하기
    cell.label.text = self.messages[indexPath.row].body
    return cell
  }
}
