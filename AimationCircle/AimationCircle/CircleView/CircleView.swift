//
//  CircleView.swift
//  AimationCircle
//
//  Created by Andy He on 2018/3/10.
//  Copyright © 2018年 FlyingFishHe. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    override class var layerClass: Swift.AnyClass {
        return CircleLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    var progress: CGFloat = 0.0{
        didSet{
            if let circleLayer = layer as? CircleLayer{
                circleLayer.progress = progress
            }
//            layer.displayIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
//    func drawCirle(){
//        
//    }

}
