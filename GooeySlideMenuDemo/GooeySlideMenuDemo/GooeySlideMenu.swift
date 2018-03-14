//
//  GooeySlideMenu.swift
//  GooeySlideMenuDemo
//
//  Created by fox on 2018/3/13.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let constantMargin: CGFloat = 50

class GooeySlideMenu: UIView {

    
    fileprivate var sideHelperView: UIView!
    fileprivate var centerHelperView: UIView!
    fileprivate var keyWindow: UIWindow = (UIApplication.shared.delegate?.window!)!
    
    fileprivate let helpViewWidth: CGFloat = 40
    
    fileprivate var displayLink: CADisplayLink?
    fileprivate var animationCount = 0
    fileprivate var diff: CGFloat = 0
    fileprivate var isTriggered: Bool = false
    
    override func draw(_ rect: CGRect) {
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: screenWidth/2, y: 0))
        bezierPath.addQuadCurve(to: CGPoint(x: screenWidth/2, y: screenHeight), controlPoint: CGPoint(x: screenWidth/2  + diff, y: screenHeight/2))
        bezierPath.addLine(to: CGPoint(x: 0, y: screenHeight))
        bezierPath.close()
        
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(bezierPath.cgPath)
        UIColor.blue.set()
        context?.fillPath()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sideHelperView = UIView(frame: CGRect(origin: CGPoint(x: -helpViewWidth/2, y: helpViewWidth/2), size: CGSize(width: helpViewWidth, height: helpViewWidth)))
        centerHelperView = UIView(frame: CGRect(x: -helpViewWidth/2, y: keyWindow.center.y, width: helpViewWidth, height: helpViewWidth))
        
        self.backgroundColor = UIColor.white
//        sideHelperView.backgroundColor = UIColor.orange
//        centerHelperView.backgroundColor = UIColor.red
//        self.backgroundColor = UIColor.green
        
        keyWindow.addSubview(self)
        keyWindow.addSubview(sideHelperView)
        keyWindow.addSubview(centerHelperView)
        
    }
    
    func triggerAimation(){
        
        if !isTriggered {
            beginAnimation()
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [.beginFromCurrentState], animations: {
                self.sideHelperView.center = CGPoint(x: screenWidth/2, y: self.helpViewWidth/2)
            }) { (finish) in
                self.endAnimation()
            }
            
            UIView.animate(withDuration: 0.3) {
                self.frame = self.bounds
            }
            
            beginAnimation()
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: [.beginFromCurrentState], animations: {
                self.centerHelperView.center = CGPoint(x: self.keyWindow.center.x , y: self.keyWindow.center.y)
            }) { (finish) in
                if finish {
                    self.endAnimation()
                }
            }
            
            isTriggered = true
        }else{
            untriggered()
            isTriggered = false
        }
    }
    
    fileprivate func untriggered(){
        beginAnimation()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [.beginFromCurrentState], animations: {
            self.sideHelperView.center = CGPoint(x: -self.helpViewWidth/2, y: self.helpViewWidth/2)
        }) { (finish) in
            self.endAnimation()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x:-screenWidth/2 - constantMargin, y: 0, width: screenWidth/2 + constantMargin , height: screenHeight)
        }
        
        beginAnimation()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: [.beginFromCurrentState], animations: {
            self.centerHelperView.center = CGPoint(x: -self.helpViewWidth/2, y: self.keyWindow.center.y)
        }) { (finish) in
            if finish {
                self.endAnimation()
            }
        }
    }
    
    fileprivate func beginAnimation(){
        animationCount += 1
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(refreshUI))
            displayLink?.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        }
    }
    
    fileprivate func  endAnimation(){
        animationCount -= 1
        if animationCount == 0 {
            displayLink?.invalidate()
            displayLink = nil
        }
    }
    
    @objc private func refreshUI(){
        let sideHelpViewLayer = sideHelperView.layer.presentation()
        let sideHelpViewFrame = sideHelpViewLayer?.value(forKey: "frame") as! CGRect
        
        let centerHelpViewLayer = centerHelperView.layer.presentation()
        let centerHelpViewFrame = centerHelpViewLayer?.value(forKey: "frame") as! CGRect
        
        diff = sideHelpViewFrame.origin.x - centerHelpViewFrame.origin.x
//        print("diff==\(diff)___centerHelpViewFrame==\(centerHelpViewFrame)____sideHelpViewFrame==\(sideHelpViewFrame)")
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
}
