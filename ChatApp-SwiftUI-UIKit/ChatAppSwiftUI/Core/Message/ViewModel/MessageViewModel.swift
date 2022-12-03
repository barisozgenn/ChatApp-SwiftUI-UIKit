//
//  MessageViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 1.12.2022.
//

import SwiftUI

class MessageViewModel: ObservableObject {
    // MARK: - Properties
    private let authService = AuthService.shared
    @Published var userProfile: User?
    
    @Published var selectedRoom: MessageRoomModel?
    @Published var selectedUsers: [User]? = []
    @Published var messages: [MessageModel] = []
    
    init(selectedRoom: MessageRoomModel? = nil, selectedUsers: [User]? = nil){
        if let selectedRoom = selectedRoom {self.selectedRoom = selectedRoom}
        if let selectedUsers = selectedUsers {self.selectedUsers = selectedUsers}
        
        fetchData()
        fetchUserProfiles()
    }
    
    // MARK: - Helpers
    // MARK: send message
    func sendMessage(_ message: String){
        guard let userProfile = self.userProfile else {return}
        
        if let selectedRoom = selectedRoom { // MARK: existing room
            
           
            
        }else { // MARK:  new room
            
           
        }
    }
    // MARK: fetch data
    func fetchData(){
        
    }
    // MARK: set navigation features
    func setNavigationTitle() -> String {
        if let room = selectedRoom {
            return room.roomName ?? ""
        }else if let selectedUsers = selectedUsers {
            if selectedUsers.count == 1 {
                return selectedUsers.first?.name ?? ""
            }else if selectedUsers.count > 1 {
                var roomName = ""
                for name in selectedUsers {
                    roomName += "\(name.name.split(separator: " ", omittingEmptySubsequences: true).first ?? ""), "
                }
                return String(roomName.dropLast(2))
            }
            return "?"
        }
        else {return "??"}
    }
    func setNavigationImage() -> String {
        if let selectedUsers = self.selectedUsers {
            if selectedUsers.count == 1 {return selectedUsers.first?.profileImageUrl ?? ""}
            else if selectedUsers.count > 1 {return "group.png"}
            else {return "??"}
        }else {return "??"}
    }
    
    // MARK: download image
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
       
    }
    
    // MARK: user profiles
    func fetchUserProfiles(){
       
        
    }
}
