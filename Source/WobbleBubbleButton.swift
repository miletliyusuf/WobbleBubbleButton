//
//  AnimatedBubbleButton.swift
//  AnimatedBubbleButton
//
//  Created by Quang Tran on 3/10/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit

@IBDesignable
open class WobbleBubbleButton: UIButton {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    @IBInspectable var fittedBGImage: UIImage? {
        
        didSet {
            var bFrame = self.frame
            bFrame.size.width = screenSize.width / 2.41 //2.41 = 375 / 155
            bFrame.size.height = bFrame.size.width
            
            if bFrame.origin.x + 25 > screenSize.width - bFrame.size.width {
                bFrame.origin.x = screenSize.width - bFrame.size.width + 25
            }
            if bFrame.origin.x < -30 {
                bFrame.origin.x = -30
            }
            if bFrame.origin.y > screenSize.height - bFrame.size.height - 64 {
                bFrame.origin.y = screenSize.height - bFrame.size.height - 64
            }
            
            self.frame = bFrame
            
            let imView = UIImageView.init(frame: self.frame)
            imView.contentMode = .scaleAspectFit
            var imageViewFrame = imView.frame
            let heightRatio = self.frame.size.height / 1.82 // 1.82 = 155/85
            imageViewFrame.size.height = heightRatio
            imageViewFrame.origin.y = (self.frame.size.height - heightRatio) / 2
            imageViewFrame.origin.x = 0
            imView.frame = imageViewFrame
            imView.image = self.fittedBGImage
            self.addSubview(imView)
            
            
        }
    }
    
    override open func awakeFromNib() {
        addAnimationForView(self)
        addParallaxToView(self)
    }
    
    fileprivate func addParallaxToView(_ vw: UIView) {
        let amount = 100
        
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
    
    fileprivate func random(min: Double, max: Double) -> Double {
        return Double(arc4random()) / 0xFFFFFFFF * (max - min) + min
    }
    
    //
    //  Refering on http://stackoverflow.com/questions/23927047/button-animate-like-ios-game-center-button
    //
    fileprivate func addAnimationForView(_ view: UIView) {
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
        pathAnimation.duration = random(min: 5, max: 8)
        
        
        //The circle to follow will be inside the circleContainer frame.
        //it should be a frame around the center of your view to animate.
        //do not make it to large, a width/height of 3-4 will be enough.
        let curvedPath = CGMutablePath()
        let circleContainer = view.frame.insetBy(dx: 23/50 * view.frame.size.width, dy: 23/50 * view.frame.size.height)
        //    CGPathAddEllipseInRect(curvedPath, nil, circleContainer);
        curvedPath.addEllipse(in: circleContainer)
        
        //add the path to the animation
        pathAnimation.path = curvedPath;
        //release path
        //    CGPathRelease(curvedPath);
        //add animation to the view's layer
        view.layer.add(pathAnimation, forKey: "myCircleAnimation")
        
        //create an animation to scale the width of the view
        let scaleX = CAKeyframeAnimation(keyPath: "transform.scale.x")
        //set the duration
        scaleX.duration = 2
        //it starts from scale factor 1, scales to 1.05 and back to 1
        scaleX.values = [1, 1.05, 1]
        //time percentage when the values above will be reached.
        //i.e. 1.05 will be reached just as half the duration has passed.
        let scaleXTime = random(min: 1, max: 3)
        //    scaleX.keyTimes = [0.0, scaleXTime/2, scaleXTime]
        scaleX.keyTimes = [0.0, NSNumber(value: scaleXTime/2), NSNumber(value: scaleXTime)]
        scaleX.repeatCount = Float.infinity;
        //play animation backwards on repeat (not really needed since it scales back to 1)
        scaleX.autoreverses = true
        //ease in/out animation for more natural look
        scaleX.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        //add the animation to the view's layer
        view.layer.add(scaleX, forKey: "scaleXAnimation")
        
        //create the height-scale animation just like the width one above
        //but slightly increased duration so they will not animate synchronously
        let scaleY = CAKeyframeAnimation(keyPath: "transform.scale.y")
        scaleY.duration = 2.5
        scaleY.values = [1.0, 1.05, 1.0]
        let scaleYTime = random(min: 1, max: 3)
        scaleY.keyTimes = [0.0, NSNumber(value: scaleYTime/2), NSNumber(value: scaleYTime)]
        scaleY.repeatCount = Float.infinity
        scaleY.autoreverses = true
        scaleX.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.layer.add(scaleY, forKey: "scaleYAnimation")
    }
    
    //
    // Code block was created from PaintCode tool trial version
    // Refering on https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSColor_Class/#//apple_ref/occ/instm/NSColor/blendedColorWithFraction:ofColor:
    // http://stackoverflow.com/questions/32293210/no-visible-interface-for-uicolor-declares-the-selector-blendedcolorwithfract
    //
    override open func draw(_ rect: CGRect) {
        clipsToBounds = true
        layer.cornerRadius = frame.size.width/2
    }
}
