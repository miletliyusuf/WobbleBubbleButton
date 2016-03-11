//
//  ViewController.swift
//  iOS Sample
//
//  Created by Quang Tran on 3/11/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit
import WobbleBubbleButton

class ViewController: UIViewController {

  @IBOutlet weak var button1: WobbleBubbleButton!
  @IBOutlet weak var button2: WobbleBubbleButton!
  @IBOutlet weak var button3: WobbleBubbleButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configBubbleButton(button1, primaryText: "797", subText: "Points", backgroundColor: UIColor.greenColor().colorWithAlphaComponent(0.5))
    configBubbleButton(button2, primaryText: "12", subText: "Friends", backgroundColor: UIColor.purpleColor().colorWithAlphaComponent(0.5))
    configBubbleButton(button3, primaryText: "6", subText: "Games", backgroundColor: UIColor.cyanColor().colorWithAlphaComponent(0.5))
  }
  
  func configBubbleButton(button: WobbleBubbleButton, primaryText: String, subText: String, backgroundColor: UIColor) {
    button.backgroundColor = backgroundColor
    button.titleLabel?.lineBreakMode = .ByWordWrapping
    button.titleLabel?.textAlignment = .Center
    let attributedText = NSAttributedString(string: primaryText + "\n",
      attributes: [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont.systemFontOfSize(40)
      ])
    let attributedDetailText = NSAttributedString(string: subText,
      attributes: [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont.systemFontOfSize(15)
      ])
    let attributedCombinedText = NSMutableAttributedString()
    attributedCombinedText.appendAttributedString(attributedText)
    attributedCombinedText.appendAttributedString(attributedDetailText)
    button.setAttributedTitle(attributedCombinedText, forState: .Normal)
  }


}

