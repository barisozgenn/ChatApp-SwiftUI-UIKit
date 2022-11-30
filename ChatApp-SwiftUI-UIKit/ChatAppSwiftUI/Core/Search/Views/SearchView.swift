//
//  SearchView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismissEnvironment

    @State var searchText = ""
    @State var users: [UserModel] = []
    var body: some View {
        VStack{
            headerViews
            SearchBarView(searchText: $searchText)
            
            ForEach(users) { user in
                ChatCell(user: user)
            }
        }
        .padding()
    }
    
}
extension SearchView {
    private var headerViews: some View {
        HStack{
            VStack(alignment: .leading,spacing: 0){
                Text("Start a chat")
                    .font(.largeTitle)
                    .foregroundColor(Color(.darkGray))
                    .bold()
                Text("with people around you")
                    .font(.title2)
                    .foregroundColor(Color.theme.buttonColor)
                    .bold()
            }
            Spacer()
            Button {
                dismissEnvironment()
            } label: {
                Text("Done")
                    .fontWeight(.bold)
            }

        }
    }
    
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserModel(name: "Barış Özgen", email: "sdsfdsfds", profileImageUrl: "sddfsdfs", registerDate: Date().toTimestamp())
        let users: [UserModel] = [user,user,user,user,user,user,user,user,user,user]
        SearchView(users: users)
    }
}
