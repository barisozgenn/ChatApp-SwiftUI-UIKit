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
    @StateObject var viewModelChat = ChatViewModel()
    
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
                        .environmentObject(viewModelChat)
                    
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                        .tag("Settings")
                }
                .navigationTitle(selectedTab)
                .toolbar(content: {
                    switch selectedTab {
                    case "Chats" :
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                print("tapped")
                            } label: {
                                Text("Edit")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                print("tapped")
                            } label: {
                                Image(systemName: "camera")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {

                            NavigationLink {
                               SearchView()
                                    .environmentObject(viewModelChat)
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    default:
                        ToolbarItem(placement: .navigationBarTrailing) {}
                    }
                })
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
