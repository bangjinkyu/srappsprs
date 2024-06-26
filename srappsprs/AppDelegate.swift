//
//  MyAppDelegate.swift
//  srappsprs
//
//  Created by 뱡진규형제 on 2023/08/01.
//


import UIKit
import FirebaseCore
import Firebase
import UserNotifications
import FirebaseMessaging
import FirebaseAnalytics


class xAppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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
}


extension xAppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .badge, .sound])
        }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
            completionHandler()
        }
}

extension xAppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // 이 받은 값을 서버로 보내주어야함.
        print("FCM Token: \(String(describing :fcmToken))")
    }
}





