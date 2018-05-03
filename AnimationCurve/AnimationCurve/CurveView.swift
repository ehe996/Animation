//
//  CurveView.swift
//  AnimationCurve
//
//  Created by fox on 2018/5/3.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class CurveView: UIView {

    var progress: CGFloat = 0.0{
        didSet{
            curveLayer.progress = progress
            curveLayer.setNeedsDisplay()
        }
    }
    fileprivate var curveLayer: CurveLayer!
    
    var layerClass: Swift.AnyClass{
        return CurveLayer.self
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        curveLayer = CurveLayer()
        curveLayer.frame = self.bounds
        curveLayer.contentsScale = UIScreen.main.scale
        curveLayer.progress = 0
        curveLayer.setNeedsDisplay()
        self.layer.addSublayer(curveLayer)
    }

}
