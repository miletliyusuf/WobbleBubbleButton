//
//  AnimatedBubbleButton.swift
//  AnimatedBubbleButton
//
//  Created by Quang Tran on 3/10/16.
//  Copyright © 2016 Quang Tran. All rights reserved.
//

import UIKit


public class WobbleBubbleButton: UIButton {
    
    public var bgImage:UIImage!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    public var durationBubbleAppear: Double = 2.0
    public var durationBubbleComeToView: Double = 2.0
    
    public var fittedBGImage: UIImage? {
        
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
            imView.contentMode = .ScaleAspectFit
            var imageViewFrame = imView.frame
            let heightRatio = self.frame.size.height / 1.82 // 1.82 = 155/85
            imageViewFrame.size.height = heightRatio
            imageViewFrame.origin.y = (self.frame.size.height - heightRatio) / 2
            imageViewFrame.origin.x = 0
            imView.frame = imageViewFrame
            imView.image = self.fittedBGImage
            self.addSubview(imView)
            
            self.bgImage = self.fittedBGImage
            var size = self.frame.size
            self.layer.cornerRadius = size.width / 2
        }
    }
    
    override public func awakeFromNib() {
        self.addParallaxToView(self)
        getBaloonsFromUniverse()
        self.addAnimationForView(self)
    }
    
    
    func addParallaxToView(_ vw: UIView) {
        let amount = 25
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        vw.addMotionEffect(group)
    }
    
    
    func random(min: Double, max: Double) -> Double {
        return Double(arc4random()) / 0xFFFFFFFF * (max - min) + min
    }
    
    func getBaloonsFromUniverse() {
        let instanceOrigin = self.frame.origin
        self.frame.origin = CGPoint.init(x: screenSize.width/2, y: screenSize.height + 400)
        UIView.animateWithDuration(durationBubbleComeToView) {
            self.frame.origin = instanceOrigin
            
        }
    }
    
    //
    //  Refering on http://stackoverflow.com/questions/23927047/button-animate-like-ios-game-center-button
    //
    func addAnimationForView(_ view: UIView) {
        
        //create an animation to follow a circular path
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        
        //interpolate the movement to be more smooth
        pathAnimation.calculationMode = kCAAnimationPaced
        //apply transformation at the end of animation (not really needed since it runs forever)
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = false;
        //run forever
        pathAnimation.repeatCount = Float.infinity;
        //no ease in/out to have the same speed along the path
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.duration = random(5, max: 8)
        
        
        //The circle to follow will be inside the circleContainer frame.
        //it should be a frame around the center of your view to animate.
        //do not make it to large, a width/height of 3-4 will be enough.
        let curvedPath = CGPathCreateMutable()
        //        path.addLine(to: CGPoint(x: 10.0, y: 10.0))
        
        //        let circleContainer = view.frame.insetBy(dx: 25/50 * view.frame.size.width, dy: 23/50 * view.frame.size.height)
        
        //        curvedPath.addEllipse(in: circleContainer)
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
        //        endOrigin.x = endOrigin.x + CGFloat(random(min: -10, max: 10))
        //        endOrigin.y = endOrigin.y + CGFloat(random(min: -10, max: 10))
        //curvedPath.addLines(between: [startOrigin,topOrigin,rightOrigin,bottomOrigin,endOrigin])
        //curvedPath.a
        CGPathAddLines(curvedPath, nil, [startOrigin,topOrigin,rightOrigin,bottomOrigin,endOrigin], 5)
        //TODO
        
        //add the path to the animdation
        pathAnimation.path = curvedPath;
        
        let delay = durationBubbleAppear * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            view.layer.addAnimation(pathAnimation, forKey: "myCircleAnimation")
        })
        
    }
    
    //
    // Code block was created from PaintCode tool trial version
    // Refering on https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSColor_Class/#//apple_ref/occ/instm/NSColor/blendedColorWithFraction:ofColor:
    // http://stackoverflow.com/questions/32293210/no-visible-interface-for-uicolor-declares-the-selector-blendedcolorwithfract
    //
    func draw(_ rect: CGRect) {
        clipsToBounds = true
        layer.cornerRadius = frame.size.width/2
    }
}

extension UIView {
    func fadeIn(delay:Double? = nil) {
        UIView.animateWithDuration(0.5, delay: delay!, options: .CurveEaseIn, animations: {
            self.alpha = 1.0
            
        }, completion: nil)
    }
    
    //    func fadeOut(delay:Double? = nil) {
    //
    //
    //        UIView.animateWithDuration(0.5, delay: delay!, options: .CurveEaseOut, animations: {
    //            self.alpha = 0.0
    //            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)
    //            //self.transform = self.transform.
    //            self.tra
    //            //TODO
    //            }, completion: nil)
    //    }
}
