//
//  ChatsView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI

struct ChatsView: View {
    @State private var searchText = ""
    @EnvironmentObject var viewModel: ChatViewModel
    
    var body: some View {
        VStack{
            HStack{
                SearchBarView(searchText: $searchText)
                NavigationLink(destination: MessageView()) {
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.theme.buttonColor)
                        .frame(height: 14)
                }
            }
            List(viewModel.rooms) { room in
                NavigationLink {
                    LazyNavigationView(build:
                                        MessageView().environmentObject(MessageViewModel(selectedRoom: room,
                                                                                         selectedUsers: viewModel.fetchSelectedRoomUsers(room))))
                     
                } label: {
                    ChatCell(user: (viewModel.users.first(where: {$0.realmId == room.users!.first(where: {$0 != viewModel.userProfile!.realmId} )}))!,
                             room: room)
                }

               
            }
            .listStyle(.plain)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.theme.appBackgroundColor)
    }
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
            .environmentObject(ChatViewModel())
    }
}
