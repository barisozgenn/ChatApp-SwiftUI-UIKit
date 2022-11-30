//
//  SearchView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismissEnvironment
    @StateObject private var viewModel = SearchViewModel()
    
    @State var searchText = ""
    @State private var selection : Set<UserModel> = []
    
    var body: some View {
        VStack{
            headerViews
            SearchBarView(searchText: $searchText)
            
            List(viewModel.users, id: \.self, selection: $selection) { user in
                ChatCell(user: user)
            }
            .listStyle(.plain)
            .toolbar {
                EditButton()
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
                if selection.count == 1 {
                    Text("Start 👤")
                        .fontWeight(.bold)
                        .frame(alignment: .bottom)
                }else if selection.count > 0 {
                    Text("Start 👥")
                        .fontWeight(.bold)
                        .frame(alignment: .bottom)
                }
                
            }

        }
    }
    
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
       /* let user = UserModel(name: "Barış Özgen", email: "sdsfdsfds", profileImageUrl: "sddfsdfs", registerDate: Date().toTimestamp())
        let users: [UserModel] = [user,user,user,user,user,user,user,user,user,user]*/
        SearchView()
    }
}
