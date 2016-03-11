//
//  ViewController.swift
//  AnimatedBubbleButton
//
//  Created by Quang Tran on 3/10/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit
import WobbleBubbleButton

class ViewController: UIViewController {

  @IBOutlet weak var myButton: WobbleBubbleButton!
  @IBOutlet weak var myButton2: WobbleBubbleButton!
  @IBOutlet weak var myButton3: WobbleBubbleButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configBubbleButton(myButton, primaryText: "797", subText: "Points", backgroundColor: UIColor.greenColor().colorWithAlphaComponent(0.5))
    configBubbleButton(myButton2, primaryText: "12", subText: "Friends", backgroundColor: UIColor.purpleColor().colorWithAlphaComponent(0.5))
    configBubbleButton(myButton3, primaryText: "6", subText: "Games", backgroundColor: UIColor.cyanColor().colorWithAlphaComponent(0.5))
  }
  
  func configBubbleButton(myButton: WobbleBubbleButton, primaryText: String, subText: String, backgroundColor: UIColor) {
    myButton.backgroundColor = backgroundColor
    myButton.titleLabel?.lineBreakMode = .ByWordWrapping
    myButton.titleLabel?.textAlignment = .Center
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
    myButton.setAttributedTitle(attributedCombinedText, forState: .Normal)
  }

  @IBAction func myButtonTapped(sender: AnyObject) {
    print(myButton.titleLabel?.text)
  }
}

