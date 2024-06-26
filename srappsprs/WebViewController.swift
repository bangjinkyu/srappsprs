//
//  WebViewController.swift
//  srappsprs
//
//  Created by 방진규 on 4/3/24.
//

import Foundation
import WebKit
import OSLog

class WebViewController : UIViewController {
    var webView: WKWebView!
    let urLToLoad = "https://srapp.vercel.app"
    let log = Logger(OSLog(subsystem: "com.testApp", category: "TEST"))
    
    
    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: .zero)
        self.view = webView!
        if #available(iOS 13.0, *) {
            var statusBarHeight: CGFloat = 0
            let margin = view.layoutMarginsGuide
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                statusBarHeight = window.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            }
            // height를 구하고,
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor.white
            statusbarView.frame = CGRect.zero
          
            self.view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            // frame 선언
            
            NSLayoutConstraint.activate([
                statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
                statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
            ])
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("room viewDidLoad")
        
        NotificationCenter.default.addObserver(forName: Notification.Name("didReceivePushTouch"), object: nil, queue: nil) { notification in
            
            guard let userInfo = notification.userInfo else {
                return
            }
            let notiKey = userInfo["link"] as? String
            print("room notiKey \(notiKey)")
    
            if notiKey == nil {
                self.loadWebPage(self.urLToLoad)
            } else {
                self.loadWebPage(notiKey ?? "")
            }
           
            return
        }
        
        let userDefaults = UserDefaults.standard
        guard let isPush = userDefaults.bool(forKey: "isPush") as? Bool  else { return}
        if (isPush) {
            
            log.log("room viewDidLoad isPush true!!")
            guard let userurl = userDefaults.string(forKey: "link") else { return }
            log.log("room22 viewDidLoad userurl \(userurl)")
            userDefaults.removeObject(forKey: "isPush")
            userDefaults.removeObject(forKey: "link")
            userDefaults.synchronize()
            loadWebPage(userurl)
            return
        }
        
        loadWebPage(urLToLoad)
        
    }
    
    private func loadWebPage(_ link: String) {
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .automatic
        webView.configuration.preferences.javaScriptEnabled = true
        guard let url = URL(string: link)  else {return}
        webView.load(URLRequest(url: url))
    }
    

}
