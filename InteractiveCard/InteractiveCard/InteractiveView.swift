//
//  InteractiveView.swift
//  InteractiveCard
//
//  Created by fox on 2018/5/2.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class InteractiveView: UIImageView {
    
    var gestureView: UIView!{
        didSet{
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pangestureAction(gesture:)))
            gestureView.addGestureRecognizer(panGesture)
        }
    }
    
    var dimmingView: UIView?
    
    
    private var initialPoint: CGPoint = CGPoint.zero
    private var scrollDistanceMax: CGFloat = 200

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI(){
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    @objc private func pangestureAction(gesture: UIPanGestureRecognizer){
        
        let translationP = gesture.translation(in: self.gestureView)
        
        switch gesture.state {
        case .began:
             initialPoint = self.center
        case .changed:
            self.center = CGPoint(x: self.center.x, y: initialPoint.y + translationP.y)
            let yP = min(scrollDistanceMax, CGFloat(max(0, fabsf(Float(translationP.y)))))
            //            缩放二次函数
            let factorOfScale = max(0, -1/(scrollDistanceMax*scrollDistanceMax)*yP*(yP - 2*scrollDistanceMax))
            //            翻转角度二次函数
            let factorOfAngle = max(0, -4/(scrollDistanceMax*scrollDistanceMax)*yP*(yP-scrollDistanceMax))
            
            var transform3D = CATransform3DIdentity
            transform3D.m34 = 1.0 / -1000
            transform3D = CATransform3DScale(transform3D, 1-factorOfScale*0.2, 1 - factorOfScale*0.2, 0)
            transform3D = CATransform3DRotate(transform3D, factorOfAngle*CGFloat(Double.pi/5), translationP.y>0 ? -1 : 1, 0, 0)
            self.layer.transform = transform3D
            self.dimmingView?.alpha = 1.0 - yP/scrollDistanceMax
         case .cancelled, .ended:
            UIView.animate(withDuration: 0.3) {
                self.layer.transform = CATransform3DIdentity
                self.center = self.initialPoint
                self.dimmingView?.alpha = 1.0
            }
          default: break
        }
    }
    
}
