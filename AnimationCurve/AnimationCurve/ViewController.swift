//
//  ViewController.swift
//  AnimationCurve
//
//  Created by fox on 2018/5/3.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var curveView: CurveView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        curveView.progress = CGFloat(sender.value)
        if sender.value == 1.0 && curveView.layer.animation(forKey: "animation") == nil{
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.duration = 1.0
            rotationAnimation.toValue = Double.pi * 2
            rotationAnimation.repeatCount = Float.infinity
            rotationAnimation.isRemovedOnCompletion = false
            rotationAnimation.fillMode = kCAFillModeForwards
            curveView.layer.add(rotationAnimation, forKey: "animation")
            
        }
    }
    
}

