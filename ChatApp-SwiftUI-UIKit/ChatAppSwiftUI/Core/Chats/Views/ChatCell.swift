//
//  ChatCell.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI

struct ChatCell: View {
    var users: [UserModel]
    var room: MessageRoomModel?
    @State private var profileImage: UIImage =  UIImage(systemName: "circle.circle")!
    @EnvironmentObject var viewModel: ChatViewModel
    
    var body: some View {
        VStack{
            HStack{
                
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .fontWeight(.bold)
                    .frame(width: 48, height: 48)
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(Circle())
                
                VStack (alignment: .leading){
                    Text(roomUsersName())
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    if let room = room,
                        let lastMessage = viewModel.messages.first(where: {$0.id == room.lastMessageId}) {
                        Text(lastMessage.message)
                            .font(.subheadline)
                    }
                }
                
                Spacer()
                
                if let room = room,
                   let lastMessage = viewModel.messages.first(where: {$0.id == room.lastMessageId}) {
                    VStack(alignment: .trailing){
                        Text(room.lastUpdateDate.iso8601String.toHourMinuteString())
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.buttonColor)
                        
                        if room.users?.count != lastMessage.readers?.count ?? 0 {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color.theme.buttonColor)
                        }
                        
                    }
                }
                
                
            }
        }
        .padding(.vertical, 7)
        .background(Color.theme.appBackgroundColor)
        .onAppear{
            if users.count > 2 {
                profileImage = UIImage(named: "group-simpson")!
            }else{
                viewModel.downloadImage(imageUrl: users.first!.profileImageBase64) { image in
                    
                    withAnimation(.spring()){
                        profileImage = image
                    }
                }
            }
            
        }
    }
    func roomUsersName() -> String{
        let roomUsers = users.filter({$0.realmId != viewModel.userProfile?.realmId})
        var userNames = ""
        for user in roomUsers {
            if roomUsers.count > 1 {
                userNames += user.name.split(separator: " ").first! + ", "
            }
            else {
                userNames += user.name + ", "
            }
        }
        
        return String(userNames.dropLast(2))
    }
}
/*
 struct ChatCell_Previews: PreviewProvider {
 static var previews: some View {
 let user = User(name: "barış", email: "vsadas@sadas", profileImageUrl: "baris")
 let message = MessageModel(senderId: "sadasdas", readers: Set<["sadasd"]>, message: "messsage")
 let room = MessageRoomModel(users: ["sdasdasd"], roomName: "sadsadas", lastMessage: message, lastUpdateDate: Date())
 ChatCell(user: user, room: room)
 .environmentObject(ChatViewModel())
 }
 }
 */
