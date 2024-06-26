//
//  srappsprsApp.swift
//  srappsprs
//
//  Created by 뱡진규형제 on 2023/07/07.
//

import SwiftUI
import Firebase
import FirebaseCore
import UserNotifications
import FirebaseMessaging



@main
struct srappsprsApp: App {
    
    
    init() {
        Thread.sleep(forTimeInterval: 1.0)
    }

    @UIApplicationDelegateAdaptor var delegate :MyAppDelegate
    
    var body: some Scene {
       
        WindowGroup {
            ContentView()
               
        }
    }
    
    
}



