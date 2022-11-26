//
//  MainTabBarView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {
        NavigationStack{
            TabView{
                StatusView()
                    .tabItem {
                        Image(systemName: "circle.circle")
                        Text("Status")
                    }
                CallsView()
                    .tabItem {
                        Image(systemName: "phone")
                        Text("Calls")
                    }
                CommunitiesView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Communities")
                    }
                ChatsView()
                    .tabItem {
                        Image(systemName: "message")
                        Text("Chats")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                   
            }
            .accentColor(Color.theme.buttonColor)
            .onAppear{
                UITabBar.appearance().isTranslucent = false
                UITabBar.appearance().backgroundColor = UIColor.theme.tabBarBackgroundColor
            }
    
        }
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
