//
//  ProgressBar.swift
//  ProgressBarAnimation
//
//  Created by fox on 2018/4/27.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class ProgressBar: UIView {

    fileprivate var isAnimaitoning = false
    fileprivate var originFrame = CGRect.zero
    fileprivate let progressBarWidth: CGFloat = 160
    fileprivate let progressBarHeight: CGFloat = 30
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    fileprivate func setupUI(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tapGesture)
        self.layer.cornerRadius = self.frame.width/2
        self.backgroundColor = UIColor.blue
    }
    
    @objc fileprivate func tap(){
        guard isAnimaitoning == false else{return}
        startAnimation()
    }
    
    fileprivate func startAnimation(){
        originFrame = self.frame
        _ = layer.sublayers?.compactMap{$0.removeFromSuperlayer()}
        self.backgroundColor = UIColor.blue
        isAnimaitoning = true
        shapAnimation()
    }
    
    fileprivate func shapAnimation(){
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: self.progressBarWidth, height: self.progressBarHeight))
            self.layer.cornerRadius = self.progressBarHeight/2
        }) { (finish) in
            guard finish == true else{return}
            self.progressAnimaion()
        }
    }
    
    fileprivate func progressAnimaion(){
        let progressLayer = CAShapeLayer()
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.lineJoin = kCALineJoinRound
        self.layer.addSublayer(progressLayer)
        
        let margin: CGFloat = 3
        progressLayer.lineWidth = progressBarHeight - 2*margin
        let progressPath = UIBezierPath()
        progressPath.move(to: CGPoint(x: progressBarHeight/2, y: progressBarHeight/2))
        progressPath.addLine(to: CGPoint(x: progressBarWidth - progressBarHeight/2, y: progressBarHeight/2))
        progressLayer.path = progressPath.cgPath
        
        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressAnimation.fromValue = 0.0
        progressAnimation.toValue = 1.0
        progressAnimation.duration = 1.0
        progressAnimation.delegate = self
        progressAnimation.setValue("progressAnimaion", forKey: "animationKey")
        progressLayer.add(progressAnimation, forKey: nil)
        
    }
    
    fileprivate func progressLayerAlphaAnimation(){

       _ = layer.sublayers?.compactMap{
            let alphaAnimation = CABasicAnimation(keyPath: "opacity")
            alphaAnimation.fromValue = 1.0
            alphaAnimation.toValue = 0.0
            alphaAnimation.duration = 0.3
            alphaAnimation.setValue("alphaAnimation", forKey: "animationKey")
            alphaAnimation.delegate = self
            $0.add(alphaAnimation, forKey: nil)
        }
    }
    
    fileprivate func revertShapAnimation(){
        
        _ = layer.sublayers?.compactMap{$0.removeFromSuperlayer()}
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.bounds = CGRect(origin: CGPoint.zero, size: self.originFrame.size)
            self.layer.cornerRadius = self.originFrame.height/2
            self.backgroundColor = UIColor.green
        }) { (finish) in
            guard finish == true else{return}
            self.checkAnimation()
        }
        
    }
    
    fileprivate func checkAnimation(){
        let checkLayer = CAShapeLayer()
        checkLayer.fillColor = UIColor.clear.cgColor
        checkLayer.strokeColor = UIColor.white.cgColor
        checkLayer.lineJoin = kCALineJoinRound
        checkLayer.lineCap = kCALineCapRound
        checkLayer.lineWidth = 8
        self.layer.addSublayer(checkLayer)
        
        let checkPath = UIBezierPath()
        checkPath.move(to: CGPoint(x: 20, y: 40))
        checkPath.addLine(to: CGPoint(x: 35, y: 60))
        checkPath.addLine(to: CGPoint(x: 65, y: 20))
        checkLayer.path = checkPath.cgPath
        
        let checkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkAnimation.fromValue = 0
        checkAnimation.toValue = 1.0
        checkAnimation.duration = 0.3
        checkAnimation.setValue("checkAnimation", forKey: "animationKey")
        checkAnimation.delegate = self
        checkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        checkLayer.add(checkAnimation, forKey: nil)
    }

}

extension ProgressBar: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let animationKey =  anim.value(forKey: "animationKey") as? String else { return  }
        if animationKey == "progressAnimaion" {
            progressLayerAlphaAnimation()
        } else if animationKey == "alphaAnimation"{
            revertShapAnimation()
        }else if animationKey == "checkAnimation"{
            layer.removeAllAnimations()
            isAnimaitoning = false
        }
    }
}
