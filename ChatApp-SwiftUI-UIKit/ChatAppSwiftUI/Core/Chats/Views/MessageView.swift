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
    
    var body: some View {
        ZStack {
            Color.theme.appBackgroundColor
                .frame(width: 450,height: 100)
                .position(x:225, y:50)
                .ignoresSafeArea()
            ChatHeaderView(name: "Barış Özgen", unread: "7", image: UIImage(systemName: "person"))
            Image("img-background-seamless")
                .resizable()
                .opacity(colorScheme == .light ? 0.7 : 0.2)
                .ignoresSafeArea()
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
            Button {} label: {
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
}
struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}