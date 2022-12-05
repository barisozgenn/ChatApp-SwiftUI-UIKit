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
        fetchRoomData()
    }
    
    // MARK: fetch data
    func fetchRoomData(){
        
    }
    func fetchUsersData(){
        self.userProfile = users.first(where: {$0._id == realmApp.currentUser?.id})
    }
    
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        completion(imageUrl.convertBase64ToUIImage())
    }
}
