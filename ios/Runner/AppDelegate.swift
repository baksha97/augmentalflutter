import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    //flutter
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    FlutterDelegate.shared.configureDelegation(controller: controller)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
