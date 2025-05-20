//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import  CLTypingLabel

import UIKit

class WelcomeViewController: UIViewController {
  
  
  @IBOutlet weak var titleLabel: CLTypingLabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    titleLabel.text = "⚡️Flash Chat"
  }
  
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: true)
  }
}
