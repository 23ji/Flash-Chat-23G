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
    // ✅ 테이블 뷰 데이터 소스 설정
    self.tableView.dataSource = self
    // ✅ 테이블 뷰 register 설정
    self.tableView.register(
      UINib(nibName: K.cellNibName, bundle: nil),
      forCellReuseIdentifier: K.cellIdentifier)
    self.loadMessages()
  }
  
  
  @IBAction func logout(_ sender: UIBarButtonItem) {
    do { try Auth.auth().signOut() // ✅ 로그아웃 시키고
      self.navigationController?.popToRootViewController(animated: true) // ✅ 루트 뷰로 감
    }
    catch let error as NSError {
      print(error)
    }
  }
  
  // 복습하기 ⭐️
  @IBAction func sendPressed(_ sender: UIButton) {
    // ✅ sender에 email 할당
    guard let sender = Auth.auth().currentUser?.email else { return }
    // ✅ body에 메세지 내용 할당
    guard let body = messageTextfield.text else { return }
    guard body.isEmpty == false else { return }
    // ✅ Firebase Forestore에 딕셔너리 구조로 업로드
    db.collection(K.FStore.collectionName).addDocument(data: [
      "sender": sender,
      "body": body
    ])
  }
  

  func loadMessages() {
    // ✅ Documents 불러옴
    db.collection(K.FStore.collectionName).getDocuments { querySnapShot, error in
      guard error == nil else { return }
      guard let snapShotData = querySnapShot?.documents else { return }
      for doc in snapShotData {
        // ✅ data에 snapShotData data 할당
        let data = doc.data()
        guard let sender = data["sender"] as? String else { return }
        guard let body = data["body"] as? String else { return }
        
        // ✅ Messgae에 sender, body로 값 올리기
        let message = Message(sender: sender, body: body)
        self.messages.append(message)
      }
      // ✅ 화면에 뿌리기
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
  
  // 각 셀에 어떤 내용을 표시할지 반환
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // ✅ MessageCell 구성하는 cell 정의
    let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
    // ✅ cell text에 indexPath.row로 해당하는 값 각각 할당
    cell.label.text = self.messages[indexPath.row].body
    return cell
  }
}
