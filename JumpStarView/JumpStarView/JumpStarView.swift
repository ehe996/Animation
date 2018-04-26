//
//  JumpStarView.swift
//  JumpStarView
//
//  Created by fox on 2018/4/25.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

enum AnimationImageState {
    case star
    case noStar
}

class JumpStarView: UIView {
    
    fileprivate var imageView = UIImageView()
    fileprivate let jumpUpAnimationDuration: CFTimeInterval = 0.5
    fileprivate let jumpDownAnimationDuration: CFTimeInterval = 0.4
    fileprivate let distance: CGFloat = 30
    fileprivate var animating = false
    fileprivate var state: AnimationImageState = .noStar{
        didSet{
            let imageName =  state == .star ? "icon_star_incell" : "blue_dot"
            imageView.image = UIImage(named: imageName)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    fileprivate func setupUI(){
        let imageViewW: CGFloat = 13
        state = .noStar
        imageView.frame = CGRect(x:0, y: self.frame.height - imageViewW, width: imageViewW, height: imageViewW)
        imageView.center.x = self.frame.width/2
        addSubview(imageView)
    }
    
    func startAnimation()  {
        
        if animating == true {return}
        animating = true
        
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = imageView.center.y
        positionAnimation.toValue = imageView.center.y - distance
        
        let rotaionAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotaionAnimation.fromValue = 0
        rotaionAnimation.toValue = Double.pi/2
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, rotaionAnimation]
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.delegate = self
        groupAnimation.duration = jumpUpAnimationDuration
        groupAnimation.setValue("jumpUp", forKey: "animationKey")
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        imageView.layer.add(groupAnimation, forKey: nil)
        
    }
    
    private func downAnimation(){
        
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = imageView.layer.presentation()?.position.y
        positionAnimation.toValue = imageView.center.y
        positionAnimation.duration = jumpDownAnimationDuration
        
        let rotaionAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotaionAnimation.fromValue = Double.pi/2
        rotaionAnimation.toValue = Double.pi
        rotaionAnimation.duration = jumpDownAnimationDuration
        rotaionAnimation.isRemovedOnCompletion = false

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, rotaionAnimation]
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.delegate = self
        groupAnimation.setValue("jumpDown", forKey: "animationKey")
        groupAnimation.duration = jumpDownAnimationDuration
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        imageView.layer.add(groupAnimation, forKey: nil)
    }

}

extension JumpStarView: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag  {
            
            if anim.value(forKey: "animationKey") as? String == "jumpUp"{
                state = (state == .star) ? .noStar : .star
                downAnimation()
            }else if anim.value(forKey: "animationKey") as? String == "jumpDown"{
                imageView.layer.removeAllAnimations()
                animating = false
            }
            
        }
    }
}
