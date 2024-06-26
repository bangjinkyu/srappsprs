//
//  SrViewController.swift
//  srappsprs
//
//  Created by 방진규 on 3/27/24.
//

import Foundation
import UIKit

class SrViewController : UIViewController{
 
    override func loadView() {
       
        print("room loadView")
        super.loadView()
    }
    
    override func viewDidLoad() {
        print("room viewDidLoad()")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("room viewWillAppear()")
        
        
    }

}
