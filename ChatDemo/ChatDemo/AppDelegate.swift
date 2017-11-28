//
//  AppDelegate.swift
//  ChatDemo
//
//  Created by zyc on 2017/11/24.
//  Copyright © 2017年 zyc. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        let c = ViewController()
        let navi = UINavigationController(rootViewController: c)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        
        initRYIM()
        
        return true
    }

    func initRYIM() {
        RCIMClient.shared().initWithAppKey(Const.RY_APPKEY)
        
        let parms = ["userId": "812002505",
                     "name": "812002505",
                     "portraitUrl": "http://upload.jianshu.io/users/upload_avatars/1164718/0529df063769?imageMogr2/auto-orient/strip|imageView2/1/w/120/h/120"]
        var paramStr = ""
        var i = 0
        for (key, values) in parms {
            if i == 0 {
                paramStr += "\(key)=\(values)"
            } else {
                paramStr += "&\(key)=\(values)"
            }
            i += 1
        }
        let appkey = Const.RY_APPKEY
        let appSecret = Const.RY_APPSEC
        let nonce = "\(arc4random())"
        let timestamp = "\(Int(Date().timeIntervalSince1970))"
        let sigValue = appSecret + nonce + timestamp;
        let sigV = sigValue.sha1()
        
        let url = URL(string: Const.RY_TOKEN_URL)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramStr.data(using: .utf8)
        request.setValue(appkey, forHTTPHeaderField: "App-key")
        request.setValue(nonce, forHTTPHeaderField: "Nonce")
        request.setValue(timestamp, forHTTPHeaderField: "Timestamp")
        request.setValue(sigV, forHTTPHeaderField: "Signature")
        let task = URLSession.shared.dataTask(with: request) { [weak self]  (data, responce, error) in
            if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    guard let d = dic as? NSDictionary else {
                        return
                    }
                    let token = d.object(forKey: "token")
                    print("token: ", token!)
                    self?.login(token: token as! String)
                } catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    func login(token: String) {
        RCIMClient.shared().connect(withToken: token, success: { (userId) in
            print("用户\(String(describing: userId))登录成功")
        }, error: { (error) in
            print(error)
        }) {
            print("mistake token")
        }
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

