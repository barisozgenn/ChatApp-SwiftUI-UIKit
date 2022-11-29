//
//  ChatsView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI

struct ChatsView: View {
    @State private var searchText = ""
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
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.theme.appBackgroundColor)
    }
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
