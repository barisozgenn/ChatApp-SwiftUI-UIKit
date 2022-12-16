//
//  MessageView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 29.11.2022.
//
import SwiftUI

struct MessageView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var messageText = ""
    @EnvironmentObject private var viewModel : MessageViewModel
    @State private var headerImage : UIImage? = UIImage(systemName: "circle.circle")
    
    var body: some View {
        ZStack {
            Color.theme.appBackgroundColor
                .frame(width: 450,height: 100)
                .position(x:225, y:50)
                .ignoresSafeArea()
            
            headerView
            Image("img-background-seamless")
                .resizable()
                .opacity(colorScheme == .light ? 0.7 : 0.2)
                .ignoresSafeArea()
            
            listView
            
            VStack{
                Spacer()
                bottomView
            }
            
        }
        .background(Color.theme.pageBackgroundColor)
    }
}
extension MessageView {
    private var bottomView: some View {
        HStack(spacing: 12){
            Button {
                viewModel.sendMessage(messageText)
                messageText = ""
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.theme.buttonColor)
            }
            MessageBarView(messageText: $messageText)
            Image(systemName: "square.split.bottomrightquarter")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.theme.buttonColor)
                .padding(.leading, -48)
            
            Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(Color.theme.buttonColor)
                .padding(.leading, -8)
            
            Image(systemName: "mic")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(Color.theme.buttonColor)
            
        }
        .padding()
        .background(Color.theme.tabBarBackgroundColor)
    }
    private var headerView: some View {
        ChatHeaderView(name: viewModel.setNavigationTitle(),
                       unread: "7",
                       imageUrl: viewModel.setNavigationImage())
        .environmentObject(viewModel)
        
    }
    private var listView: some View {
        ScrollView{
            ForEach(viewModel.messages){ message in
                MessageCell(messageValue: message.message,
                            dateValue: message.createdDate.iso8601String,
                            nameValue: viewModel.selectedUsers?.first(where: {$0.realmId == message.senderId})?.name ?? "?",
                            isMine: viewModel.userProfile?.realmId == message.senderId ? true : false,
                            isLast:  isLastMessageFromSameUser(message: message),
                            isGroup: viewModel.selectedUsers?.count ?? 0 > 2 ? true : false,
                            isRead: viewModel.selectedUsers?.count == message.readers?.count ? true : false)
                
            }
        }
        .ignoresSafeArea()
        .padding(.top, 5)
        .padding(.bottom, 60)
        .padding(.horizontal)
    }
    
    func isLastMessageFromSameUser(message: MessageModel) -> Bool {
        if viewModel.messages.last?.id == message.id {return true}
        else {
            //let indexOfMessage = viewModel.messages.firstIndex{$0 === message} // 0
            return false
        }
    }
}
struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
