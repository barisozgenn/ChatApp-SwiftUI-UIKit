//
//  ChatViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var selectedUserList : [UserModel] = []
    @Published var rooms : [MessageRoomModel] = []
    @Published var users: [UserModel]?
    @Published var userProfile: UserModel?
    
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
