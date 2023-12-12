//
//  UPickApp.swift
//  UPick
//
//  Created by johnny basgallop on 12/09/2023.
//
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}



@main
struct YourApp: App {
  // register app delegate for Firebase setup
  
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
          SplashScreenView().preferredColorScheme(.light)
      }
    }
  }
}
