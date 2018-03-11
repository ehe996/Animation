//
//  CircleLayer.swift
//  AimationCircle
//
//  Created by Andy He on 2018/3/10.
//  Copyright © 2018年 FlyingFishHe. All rights reserved.
//

import UIKit

class CircleLayer: CALayer {

    var progress: CGFloat = 0.0{
        didSet{
            initOutsideRect()
//            displayIfNeeded()
            setNeedsDisplay()
        }
    }
    
    fileprivate let outsideRectSize = CGSize(width: 100, height: 100)
//    fileprivate let halfSizeWidthoutsideRectSize.width * 0.5
    fileprivate var outsideRect = CGRect(origin: CGPoint.zero, size:CGSize(width: 100, height: 100) )
//    fileprivate var outsideRectCenter: CGPoint{
//        return CGPoint(x: outsideRect.origin.x + outsideRectSize.width * 0.5, y: outsideRect.origin.y + outsideRectSize.height * 0.5)
//    }
    fileprivate var isMovePointD: Bool{
        return progress > 0.5
    }
    
    override init() {
        super.init()
        initOutsideRect()
    }
    
//    override init(layer: Any) {
//        super.init(layer: layer)
//        initLayer()
//    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        initOutsideRect()
    }
    
    fileprivate func initOutsideRect(){
        let origin_x = position.x - outsideRectSize.width * 0.5 + (progress - 0.5)*(self.frame.size.width - outsideRectSize.width)
        let origin_y = position.y - outsideRectSize.height * 0.5
        outsideRect = CGRect(origin: CGPoint(x: origin_x, y: origin_y), size: outsideRectSize)
    }
    
    override func draw(in ctx: CGContext) {
        let offset = outsideRectSize.width/3.6
        let moveDistance = outsideRectSize.width * CGFloat(1/6.0) * CGFloat(CGFloat(fabs(progress - 0.5)) * CGFloat(2))
//        print("moveDistance___\(moveDistance)")
        let outsideRectCenter = CGPoint(x: outsideRect.origin.x + outsideRectSize.width * 0.5, y: outsideRect.origin.y + outsideRectSize.height * 0.5)
        
        let pointA = CGPoint(x: outsideRectCenter.x, y: outsideRect.origin.y + moveDistance)
        let pointB = CGPoint(x: isMovePointD ? outsideRect.maxX : outsideRect.maxX + moveDistance * 2   , y: outsideRectCenter.y)
        let pointC = CGPoint(x: outsideRectCenter.x, y: outsideRect.maxY - moveDistance)
        let pointD = CGPoint(x: isMovePointD ? outsideRect.origin.x - 2 * moveDistance : outsideRect.origin.x , y: outsideRectCenter.y)
        
//        let pointC1 = CGPoint(x: isMovePointD ? outsideRectCenter.x + offset : outsideRectCenter.x + offset - moveDistance, y: pointA.y)
        let pointC1 = CGPoint(x:outsideRectCenter.x + offset , y: pointA.y)
        let pointC2 = CGPoint(x: pointB.x, y: isMovePointD ? outsideRectCenter.y - offset : outsideRectCenter.y - offset + moveDistance )
        let pointC3 = CGPoint(x: pointB.x, y: isMovePointD ? outsideRectCenter.y + offset : outsideRectCenter.y + offset - moveDistance)
        let pointC4 = CGPoint(x: pointC1.x, y: pointC.y)
//        let pointC5 = CGPoint(x: isMovePointD ? outsideRectCenter.x - offset + moveDistance : outsideRectCenter.x - offset , y: pointC.y)
        let pointC5 = CGPoint(x: outsideRectCenter.x - offset  , y: pointC.y)
        let pointC6 = CGPoint(x: pointD.x, y: isMovePointD ? outsideRectCenter.y + offset - moveDistance : outsideRectCenter.y + offset)
        let pointC7 = CGPoint(x: pointD.x, y: isMovePointD ? outsideRectCenter.y - offset + moveDistance : outsideRectCenter.y - offset)
//        let pointC8 = CGPoint(x: isMovePointD ? outsideRectCenter.x - offset + moveDistance  : outsideRectCenter.x - offset , y: pointA.y)
        let pointC8 = CGPoint(x: outsideRectCenter.x - offset, y: pointA.y)
        
        
        let ovalPath = UIBezierPath()
        ovalPath.move(to: pointA)
        ovalPath.addCurve(to: pointB, controlPoint1: pointC1, controlPoint2: pointC2)
        ovalPath.addCurve(to: pointC, controlPoint1: pointC3, controlPoint2: pointC4)
        ovalPath.addCurve(to: pointD, controlPoint1: pointC5, controlPoint2: pointC6)
        ovalPath.addCurve(to: pointA, controlPoint1: pointC7, controlPoint2: pointC8)
        ovalPath.close()
        
        ctx.addPath(ovalPath.cgPath)
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fillPath()
        
        ctx.addPath(ovalPath.cgPath)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.setLineWidth(2)
        ctx.strokePath()
        
        let pointArray: [CGPoint] = [
            pointA, pointC1,pointC2,
            pointB, pointC3,pointC4,
            pointC ,pointC5,pointC6,
            pointD,pointC7,pointC8
        ]
        
//        ctx.move(to: pointA)
        let path = UIBezierPath()
        path.move(to: pointA)
        drawPoint(pointArray: pointArray, ctx: ctx, helpLinePath: path)
        path.close()
        
        ctx.addPath(path.cgPath)
        ctx.setLineDash(phase: 0.5, lengths: [2.0,2.0])
        ctx.setStrokeColor(UIColor.blue.cgColor)
        ctx.strokePath()
    }
    
    fileprivate func drawPoint(pointArray: [CGPoint], ctx: CGContext, helpLinePath: UIBezierPath) {
        for point in pointArray {
            let width: CGFloat = 4
            let frame = CGRect(x: point.x - width * 0.5, y: point.y - width * 0.5, width: width, height: width)
            ctx.setFillColor(UIColor.yellow.cgColor)
            ctx.fill(frame)
            
//            ctx.setLineDash(phase: 0.5, lengths: [2.0,2.0])
//            ctx.addLine(to: point)
//            ctx.setLineWidth(2)
//            ctx.setFillColor(UIColor.blue.cgColor)
//            ctx.closePath()
            helpLinePath.addLine(to: point)
            
        }
    }
    
    
    
    
    
}
