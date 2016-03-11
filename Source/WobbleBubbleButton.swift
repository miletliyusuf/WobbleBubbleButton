//
//  AnimatedBubbleButton.swift
//  AnimatedBubbleButton
//
//  Created by Quang Tran on 3/10/16.
//  Copyright © 2016 ABC Virtual Communications. All rights reserved.
//

import UIKit

@IBDesignable
public class WobbleBubbleButton: UIButton {
  
  override public func awakeFromNib() {
    addAnimationForView(self)
  }
  
  private func random(min min: Double, max: Double) -> Double {
    return Double(arc4random()) / 0xFFFFFFFF * (max - min) + min
  }
  
  //
  //  Refering on http://stackoverflow.com/questions/23927047/button-animate-like-ios-game-center-button
  //
  private func addAnimationForView(view: UIView) {
    
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
    pathAnimation.duration = random(min: 5, max: 8)

    
    //The circle to follow will be inside the circleContainer frame.
    //it should be a frame around the center of your view to animate.
    //do not make it to large, a width/height of 3-4 will be enough.
    let curvedPath = CGPathCreateMutable()
    let circleContainer = CGRectInset(view.frame, 23/50 * view.frame.size.width, 23/50 * view.frame.size.height)
    CGPathAddEllipseInRect(curvedPath, nil, circleContainer);
    
    //add the path to the animation
    pathAnimation.path = curvedPath;
    //release path
    //    CGPathRelease(curvedPath);
    //add animation to the view's layer
    view.layer.addAnimation(pathAnimation, forKey: "myCircleAnimation")
    
    //create an animation to scale the width of the view
    let scaleX = CAKeyframeAnimation(keyPath: "transform.scale.x")
    //set the duration
    scaleX.duration = 2
    //it starts from scale factor 1, scales to 1.05 and back to 1
    scaleX.values = [1, 1.05, 1]
    //time percentage when the values above will be reached.
    //i.e. 1.05 will be reached just as half the duration has passed.
    let scaleXTime = random(min: 1, max: 3)
    scaleX.keyTimes = [0.0, scaleXTime/2, scaleXTime]
    scaleX.repeatCount = Float.infinity;
    //play animation backwards on repeat (not really needed since it scales back to 1)
    scaleX.autoreverses = true
    //ease in/out animation for more natural look
    scaleX.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
    //add the animation to the view's layer
    view.layer.addAnimation(scaleX, forKey: "scaleXAnimation")
    
    //create the height-scale animation just like the width one above
    //but slightly increased duration so they will not animate synchronously
    let scaleY = CAKeyframeAnimation(keyPath: "transform.scale.y")
    scaleY.duration = 2.5
    scaleY.values = [1.0, 1.05, 1.0]
    let scaleYTime = random(min: 1, max: 3)
    scaleY.keyTimes = [0.0, scaleYTime/2, scaleYTime]
    scaleY.repeatCount = Float.infinity
    scaleY.autoreverses = true
    scaleX.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
    view.layer.addAnimation(scaleY, forKey: "scaleYAnimation")
  }
  
