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
    UNUserNotificationCenter.current().delegate = self
    // Configure Kustomer with your API Key
    // Make sure to do this in your app delegate!
    let options = KustomerOptions()
    options.logLevels = KustomerLogTypeAll
    options.pushEnvironment = .development
    _ = Kustomer.setup(apiKey: Constants.apiKey, options: options, launchOptions: launchOptions) { result in
      switch result {
      case .success:
        print("✅ Configuration succeeded")
      case .failure(let error):
        print("⚠️ Config error: \(error.localizedDescription)")
      }
    }
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

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    if response.notification.isFromKustomer() {
      Kustomer.pushProvider.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    if notification.isFromKustomer() {
      Kustomer.pushProvider.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }
  }
}

