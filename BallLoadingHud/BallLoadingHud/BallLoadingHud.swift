//
//  BallLoadingHud.swift
//  BallLoadingHud
//
//  Created by fox on 2018/4/28.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

fileprivate let ballDiameter: CGFloat = 20

class BallLoadingHud: UIView {
    
    static var hud: BallLoadingHud?
    fileprivate var balls: [UIView] = []
    fileprivate let animationDuration: CFTimeInterval = 2
    fileprivate var timer: Timer?
    
    static func show(){
        if hud == nil {
            
            hud = BallLoadingHud(frame: UIScreen.main.bounds)
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window
            window?.addSubview(hud!)
            hud?.center = (window?.center)!
            hud?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let ballW: CGFloat = ballDiameter
            for i in 0..<3{
                let xP = CGFloat(i - 1)*(ballDiameter) + (hud?.frame.width)!/2
                let yP = (hud?.frame.height)!/2
                let ball = UIView()
                ball.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: ballW, height: ballW))
                ball.center = CGPoint(x: xP, y: yP)
                ball.backgroundColor = UIColor.white
                ball.layer.cornerRadius = ballW/2
                hud?.addSubview(ball)
                hud?.balls.append(ball)
            }
            
            hud?.startAnimation()
        }
    }
    
    static func hide(){
        hud?.timer?.invalidate()
        let _ = hud?.balls.compactMap{$0.layer.removeAllAnimations()}
        UIView.animate(withDuration: 0.3, animations: {
            hud?.alpha = 0
        }) { (_) in
            hud?.removeFromSuperview()
        }
    }
    
    fileprivate func startAnimation(){
        self.rotationFoldAnimation()
        timer = Timer(timeInterval: TimeInterval(animationDuration/2), repeats: true) { (_) in
            self.scaleAnimation()
        }
        RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
    }

    
    fileprivate func rotationFoldAnimation(){
        
        let hudViewCenter = CGPoint(x: bounds.width/2, y: bounds.height/2)
        
        let ball1Path1 = UIBezierPath()
        ball1Path1.move(to: CGPoint(x: bounds.width/2 - ballDiameter , y: bounds.height/2))
        ball1Path1.addArc(withCenter: hudViewCenter, radius: ballDiameter, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi * 2), clockwise: false)
        let ball1Path2 = UIBezierPath()
        ball1Path2.addArc(withCenter: hudViewCenter, radius: ballDiameter, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
        ball1Path1.append(ball1Path2)
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        keyframeAnimation.path = ball1Path1.cgPath
        keyframeAnimation.duration = animationDuration
        keyframeAnimation.repeatCount = MAXFLOAT
        keyframeAnimation.isRemovedOnCompletion = true
        balls.first?.layer.add(keyframeAnimation, forKey: "animation")
        
        let ball2Path1 = UIBezierPath()
        ball2Path1.move(to: CGPoint(x: bounds.width/2 + ballDiameter, y: bounds.height/2))
        ball2Path1.addArc(withCenter: hudViewCenter, radius: ballDiameter, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
        let ball2Path2 = UIBezierPath()
        ball2Path2.addArc(withCenter: hudViewCenter, radius: ballDiameter, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi * 2), clockwise: false)
        ball2Path1.append(ball2Path2)
        
        let keyframeAnimation2 = CAKeyframeAnimation(keyPath: "position")
        keyframeAnimation2.path = ball2Path1.cgPath
        keyframeAnimation2.duration = animationDuration
         keyframeAnimation2.repeatCount = MAXFLOAT
        keyframeAnimation2.isRemovedOnCompletion = true
        balls.last?.layer.add(keyframeAnimation2, forKey: "animation")
    }
    
    fileprivate func scaleAnimation(){
        UIView.animate(withDuration: (animationDuration/2 - 0.1)/2, delay: 0.1, options: [.curveEaseInOut], animations: {
            
            var transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            transform = transform.translatedBy(x: -ballDiameter, y: 0)
            self.balls[0].transform = transform
            
            var transform2 = CGAffineTransform(scaleX: 0.7, y: 0.7)
            transform2 = transform2.translatedBy(x: ballDiameter, y: 0)
            self.balls[2].transform = transform2
            
            self.balls[1].transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            
        }) { (_) in
            UIView.animate(withDuration: (self.animationDuration/2 - 0.1)/2, delay: 0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                let _ = self.balls.compactMap{$0.transform = .identity}
            }, completion: nil)
        }
    }
}

