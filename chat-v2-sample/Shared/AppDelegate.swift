//
//  AppDelegate.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/11/21.
//

import KustomerChat
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Configure Kustomer with your API Key
    // Make sure to do this in your app delegate!
    let options = KustomerOptions()
    options.logLevels = [.debug, .error]
    _ = Kustomer.configure(apiKey: Constants.apiKey, options: options, launchOptions: launchOptions)
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  // MARK: - Push

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Kustomer.didRegisterForRemoteNotifications(deviceToken: deviceToken)
  }

  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    Kustomer.didFailToRegisterForRemoteNotifications(error: error)
  }
}

