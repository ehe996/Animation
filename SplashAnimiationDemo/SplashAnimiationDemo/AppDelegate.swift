//
//  AppDelegate.swift
//  SplashAnimiationDemo
//
//  Created by Andy He on 2018/4/6.
//  Copyright © 2018年 FlyingFishHe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window?.backgroundColor = UIColor.orange
        
        let nav = window?.rootViewController as! UINavigationController
        
        let maskBgView = UIView()
        maskBgView.frame = nav.view.frame
        maskBgView.backgroundColor = UIColor.white
        nav.view.addSubview(maskBgView)
        
        let shapLayer = CAShapeLayer()
        shapLayer.contents = UIImage(named: "logo")?.cgImage
        shapLayer.position = nav.view.center
        shapLayer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 60, height: 60))
        nav.view.layer.mask = shapLayer
        
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 1
        let initialBounds = shapLayer.bounds
        let secondBounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 40))
        let finalBounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 2000, height: 2000))
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        animation.values = [initialBounds, secondBounds, finalBounds]
        nav.view.layer.mask?.add(animation, forKey: "keyFrameAnimation")
        
        UIView.animate(withDuration: 0.2, delay: 1.5, options: [], animations: {
            maskBgView.alpha = 0
        }) { (finish) in
            maskBgView.removeFromSuperview()
        }
        
       DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3) {
        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
            nav.view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (_) in
                UIView.animate(withDuration: 0.25, animations: { 
                    nav.view.transform = CGAffineTransform.identity
                }, completion: { (_) in
                    nav.view.layer.mask = nil
                })
            }
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

