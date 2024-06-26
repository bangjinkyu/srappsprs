//
//  MySceneDelegate.swift
//  srappsprs
//
//  Created by 방진규 on 3/28/24.
//

import Foundation
import UIKit
import OSLog

class MySceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?

    let log = Logger(OSLog(subsystem: "com.testApp", category: "TEST"))

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.rootViewController = WebViewController()
        window?.windowScene = windowScene
        
        if let urlContext = connectionOptions.urlContexts.first {
            log.log("room connectionOptions urlContexts")
                let url = urlContext.url
            
                print("room url: \(url)")

                let components = URLComponents(string: url.absoluteString)
                let urlQueryItems = components?.queryItems ?? []
        
                var dictionaryData = [String: String]()
                urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }
                guard let murl = dictionaryData["url"] else { return }
                print("room dictionaryData: \(murl)")
            
                let userDefaults = UserDefaults.standard
                userDefaults.set(murl, forKey: "link")
                userDefaults.set(true, forKey: "isPush")
                userDefaults.synchronize()
            
            window?.makeKeyAndVisible()
            return
        }
        
        
        if let response = connectionOptions.notificationResponse {
            log.log("room connectionOptions notificationResponse")
            
            let userInfo = response.notification.request.content.userInfo
            guard let pushUrl = userInfo["link"]! as? String else { return }
            let userDefaults = UserDefaults.standard
            userDefaults.set(pushUrl, forKey: "link")
            userDefaults.set(true, forKey: "isPush")
            userDefaults.synchronize()
            

            window?.makeKeyAndVisible()
            return
        }
      
     
        window?.makeKeyAndVisible()
    }
    
    //앱 실행중
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.rootViewController = WebViewController()
        window?.windowScene = windowScene
        
        guard let url = URLContexts.first?.url else { return }
        
            print("room url: \(url)")

            let components = URLComponents(string: url.absoluteString)
            let urlQueryItems = components?.queryItems ?? []
    
            var dictionaryData = [String: String]()
            urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }
            guard let murl = dictionaryData["url"] else { return }
            print("room dictionaryData: \(murl)")
        
            let userDefaults = UserDefaults.standard
            userDefaults.set(murl, forKey: "link")
            userDefaults.set(true, forKey: "isPush")
            userDefaults.synchronize()
        
        window?.makeKeyAndVisible()
        
    }
    
}
