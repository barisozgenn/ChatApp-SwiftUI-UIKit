//
//  ChatViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI
import RealmSwift
class ChatViewModel: ObservableObject {
    @Published var selectedUserList : [User] = []
    @Published var userProfile: User?
    
    @ObservedResults(MessageRoomModel.self, sortDescriptor: SortDescriptor(keyPath: "lastUpdateDate",ascending: true)) var rooms
    @ObservedResults(User.self) var users
    
    init() {
        fetchUsersData()
    }
    
    // MARK: fetch data
    func fetchSelectedRoomUsers(_ selectedRoom : MessageRoomModel) -> [User] {
        var selectedUsers: [User] = []
            for userId in selectedRoom.users {
                selectedUsers.append(users.first(where: {$0._id == userId})!)
            }
            return selectedUsers
    }
    func fetchUsersData(){
        self.userProfile = users.first(where: {$0._id == realmApp.currentUser?.id})
    }
    
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        completion(imageUrl.convertBase64ToUIImage())
    }
}
