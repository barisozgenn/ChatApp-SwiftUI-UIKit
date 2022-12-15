//
//  ChatViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI
import Amplify
import RealmSwift

class ChatViewModel: ObservableObject {
    @Published var selectedUserList : [UserModel] = []
    @Published var userProfile: UserModel?
    
    @Published var rooms: [MessageRoomModel] = []
    @Published var users : [UserModel] = []

    init() {
       
        fetchRoomsData()
        fetchUsersData()
    }
    
    // MARK: fetch data
    func fetchSelectedRoomUsers(_ selectedRoom : MessageRoomModel) -> [UserModel] {
       
        var selectedUsers: [UserModel] = []
        guard let selectedRoomUsers = selectedRoom.users else {return []}
        
            for userId in selectedRoomUsers {
                guard let selectedUser = users.first(where: {$0.realmId == userId}) else {return []}
                selectedUsers.append(selectedUser)
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
                print("amplify count: \(self?.users.count)")
            }
        }
       
    }
    func fetchRoomsData(){
        Amplify.DataStore.query(MessageRoomModel.self) { [weak self] result in
            switch result {
            case .failure(let error): print("DEBUG: error: \(error.localizedDescription)")
            case .success(let rooms):
                self?.rooms = rooms
            }
        }
    }
    
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        completion(imageUrl.convertBase64ToUIImage())
    }
}
