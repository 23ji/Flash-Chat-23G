//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by 이상지 on 5/20/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
  
  @IBOutlet weak var rightImage: UIImageView!
  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var label: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.messageBubble.layer.cornerRadius = self.messageBubble.frame.height / 5
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
