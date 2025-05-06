//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by 이상지 on 5/4/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
  
  //컴포넌트 연결하기
  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var sender: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.messageBubble.layer.cornerRadius = self.messageBubble.frame.height / 5
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
