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
                        Text(room.lastMessage?.message ?? "")
                            .font(.subheadline)
                    }
                   
                }
                
                Spacer()
                
                if let room = room {
                    VStack(alignment: .trailing){
                        Text(room.lastUpdateDate.toHourMinuteString())
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.buttonColor)
                        
                        if room.users.count != room.lastMessage?.readers.count ?? 0 {
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
            viewModel.downloadImage(imageUrl: user.profileImageUrl) { image in
                
                withAnimation(.spring()){
                    profileImage = image
                }
            }
        }
    }
}

struct ChatCell_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserModel(name: "Barış Özgen", email: "sdsfdsfds", profileImageUrl: "sddfsdfs", registerDate: Date())
        let message = MessageModel(id: "sda", roomId: "jh", senderId: "sdasdas", readers: ["message readers"], message: "hjjhgjhgjhg", createdDate:  Date())
        let room = MessageRoomModel(users: ["sdasdasd"], roomName: "sadsadas", lastMessage: message, lastUpdateDate: Date())
        ChatCell(user: user, room: room)
            .environmentObject(ChatViewModel())
    }
}
