//
//  FlutterDelegate.swift
//  Runner
//
//  Created by Loaner on 3/7/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
// Add to AppDelegate:
////flutter
//let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
//FlutterDelegate.shared.configureDelegation(controller: controller)

import Foundation

class FlutterDelegate: FlutterAppDelegate{
    
    static let shared = FlutterDelegate();

    
    private var flutterController: FlutterViewController?
    
    func configureDelegation(controller: FlutterViewController){
       // GeneratedPluginRegistrant.register(with: self);
        self.flutterController = controller
        let controller : FlutterViewController = controller
        let unityChannel = FlutterMethodChannel.init(name: "augmental.io/unity",
                                                       binaryMessenger: controller);
        unityChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: FlutterResult) -> Void in
          if ("openUnity" == call.method) {
            DispatchQueue.main.async {
                self.openUnity()
            }
            print("flutter button clicked")
          } else {
            result(FlutterMethodNotImplemented);
          }
        });
        print()
        print()
        print()
        print()
        print()
    }
    
    func openUnity(){
        let alert = UIAlertController(title: "This is when Unity opens",
                                      message: "Pls work and good luck future JAM. :)",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        
        UIApplication.topViewController()?.present(alert, animated: true)
    }
    
    
}



