//
//  MainTabBarView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI
import Firebase
struct MainTabBarView: View {
    @State private var isUserLoggedIn = true
    @State var selectedTab = "Chats"

    var body: some View {
        NavigationStack{
            if isUserLoggedIn {
                TabView(selection: $selectedTab){
                    StatusView()
                        .tabItem {
                            Image(systemName: "circle.circle")
                            Text("Status")
                        }
                        .tag("Status")
                        
                    CallsView()
                        .tabItem {
                            Image(systemName: "phone")
                            Text("Calls")
                        }
                        .tag("Calls")
                    
                    CommunitiesView()
                        .tabItem {
                            Image(systemName: "person.3")
                            Text("Communities")
                        }
                        .tag("Communities")
                    
                    ChatsView()
                        .tabItem {
                            Image(systemName: "message")
                            Text("Chats")
                        }
                        .tag("Chats")
                    
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                        .tag("Settings")
                }
                .navigationTitle(selectedTab)
                .accentColor(Color.theme.buttonColor)
                .onAppear{
                    UITabBar.appearance().isTranslucent = false
                    UITabBar.appearance().backgroundColor = UIColor.theme.tabBarBackgroundColor
                }
            }
            else {
                LoginView()
            }
        }
        .onAppear{
           // isUserLoggedIn = Auth.auth().currentUser == nil ? false : true
        }
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
