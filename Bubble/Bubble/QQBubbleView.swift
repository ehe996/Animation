//
//  QQBubbleView.swift
//  Bubble
//
//  Created by fox on 2018/3/16.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class QQBubbleView: UIButton {
    
    fileprivate var oldCenterP: CGPoint = CGPoint.zero
    fileprivate var oldW: CGFloat = 0
    fileprivate let maxDistance: CGFloat = 100
    fileprivate var distance: CGFloat{
        return getDistance(centerP1: self.fixedSmallCirleView.center, ceterP2: self.center)
    }
    
    
    /// 固定的小圆view
    lazy var fixedSmallCirleView: UIView = {
        let view = UIView()
        view.backgroundColor = self.backgroundColor
        self.superview?.insertSubview(view, belowSubview: self)
        return view
    }()
    
    fileprivate var _shapLayer: CAShapeLayer?
    fileprivate var shapLayer: CAShapeLayer{
        if _shapLayer == nil {
            _shapLayer = CAShapeLayer()
            _shapLayer?.fillColor = self.backgroundColor?.cgColor
            self.superview?.layer.insertSublayer(_shapLayer!, below: fixedSmallCirleView.layer)
            return _shapLayer!
        }
        return _shapLayer!
    }
    
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        DispatchQueue.main.async {
            self.setupUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    fileprivate func setupUI(){
        let w = self.bounds.width
        oldW = w
        oldCenterP = self.center
        fixedSmallCirleView.frame = self.frame
        self.layer.cornerRadius = w/2
        fixedSmallCirleView.layer.cornerRadius = w/2
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pangestureAction(gesture:)))
        addGestureRecognizer(pan)
        
    }
    
    @objc private func pangestureAction(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .began:
            print("begin----")
        case .changed:
            pangestureChange(gesture)
        case .ended, .cancelled,  .failed:
            pangestureEndAnimation()
        default:
            break
        }
    }
    
    fileprivate func pangestureChange(_ gesture: UIPanGestureRecognizer){
        let transitonP = gesture.translation(in: self)
        self.center.x += transitonP.x
        self.center.y += transitonP.y
        if distance > maxDistance && fixedSmallCirleView.isHidden == false{
            fixedSmallCirleView.isHidden = true
            _shapLayer?.removeFromSuperlayer()
            _shapLayer = nil
        }else if fixedSmallCirleView.isHidden == false{
            let newWidth = oldW - distance/10
            fixedSmallCirleView.bounds = CGRect(x: 0, y: 0, width: newWidth, height: newWidth)
            fixedSmallCirleView.layer.cornerRadius = newWidth/2
            let bezierPath = getBezierPath()
            shapLayer.path = bezierPath.cgPath
        }
        gesture.setTranslation(CGPoint.zero, in: self)
    }
    
    fileprivate func pangestureEndAnimation(){
        if distance > maxDistance{
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
                self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.15, animations: {
                    self.transform = CGAffineTransform(scaleX:0.1, y: 0.1)
                    self.alpha = 0.0
                }, completion: { (_) in
                    self.removeFromSuperview()
                })
            })
        }else{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [.beginFromCurrentState], animations: {
                self.center = self.fixedSmallCirleView.center
                self._shapLayer?.removeFromSuperlayer()
                self._shapLayer = nil
            }, completion: { (_) in
                self.fixedSmallCirleView.isHidden = false
            })
        }
    }
    
    fileprivate func getBezierPath() -> UIBezierPath{
        
        let r1 = fixedSmallCirleView.bounds.width/2
        let r2 = self.bounds.width/2
        let distance = getDistance(centerP1: self.fixedSmallCirleView.center, ceterP2: self.center)
        let x1 = self.fixedSmallCirleView.center.x
        let y1 = self.fixedSmallCirleView.center.y
        let x2 = self.center.x
        let y2 = self.center.y
        
        let sinø = (x2 - x1)/distance
        let cosø = (y2 - y1)/distance
        
        let pointA = CGPoint(x: x1 - r1 * cosø, y: y1 + r1 * sinø)
        let pointB = CGPoint(x: x1 + r1 * cosø, y: y1 - r1 * sinø)
        let pointC = CGPoint(x: x2 + r2 * cosø, y: y2 - r2 * sinø)
        let pointD = CGPoint(x: x2 - r2 * cosø, y: y2 + r2 * sinø)
        let pointO = CGPoint(x: pointA.x + distance/2 * sinø, y: pointA.y + distance/2 * cosø)
        let pointP = CGPoint(x: pointB.x + distance/2 * sinø, y: pointB.y + distance/2 * cosø)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: pointA)
        bezierPath.addLine(to: pointB)
        bezierPath.addQuadCurve(to: pointC, controlPoint: pointP)
        bezierPath.addLine(to: pointD)
        bezierPath.addQuadCurve(to: pointA, controlPoint: pointO)
        return bezierPath
    }
    
    fileprivate func getDistance(centerP1: CGPoint, ceterP2: CGPoint) -> CGFloat{
        let distance = hypotf(Float(ceterP2.x - centerP1.x), Float(ceterP2.y - centerP1.y))
        return CGFloat(distance)
    }

}
