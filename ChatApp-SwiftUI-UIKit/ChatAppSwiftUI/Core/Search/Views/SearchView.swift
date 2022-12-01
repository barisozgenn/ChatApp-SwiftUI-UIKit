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
    
    @State private var searchText = ""
    @State private var selection : Set<UserModel> = []
    @Binding var selectedUsers : Set<UserModel>?
    @State private var editMode = EditMode.inactive
    
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
            .navigationTitle("People")
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.editMode, $editMode)
            .onChange(of: selection) { newValue in
                selectedUsers = newValue
            }
            .onAppear{
                selection = []
                selectedUsers = selection
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
                if selectedUsers?.count == 1 {
                    Text("Start 👤")
                        .fontWeight(.bold)
                        .frame(alignment: .bottom)
                }else if selectedUsers?.count ?? 0 > 1 {
                    Text("Start 👥")
                        .fontWeight(.bold)
                        .frame(alignment: .bottom)
                }else {
                    Text("👤")
                }
                
            }

        }
    }
    
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
       /* let user = UserModel(name: "Barış Özgen", email: "sdsfdsfds", profileImageUrl: "sddfsdfs", registerDate: Date().toTimestamp())
        let users: [UserModel] = [user,user,user,user,user,user,user,user,user,user]*/
        SearchView(selectedUsers: .constant(nil))
            .environmentObject(SearchViewModel())
    }
}
