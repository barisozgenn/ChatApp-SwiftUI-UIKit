//
//  ChatAppSwiftUIApp.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI
import RealmSwift

let realmApp = RealmSwift.App(id: "chat-baris-wshnz")

@main
struct ChatAppSwiftUIApp: SwiftUI.App {
        
    var body: some Scene {
        WindowGroup {
           MainTabBarView()
        }
    }
}
