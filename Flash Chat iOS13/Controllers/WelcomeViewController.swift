//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleLabel.text = ""
    var charIndex = 0.0
    let title = "⚡️Flash Chat"
    
    for i in title {
      Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { [weak self] timer in
        self?.titleLabel.text?.append(i)
      }
      charIndex += 1
    }
    
    
  }
}
