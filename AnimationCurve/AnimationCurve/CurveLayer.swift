//
//  CurveLayer.swift
//  AnimationCurve
//
//  Created by fox on 2018/5/3.
//  Copyright © 2018年 fox. All rights reserved.
//

import UIKit

class CurveLayer: CALayer {

    var progress: CGFloat = 0.0
    private var lineHeight: CGFloat = 30
    lazy var H: CGFloat = {
        return self.bounds.height
    }()
    private let xOffset: CGFloat = 15
    private let angleLine: CGFloat  = 10
    fileprivate let arrowAngle = CGFloat(Double.pi)*(60.0/180.0)
    
    override func draw(in ctx: CGContext) {
        let path1 = UIBezierPath()
        let path2 = UIBezierPath()
        
        let centerX = self.bounds.width/2
        let centerY = self.bounds.height/2
        
        if progress < 0.5 {
            
            let pointAY = H - 2*progress*(H/2 - lineHeight)
            let pointBY = H/2 + (1-2*progress)*(H/2-lineHeight)
            let pointA_1Y = pointBY + angleLine*sin(arrowAngle)
            
            let pointA = CGPoint(x: centerX - xOffset, y: pointAY)
            let pointB = CGPoint(x: centerX - xOffset, y: pointBY)
            
            path1.move(to: pointA)
            path1.addLine(to: pointB)
            
            
            let anglePath = UIBezierPath()
            anglePath.move(to: pointB)
            anglePath.addLine(to: CGPoint(x: pointB.x - angleLine*cos(arrowAngle), y: pointA_1Y))
            
            
            let pointCY = (H/2-lineHeight)*2*progress
            let pointDY = lineHeight + (H/2-lineHeight)*2*progress
            let pointC = CGPoint(x: centerX + xOffset, y: pointCY)
            let pointD = CGPoint(x: centerX + xOffset, y: pointDY)
            let pointA_2Y = pointDY - angleLine*sin(arrowAngle)
            
            anglePath.move(to: pointD)
            anglePath.addLine(to: CGPoint(x: pointD.x + angleLine*cos(arrowAngle), y: pointA_2Y))
            
            path2.move(to: pointC)
            path2.addLine(to: pointD)
            
            path1.append(anglePath)
            path1.append(path2)
            
        }else{
            
            let curvePath1 = UIBezierPath()
            let curvePath2 = UIBezierPath()
            
            let pointAY = max(H/2, H - 2*progress*(H/2 - lineHeight))
            let pointA = CGPoint(x: centerX - xOffset, y: pointAY)
            path1.move(to: pointA)
            path1.addLine(to: CGPoint(x: centerX - xOffset, y: H/2))
            
            let endAngle1 = Double.pi + Double((progress - 0.5)*2)*(Double.pi)*9.0/10.0
            curvePath1.addArc(withCenter: CGPoint(x: centerX, y: centerY), radius: xOffset, startAngle: CGFloat(Double.pi), endAngle: CGFloat(endAngle1), clockwise: true)
            let pointA_1Y = curvePath1.currentPoint.y + angleLine*sin(arrowAngle - ((progress - 0.5)*2)*CGFloat(Double.pi)*9.0/10.0)
            
            let anglePath = UIBezierPath()
            anglePath.move(to: curvePath1.currentPoint)
            anglePath.addLine(to: CGPoint(x: curvePath1.currentPoint.x - angleLine*cos(arrowAngle - ((progress - 0.5)*2)*CGFloat(Double.pi)*9.0/10.0), y: pointA_1Y))
            path1.append(anglePath)
            path1.append(curvePath1)
            
            
            let pointCY = min(H/2, (H/2-lineHeight)*2*progress)
            let pointC = CGPoint(x: centerX + xOffset, y: pointCY)
            path2.move(to: pointC)
            path2.addLine(to: CGPoint(x: centerX + xOffset, y: H/2))
            
            let endAngle2 = Double((progress - 0.5)*2)*(Double.pi)*9.0/10.0
            curvePath2.addArc(withCenter: CGPoint(x: centerX, y: centerY), radius: xOffset, startAngle: CGFloat(0), endAngle: CGFloat(endAngle2), clockwise: true)
            let pointA_2Y = curvePath2.currentPoint.y - angleLine * sin(arrowAngle - ((progress - 0.5)*2)*CGFloat(Double.pi)*9.0/10.0)
            
            anglePath.move(to: curvePath2.currentPoint)
            anglePath.addLine(to: CGPoint(x: curvePath2.currentPoint.x + angleLine*cos(arrowAngle - ((progress - 0.5)*2)*CGFloat(Double.pi)*9.0/10.0), y: pointA_2Y))
            
            path2.append(anglePath)
            path2.append(curvePath2)
            
            path1.append(path2)
            
        }
        
        ctx.addPath(path1.cgPath)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.setLineWidth(1)
        ctx.strokePath()
        
    }
}
