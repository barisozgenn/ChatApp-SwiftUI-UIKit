//
//  ChatAppSwiftUIApp.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI
import RealmSwift

//do not forget to active Authentication Providers (email/password) on realm.mongodb
let realmApp = RealmSwift.App(id: "chat-baris-wshnz")

@main
struct ChatAppSwiftUIApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(CustomAppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            let _ = print("DEBUG: Realm Path: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path())")
           MainTabBarView()
        }
    }
    
}

class CustomAppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      let config = Realm.Configuration(
          // Set the new schema version. This must be greater than the previously used
          // version (if you've never set a schema version before, the version is 0).
          schemaVersion: 1,
          migrationBlock: { migration, oldSchemaVersion in
              // We haven’t migrated anything yet, so oldSchemaVersion == 0
              if (oldSchemaVersion < 1) {
                  // Nothing to do!
                  // Realm will automatically detect new properties and removed properties
                  // And will update the schema on disk automatically
              }
          }, seedFilePath: URL(string: "/User/barisozgen/Desktop"))
      Realm.Configuration.defaultConfiguration = config

    return true
  }
    
}
