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
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.fill")
                    .fontWeight(.bold)
                    .frame(width: 44, height: 44)
                    .padding(4)
                    .foregroundColor(.white)
                    .background(.gray)
                    .clipShape(Circle())
                
                VStack (alignment: .leading){
                    Text(user.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    if let room = room {
                        Text(room.messages.last?.message ?? "")
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
                        
                        if room.users.count != room.messages.last?.readers.count ?? 0 {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color.theme.buttonColor)
                        }
                       
                    }
                }
                
               
            }
        }
        .padding(.vertical, 7)
        .background(Color.theme.appBackgroundColor)
    }
}

struct ChatCell_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserModel(name: "Barış Özgen", email: "sdsfdsfds", profileImageUrl: "sddfsdfs", registerDate: Date().toTimestamp())
        let message = MessageModel(senderID: "sda", readers: ["sdasdas"], message: "message test", createdDate: Date().timeIntervalSinceNow)
        let room = MessageRoomModel(users: ["sdasdasd"], roomName: "sadsadas", messages: [message], lastUpdateDate: Date().timeIntervalSinceNow)
        ChatCell(user: user, room: room)
    }
}
