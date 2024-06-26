//
//  MyWebview.swift
//  srappsprs
//
//  Created by 뱡진규 on 2023/07/07.
//

import SwiftUI
import WebKit

//uikit 의 uiview 를 사용
struct MyWebview:  UIViewRepresentable{
    
  
    //ui view 만들기
    var urLToLoad : String
    
   
    func makeUIView(context: Context) -> WKWebView {
        // urwraapping
        guard let url  = URL(string : self.urLToLoad) else {
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webview = WKWebView()
   //     webview.allowsBackForwardNavigationGestures = true
        webview.scrollView.contentInsetAdjustmentBehavior = .never
        webview.configuration.preferences.javaScriptEnabled = true
        //웹뷰 로드
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebview>){
            
    }
}

struct MyWebview_Previews : PreviewProvider {
    static var previews: some View {
        MyWebview(urLToLoad: "https://srapp.vercel.app")
    }
}