  //
  // Code block was created from PaintCode tool trial version
  // Refering on https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSColor_Class/#//apple_ref/occ/instm/NSColor/blendedColorWithFraction:ofColor:
  // http://stackoverflow.com/questions/32293210/no-visible-interface-for-uicolor-declares-the-selector-blendedcolorwithfract
  //
  override public func drawRect(rect: CGRect) {
    
    clipsToBounds = true
    layer.cornerRadius = frame.size.width/2
    
    //// PaintCode Trial Version
    //// www.paintcodeapp.com
    
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    //// Color Declarations
    let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    let whiteTransparent = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.000)
    let black = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
    let grey = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.727)
    let backgroundColor = self.backgroundColor ?? UIColor.clearColor()
    
    //// Gradient Declarations
    let gradientAbove = CGGradientCreateWithColors(
                        CGColorSpaceCreateDeviceRGB(),
                        [
                          white.CGColor,
                          white.blendedColorWithFraction(0.5, ofColor: whiteTransparent).CGColor,
                          whiteTransparent.CGColor,
                          whiteTransparent.CGColor
                        ],
                        [0, 0.21, 0.64, 1])!
    
    let outerGradient = CGGradientCreateWithColors(
                        CGColorSpaceCreateDeviceRGB(),
                        [
                          whiteTransparent.CGColor,
                          whiteTransparent.blendedColorWithFraction(0.5, ofColor: black).CGColor,
                          black.CGColor
                        ],
                        [0, 1, 1])!
    
    let gradienBelow = CGGradientCreateWithColors(
                        CGColorSpaceCreateDeviceRGB(),
                        [
                          whiteTransparent.CGColor,
                          whiteTransparent.blendedColorWithFraction(0.5, ofColor: whiteTransparent).CGColor,
                          whiteTransparent.CGColor,
                          whiteTransparent.blendedColorWithFraction(0.5, ofColor: grey).CGColor,
                          grey.CGColor
                        ],
                        [0, 0.28, 0.28, 1, 1])!
    
    //// BackgroundCircle Drawing
    let backgroundCirclePath = UIBezierPath(ovalInRect: CGRectMake(0, 0, frame.size.width, frame.size.height))
    backgroundColor.setFill()
    backgroundCirclePath.fill()
    
    
    //// OuterCircle Drawing
    let outerCirclePath = UIBezierPath(ovalInRect: CGRectMake(0, 0, frame.size.width, frame.size.height))
    CGContextSaveGState(context)
    outerCirclePath.addClip()
    CGContextDrawRadialGradient(context,
                                outerGradient,
                                CGPointMake(30/60 * frame.size.width, 33.66/60 * frame.size.height),
                                26.14/60*frame.size.height,
                                CGPointMake(30/60 * frame.size.width, 30/60*frame.size.height),
                                30/60*frame.size.height,
                                [
                                  CGGradientDrawingOptions.DrawsBeforeStartLocation,
                                  CGGradientDrawingOptions.DrawsAfterEndLocation
                                ])
    CGContextRestoreGState(context)
    
    
    //// OvalAbove Drawing
    let ovalAbovePath = UIBezierPath(ovalInRect: CGRectMake(12/60 * frame.size.width,
                                                            1/60 * frame.size.height,
                                                            36/60 * frame.size.width,
                                                            28/60 * frame.size.height))
    CGContextSaveGState(context)
    ovalAbovePath.addClip()
    CGContextDrawLinearGradient(context,
                                gradientAbove,
                                CGPointMake(30/60*frame.size.width, 1/60*frame.size.height),
                                CGPointMake(30/60*frame.size.width, 29/60*frame.size.height),
                                CGGradientDrawingOptions())
    CGContextRestoreGState(context)
    
    
    //// OvalBelow Drawing
    let ovalBelowPath = UIBezierPath(ovalInRect: CGRectMake(7/60 * frame.size.width,
                                                            25.5/60 * frame.size.height,
                                                            46/60 * frame.size.width,
                                                            34/60 * frame.size.height))
    CGContextSaveGState(context)
    ovalBelowPath.addClip()
    CGContextDrawLinearGradient(context,
                                gradienBelow,
                                CGPointMake(30/60*frame.size.width, 25.5/60*frame.size.height),
                                CGPointMake(30/60*frame.size.width, 59.5/60*frame.size.height),
                                CGGradientDrawingOptions())
    CGContextRestoreGState(context)
  }
}

extension UIColor {
  
  private func interpolate(a: CGFloat, b: CGFloat, fraction: CGFloat) -> CGFloat {
    return (a + ((b - a) * fraction))
  }
  
  //
  // Refering on https://github.com/heardrwt/RHAdditions/blob/54cbf5735fce73129a21c23c8f23233e5638d006/RHAdditions/UIColor%2BRHInterpolationAdditions.m
  //
  internal func blendedColorWithFraction(fraction: CGFloat, ofColor endColor: UIColor) -> UIColor {
    
    if fraction <= 0.0 { return self }
    
    if fraction >= 1.0 { return endColor }
    
    var a1:CGFloat = 0
    var b1:CGFloat = 0
    var c1:CGFloat = 0
    var d1:CGFloat = 0
    
    var a2:CGFloat = 0
    var b2:CGFloat = 0
    var c2:CGFloat = 0
    var d2:CGFloat = 0
    
    if UIColor.instancesRespondToSelector("getWhite:alpha:") {
      //white
      if getWhite(&a1, alpha: &b1) && endColor.getWhite(&a2, alpha: &b2) {
        return UIColor(white: interpolate(a1, b: a2, fraction: fraction),
          alpha: interpolate(b1, b: b2, fraction: fraction))
      }
      
      //RGB
      if getRed(&a1, green: &b1, blue: &c1, alpha: &d1)
        && endColor.getRed(&a2, green: &b2, blue: &c2, alpha: &d2) {
          return UIColor(red: interpolate(a1, b: a2, fraction: fraction),
            green: interpolate(b1, b: b2, fraction: fraction),
            blue: interpolate(c1, b: c2, fraction: fraction),
            alpha: interpolate(d1, b: d2, fraction: fraction))
      }
      
      //HSB
      if getHue(&a1, saturation: &b1, brightness: &c1, alpha: &d1)
        && endColor.getHue(&a2, saturation: &b2, brightness: &c2, alpha: &d2) {
          return UIColor(hue: interpolate(a1, b: a2, fraction: fraction),
            saturation: interpolate(b1, b: b2, fraction: fraction),
            brightness: interpolate(c1, b: c2, fraction: fraction),
            alpha: interpolate(d1, b: d2, fraction: fraction))
      }
    }
    
    //error
    return UIColor.redColor();
  }
}