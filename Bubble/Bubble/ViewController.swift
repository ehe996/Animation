//
//  ViewController.swift
//  Bubble
//
//  Created by fox on 2018/3/14.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qqBubleView = QQBubbleView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        qqBubleView.setTitle("5", for: .normal)
        qqBubleView.backgroundColor = UIColor.red
        view.addSubview(qqBubleView)
        
        
    }
}

