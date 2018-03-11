//
//  ViewController.swift
//  AimationCircle
//
//  Created by Andy He on 2018/3/10.
//  Copyright © 2018年 FlyingFishHe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   
    @IBAction func sliderAction(_ sender: UISlider) {
        circleView.progress = CGFloat(sender.value)
    }
    

}

