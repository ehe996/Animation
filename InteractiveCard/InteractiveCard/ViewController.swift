//
//  ViewController.swift
//  InteractiveCard
//
//  Created by fox on 2018/5/2.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let interactiveView = InteractiveView(image: UIImage(named: "pic01"))
        interactiveView.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 200))
        interactiveView.center = self.view.center
        interactiveView.gestureView = self.view
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.frame = view.bounds
        view.addSubview(blurView)
        
        interactiveView.dimmingView = blurView
        
        let backView = UIView(frame: view.bounds)
        view.addSubview(backView)
        backView.addSubview(interactiveView)
        
    }
    
    
    

}

