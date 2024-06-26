//
//  MyAppDelegate.swift
//  srappsprs
//
//  Created by 방진규 on 2023/10/31.
//

import UIKit
import SwiftUI
import FirebaseCore
import UserNotifications
import FirebaseMessaging
import Firebase
import OSLog

class MyAppDelegate: NSObject, UIApplicationDelegate {
  
   var window: UIWindow?
    let log = Logger(OSLog(subsystem: "com.testApp", category: "TEST"))
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
        
        print("room didFinishLaunchingWithOptions")
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: authOptions) { granted, error in
                if granted {
                    print("알림 등록이 완료되었습니다.")
                }
            }
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        log.log("room willFinishLaunchingWithOptions")

        return true
    }

    
    
    

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        
    
        sceneConfig.delegateClass = MySceneDelegate.self
        return sceneConfig
    }

}



extension MyAppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
      ) {
        //  앱이 종료되었을때 시스템 노티를 탭한 경우 이곳에서도 수신
     
      }
    
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
            print("room - willPresent userNotificationCenter")
    
            completionHandler([.banner, .badge, .sound])
        }

   //백그라운드 클릭시
    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
            let userInfo = response.notification.request.content.userInfo
        
           print("room - didReceive userNotificationCenter")
        

            if UIApplication.shared.applicationState == .active {//앱이 활성화 상태에서 알림 클릭
               print("room - active!!!")
                
                NotificationCenter.default.post(name:
                NSNotification.Name("didReceivePushTouch"), object: nil, userInfo: userInfo)
        
            } else if UIApplication.shared.applicationState == .inactive {//앱이 비활성화 상태에서 알림 클릭
                print("room - inactive!!!")
                
                NotificationCenter.default.post(name:
                NSNotification.Name("didReceivePushTouch"), object: nil, userInfo: userInfo)
            } else if UIApplication.shared.applicationState == .background {
                
                print("room - background!!!")
               
            }
           
            completionHandler()
          
        }
    
}

extension MyAppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // 이 받은 값을 서버로 보내주어야함.
        print("FCM Token: \(String(describing: fcmToken))")
    }
    
}



