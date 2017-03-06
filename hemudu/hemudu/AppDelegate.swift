//
//  AppDelegate.swift
//  hemudu
//
//  Created by Ran Cao on 2017/2/26.
//  Copyright © 2017年 Ran Cao. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) -> Bool {
        // Override point for customization after application launch.
        //registerAppNotificationSettings(launchOptions: launchOptions as [NSObject : AnyObject]?)
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
        // 触发3D Touch的type
        var activeFrom3Dtouch:ShortcutIdentifier?
        // 3Dtouch的type
        enum ShortcutIdentifier:String {
            // 当面收款
            case Reg = "Reg"
        }
        //
        @available(iOS 9.0, *)
        func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
            activeFrom3Dtouch = ShortcutIdentifier(rawValue: shortcutItem.type)
        }
        
        func applicationDidBecomeActive(application: UIApplication) {
            // 判断入口
            guard let touchType = activeFrom3Dtouch else {
                return
            }
            
            // 分类处理
            if touchType == .Reg {
                // 延时0.5就足够了
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    // 获取活动的Controller
                    guard let currentViewController = self.window?.visibleViewController else {
                        return
                    }
     
                    let viewController = RegView()
                    
                    // 判断是否模态
                    if(currentViewController.navigationController == nil) {
                        currentViewController.present(viewController, animated: true, completion: nil)
                    } else {
                        currentViewController.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
            
            // TODO: 判断跳转操作
            
            // 清除，防止再次激活应用重复触发
            activeFrom3Dtouch = nil
        }
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
/*
    private func registerAppNotificationSettings(launchOptions: [NSObject: AnyObject]?) {
        if #available(iOS 10.0, *) {
            let notifiCenter = UNUserNotificationCenter.current()
            notifiCenter.delegate = self
            let types = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
            notifiCenter.requestAuthorization(options: types) { (flag, error) in
                if flag {
                    MPrintLog("iOS request notification success")
                }else{
                    MPrintLog(" iOS 10 request notification fail")
                }
            }
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    @available(iOS 10.0, *)
    
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void){
        let userInfo = notification.request.content.userInfo
        print("userInfo10:\(userInfo)")
        completionHandler([.sound,.alert])
        
    }
    
    //iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void){
        let userInfo = response.notification.request.content.userInfo
        print("userInfo10:\(userInfo)")
        completionHandler()
    }
*/
    
    
}

extension UIWindow {
    // 获取当前活动的控制器
    public var visibleViewController:UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(vc:UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

