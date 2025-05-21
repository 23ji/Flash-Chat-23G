//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import FirebaseAuth
import FirebaseFirestore

import UIKit

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  var message: [Message] = []
  
  let db = Firestore.firestore()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.setHidesBackButton(true, animated: true)
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
    db.collection(K.FStore.collectionName).document().addSnapshotListener { querySnapShot, error in
      guard error == nil else { return }
      
      guard let document = querySnapShot?.data() else { return }
      
      for doc in document {
        print(doc)
        print(doc.key)
        print(doc.value)
      }
    }
  }
}
