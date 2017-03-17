//
//  AppDelegate.swift
//  hemudu
//
//  Created by Ran Cao on 2017/2/26.
//  Copyright © 2017年 Ran Cao. All rights reserved.
//

import UIKit

let AliPush_key = "23692862"
let AliPush_Secret = "55b833459307b138bedc55de0ec99286"
let AliPush_MessageNoti = "CCPDidReceiveMessageNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //registerAppNotificationSettings(launchOptions: launchOptions as [NSObject : AnyObject]?)
        
        initCloudPush(application: application)
        CloudPushSDK.handleLaunching(launchOptions)
        
        return true
    }
    
    func initCloudPush(application:UIApplication) {
        CloudPushSDK.asyncInit(AliPush_key, appSecret: AliPush_Secret, callback: nil)
        let settings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
        if #available(iOS 8.0, *){
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        registerMessageReceive()
    }
    
    func application(application:UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken:NSData) {
        CloudPushSDK.registerDevice(deviceToken as Data!, withCallback: nil)
        print(deviceToken)
    }
    
    func application(application:UIApplication, didFailToRegisterForRemoteNotificationsWithError error:NSError) {
        print("did fail to reg fo remote notif with error:\(error.localizedDescription)")
    }
    
    func registerMessageReceive() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.onMessageReceived(notification:)),name:NSNotification.Name(rawValue: AliPush_MessageNoti), object: nil)
    }
    
    func onMessageReceived(notification: NSNotification) {
        let message:CCPSysMessage = notification.object as! CCPSysMessage
        let title:NSString = NSString(data: message.title, encoding: String.Encoding.utf8.rawValue)!
        let body:NSString = NSString(data: message.body, encoding: String.Encoding.utf8.rawValue)!
        print("Received Mes title:\(title), centent:\(body)")
    }
    
    func application(application:UIApplication, didReceiveRemoteNotification userInfo:[NSObject:AnyObject]) {
        print("Receive one notif")
        /*
        let aps_dic:NSDictionary = userInfo["aps"] as! NSDictionary
        let content = aps_dic.value(forKey:"alert")
        let badge = aps_dic.value(forKey: "badge")?.integervalue
        let sound = aps_dic.value(forKey: "sounde")
        let extras = aps_dic.value(forKey: "Extras")
 */
        application.applicationIconBadgeNumber = 0
        CloudPushSDK.handleReceiveRemoteNotification(userInfo)
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
