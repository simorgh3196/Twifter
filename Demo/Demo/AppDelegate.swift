//
//  AppDelegate.swift
//  Demo
//
//  Created by Tomoya Hayakawa on 2016/10/29.
//  Copyright © 2016年 simorgh. All rights reserved.
//

import UIKit
import Twifter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Set consumerToken and consumerSecret
        Twifter.registerConsumerKey(token: "QDsTjvzbXK290fAqZc1UdmroC",
                                    secret: "IenwSSxo36iqZWW0keqAVMY6twQbpwDthWdbDeYR7NaBsiIwGS")
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print(app, options)

        // Set handler of twitter oauth callback
        Twifter.handleOpenURL(url: url)

        return true
    }


}
