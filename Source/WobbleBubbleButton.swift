//
//  AnimatedBubbleButton.swift
//  AnimatedBubbleButton
//
//  Created by Quang Tran on 3/10/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit


open class WobbleBubbleButton: UIButton {
    
    open var bgImage:UIImage!
    
    let screenSize: CGRect = UIScreen.main.bounds
    open var durationBubbleAppear: Double = 2.0
    open var durationBubbleComeToView: Double = 2.0
    open var imageViewFitBackground:UIImageView!
    
    open var fittedBGImage: UIImage? {
        didSet {
            self.imageViewFitBackground = UIImageView.init(frame: self.frame)
            self.imageViewFitBackground.contentMode = .scaleAspectFit
            var imageViewFrame = self.imageViewFitBackground.frame
            let heightRatio = self.frame.size.height / 1.82 // 1.82 = 155/85
            imageViewFrame.size.height = heightRatio
            imageViewFrame.origin.y = (self.frame.size.height - heightRatio) / 2
            imageViewFrame.origin.x = 0
            self.imageViewFitBackground.frame = imageViewFrame
            self.imageViewFitBackground.image = self.fittedBGImage
            self.addSubview(self.imageViewFitBackground)
        }
    }
    
    override open func awakeFromNib() {
        self.setAppearFrames()
        self.addParallaxToView(self)
    }
    
    open func setTitleAndSubTitleText(_ title:String,subTitle:String,font:UIFont? = nil,subTitleFont:UIFont?=nil) {
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
        let attributedText = NSAttributedString(string: title + "\n",
                                                attributes: [
                                                    NSForegroundColorAttributeName: subTitle == "" ? UIColor.white : UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.65),
                                                    NSFontAttributeName: font != nil ? font! : UIFont.systemFont(ofSize: 24)
            ])
        let attributedDetailText = NSAttributedString(string: "\n" + subTitle,
                                                      attributes: [
                                                        NSForegroundColorAttributeName: UIColor.white,
                                                        NSFontAttributeName: subTitleFont != nil ? subTitleFont! : UIFont.systemFont(ofSize: 15)
            ])
        let attributedCombinedText = NSMutableAttributedString()
        attributedCombinedText.append(attributedText)
        attributedCombinedText.append(attributedDetailText)
        self.setAttributedTitle(attributedCombinedText, for: UIControlState())
    }
    
    func setAppearFrames() {
        
        if screenSize.width < 375 {
            self.frame.size.width = self.frame.size.width / 1.4
            self.frame.size.height = self.frame.size.height / 1.4
        }
        
        self.bgImage = self.fittedBGImage
        let size = self.frame.size
        self.layer.cornerRadius = size.width / 2
    }
    
    func addParallaxToView(_ vw: UIView) {
        let amount = 25
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        vw.addMotionEffect(group)
    }
    
    
    func random(_ min: Double, max: Double) -> Double {
        return Double(arc4random()) / 0xFFFFFFFF * (max - min) + min
    }
    
    open func getBaloonsFromUniverse() {
        let instanceOrigin = self.frame.origin
        self.frame.origin = CGPoint.init(x: screenSize.width/2, y: screenSize.height + 400)
        UIView.animate(withDuration: durationBubbleComeToView, animations: {
            self.frame.origin = instanceOrigin
            
        }) 
    }

    open func addAnimationForView(_ view: UIView) {
        
        //create an animation to follow a circular path
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        
        //interpolate the movement to be more smooth
        pathAnimation.calculationMode = kCAAnimationPaced
        //apply transformation at the end of animation (not really needed since it runs forever)
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.isRemovedOnCompletion = false;
        //run forever
        pathAnimation.repeatCount = Float.infinity;
        //no ease in/out to have the same speed along the path
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.duration = random(5, max: 8)
        
        
        //The circle to follow will be inside the circleContainer frame.
        //it should be a frame around the center of your view to animate.
        //do not make it to large, a width/height of 3-4 will be enough.
        let curvedPath = CGMutablePath()

        var startOrigin = self.frame.origin
        startOrigin.x = startOrigin.x + self.frame.size.width / 2
        startOrigin.y = startOrigin.y + self.frame.size.width / 2
        var topOrigin = startOrigin
        topOrigin.x = topOrigin.x + CGFloat(random(0, max: 20))
        topOrigin.y = topOrigin.y + CGFloat(random(0, max: 20))
        var rightOrigin = topOrigin
        rightOrigin.x = rightOrigin.x + CGFloat(random(0, max: 20))
        rightOrigin.y = rightOrigin.y - CGFloat(random(0, max: 20))
        var bottomOrigin = rightOrigin
        bottomOrigin.x = bottomOrigin.x - CGFloat(random(0, max: 20))
        bottomOrigin.y = bottomOrigin.y + CGFloat(random(0, max: 20))
        let endOrigin = startOrigin

        curvedPath.addLines(between: [startOrigin,topOrigin,rightOrigin,bottomOrigin,endOrigin])
        
        //add the path to the animdation
        pathAnimation.path = curvedPath;
        
        let delay = durationBubbleAppear * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            view.layer.add(pathAnimation, forKey: "myCircleAnimation")
        })
        
    }
    
    //
    // Code block was created from PaintCode tool trial version
    // Refering on https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSColor_Class/#//apple_ref/occ/instm/NSColor/blendedColorWithFraction:ofColor:
    // http://stackoverflow.com/questions/32293210/no-visible-interface-for-uicolor-declares-the-selector-blendedcolorwithfract
    //
    open override func draw(_ rect: CGRect) {
        clipsToBounds = true
        layer.cornerRadius = frame.size.width/2
    }
}

extension UIView {
    func fadeIn(_ delay:Double? = nil) {
        UIView.animate(withDuration: 0.5, delay: delay!, options: .curveEaseIn, animations: {
            self.alpha = 1.0
            
        }, completion: nil)
    }
}
