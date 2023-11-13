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



@main
struct YourApp: App {
  // register app delegate for Firebase setup
  


  var body: some Scene {
    WindowGroup {
      NavigationView {
          SplashScreenView().preferredColorScheme(.light)
      }
    }
  }
}
