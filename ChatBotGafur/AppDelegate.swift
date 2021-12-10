//
//  AppDelegate.swift
//  ChatBotGafur
//
//  Created by Prateek Chaubey on 7/21/18.
//  Copyright © 2018 Prateek Chaubey. All rights reserved.
//

import UIKit
import ApiAI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "256c772776d844cabfa2f85721f3816e"
        
        let apiai = ApiAI.shared()
        apiai?.configuration = configuration
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

