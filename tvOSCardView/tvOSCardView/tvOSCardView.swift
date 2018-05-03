//
//  tvOSCardView.swift
//  tvOSCardView
//
//  Created by fox on 2018/5/3.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class tvOSCardView: UIView {
    
    fileprivate var cardImageView: UIImageView?
    fileprivate var cardParallaxImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 10, height: 0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        
        cardImageView = UIImageView(frame: self.bounds)
        cardImageView?.image = UIImage(named: "poster")
        cardImageView?.layer.cornerRadius = 5
        cardImageView?.layer.masksToBounds = true
        
        cardParallaxImageView = UIImageView(frame: self.bounds)
        cardParallaxImageView?.image = UIImage(named: "5")
        
        addSubview(cardImageView!)
        addSubview(cardParallaxImageView!)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(gesture:)))
        addGestureRecognizer(panGesture)
        
    }
    
    @objc fileprivate func panGestureAction(gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            
        }else if gesture.state == .changed{
            let centerX = self.bounds.width/2
            let centerY = self.bounds.height/2
            let gestureP = gesture.location(in: self)
            let xFactor = min(1, max(-1, (gestureP.x - centerX)/centerX))
            let yFactor = min(1, max(-1, (gestureP.y - centerY)/centerY))
            
          cardImageView?.layer.transform = transformWithM34(m34: -1.0/500.0, xFactor: xFactor, yFactor: yFactor)
            cardParallaxImageView?.layer.transform = transformWithM34(m34: -1.0/150.0, xFactor: xFactor, yFactor: yFactor)
            
        }else if gesture.state == .ended{
            UIView.animate(withDuration: 0.3) {
                self.cardImageView?.layer.transform = CATransform3DIdentity
                self.cardParallaxImageView?.layer.transform = CATransform3DIdentity
            }
        }
    }
    
    private func transformWithM34(m34: CGFloat, xFactor: CGFloat, yFactor: CGFloat) -> CATransform3D{
        var transform3D = CATransform3DIdentity
        transform3D.m34 = m34
        transform3D = CATransform3DRotate(transform3D, CGFloat(Double.pi/9) * yFactor, -1, 0, 0)
        transform3D = CATransform3DRotate(transform3D, CGFloat(Double.pi/9) * xFactor, 0, 1, 0)
        return transform3D
        
    }
    
}
