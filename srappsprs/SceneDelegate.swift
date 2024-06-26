//
//  SceneDelegate.swift
//  srappsprs
//
//  Created by 방진규 on 2023/10/31.
//

import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    var window: UIWindow?
   
   
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        
       
    
        window?.windowScene = windowsScene
        window?.makeKeyAndVisible()
     
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let rootViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        self.window = UIWindow(windowScene: windowsScene)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        
    
    }
    
   
}

