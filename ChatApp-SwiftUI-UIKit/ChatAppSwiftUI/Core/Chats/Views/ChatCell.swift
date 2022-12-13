//
//  ChatCell.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI

struct ChatCell: View {
    var user: UserModel
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
                    Text(user.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    if let room = room {
                        Text(room.messages?.last?.message ?? "")
                            .font(.subheadline)
                    }
                   
                }
                
                Spacer()
                
                if let room = room {
                    VStack(alignment: .trailing){
                        Text(room.lastUpdateDate.iso8601String)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.buttonColor)
                        
                        if room.users?.count != room.messages?.last?.readers?.count ?? 0 {
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
            viewModel.downloadImage(imageUrl: user.profileImageBase64) { image in
                
                withAnimation(.spring()){
                    profileImage = image
                }
            }
        }
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
