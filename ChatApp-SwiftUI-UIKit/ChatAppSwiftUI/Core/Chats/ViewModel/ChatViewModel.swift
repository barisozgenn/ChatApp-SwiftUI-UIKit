//
//  ChatViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI
import Amplify

class ChatViewModel: ObservableObject {
    @Published var selectedUserList : [UserModel] = []
    @Published var userProfile: UserModel?
    
    private var rooms: [MessageRoomModel] = []
    private var users : [UserModel] = []
    
    init() {
        fetchUsersData()
    }
    
    // MARK: fetch data
    func fetchSelectedRoomUsers(_ selectedRoom : MessageRoomModel) -> [User] {
       
        var selectedUsers: [User] = []
            for userId in selectedRoom.users! {
                selectedUsers.append(users.first(where: {$0.id == userId})!)
            }
            return selectedUsers
    }
    func fetchUsersData(){
        Amplify.DataStore.query(UserModel.self) { [weak self] result in
            switch result {
            case .failure(let error): print("DEBUG: error: \(error.localizedDescription)")
            case .success(let users):
                self?.users = users
                self?.userProfile = users.first(where: {$0.id == realmApp.currentUser!.id})
            }
        }
       
    }
    
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        completion(imageUrl.convertBase64ToUIImage())
    }
}
