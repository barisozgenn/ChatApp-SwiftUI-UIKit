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
        
    var body: some Scene {
        WindowGroup {
           MainTabBarView()
                .onAppear{print(Realm.Configuration.defaultConfiguration.fileURL!); configureRealm()}
        }
    }
    
    func configureRealm(){
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
         
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
}
