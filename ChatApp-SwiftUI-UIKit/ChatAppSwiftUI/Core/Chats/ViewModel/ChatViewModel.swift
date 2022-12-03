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
    @Published var users: [User]?
    @Published var userProfile: User?
    
    @ObservedResults(MessageRoomModel.self, sortDescriptor: SortDescriptor(keyPath: "lastUpdateDate",ascending: true)) var rooms
    
    init() {
        fetchUsersData()
        fetchRoomData()
    }
    
    // MARK: fetch data
    func fetchRoomData(){
        
    }
    func fetchUsersData(){
        
    }
    
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        
    }
}
