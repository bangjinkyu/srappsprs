//
//  NavigationController.swift
//  srappsprs
//
//  Created by 방진규 on 3/27/24.
//

import Foundation
import UIKit


class NavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("room viewDidLoad()")
    }
    
    @objc public func applicationDidBecome() {
        print("room applicationDidBecome()")
    }
}
