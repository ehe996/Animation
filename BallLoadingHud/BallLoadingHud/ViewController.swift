//
//  ViewController.swift
//  BallLoadingHud
//
//  Created by fox on 2018/4/28.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LoadingHUD.show()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BallLoadingHud.show()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            BallLoadingHud.hide()
        }
    }
    
}

