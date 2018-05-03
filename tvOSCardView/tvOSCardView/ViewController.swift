//
//  ViewController.swift
//  tvOSCardView
//
//  Created by fox on 2018/5/3.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tvOSCardV = tvOSCardView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        tvOSCardV.center = self.view.center
        view.addSubview(tvOSCardV)
        
    }

   

}

