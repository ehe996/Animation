//
//  ViewController.swift
//  JumpStarView
//
//  Created by fox on 2018/4/25.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jumpStarView: JumpStarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func buttonClick(_ sender: Any) {
        jumpStarView.startAnimation()
    }
    

}

