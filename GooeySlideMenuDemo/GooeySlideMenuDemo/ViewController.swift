//
//  ViewController.swift
//  GooeySlideMenuDemo
//
//  Created by fox on 2018/3/13.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sideMenu: GooeySlideMenu?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            self.sideMenu = GooeySlideMenu(frame: CGRect(x:-screenWidth/2 - constantMargin, y: 0, width: screenWidth/2 + constantMargin , height: screenHeight))
        }
        
        
    }

    @IBAction func buttonclick(_ sender: UIButton) {
        sideMenu?.triggerAimation()
    }

}

