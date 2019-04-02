//
//  AppDelegate.swift
//  Launch1
//
//  Created by jake on 2019/3/22.
//  Copyright © 2019 Jake. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        window?.rootViewController = controller
        
        //
        let maskBgView = UIView(frame: controller.view.frame)
        maskBgView.backgroundColor = UIColor.yellow
        controller.view.addSubview(maskBgView)
        controller.view.bringSubviewToFront(maskBgView)
        
        //
        UIView.animate(withDuration: 3.0, animations: {
            maskBgView.alpha = 0.0
        })
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
