//
//  MessageViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 1.12.2022.
//

import SwiftUI
import RealmSwift

class MessageViewModel: ObservableObject {
    // MARK: - Properties
    @Published var userProfile: User?
    
    @Published var selectedRoom: MessageRoomModel?
    @Published var selectedUsers: [User]? = []
    @Published var messages: [MessageModel] = []
    
    @ObservedResults(MessageRoomModel.self, sortDescriptor: SortDescriptor(keyPath: "lastUpdateDate",ascending: true)) var rooms
    @ObservedResults(User.self) var users
    
    init(selectedRoom: MessageRoomModel? = nil, selectedUsers: [User]? = nil){
        if let selectedRoom = selectedRoom {self.selectedRoom = selectedRoom}
        if let selectedUsers = selectedUsers {self.selectedUsers = selectedUsers}
       
        if let userProfile = selectedUsers?.first(where: {$0._id == realmApp.currentUser?.id ?? ""}) {
           print("here a")
            self.userProfile = userProfile
        }else if let userProfile = users.first(where: {$0._id == realmApp.currentUser?.id ?? ""}) {
            print("here b")
            self.userProfile = userProfile
        }
        fetchData()
    }
    
    // MARK: - Helpers
    // MARK: send message
    func sendMessage(_ message: String){
        print("here 0")
        guard let userProfile = self.userProfile else {return}
        print("here 1")
        if let selectedRoom = selectedRoom { // MARK: existing room
            print("here 1 a")
            
            
        }else { // MARK:  new room
            print("here 1b")
            guard let selectedUsers = selectedUsers
            else{return}
            print("here 2a")
            var userIds = selectedUsers.map { $0._id }
            userIds.append(userProfile._id)
            
            let message = MessageModel(senderId: userProfile._id,
                                       readers: [userProfile._id],
                                       message: message)
            
            let room = MessageRoomModel(users: userIds,
                                        roomName: setNavigationTitle() + (userProfile.name),
                                        messages: [message])
            
            $rooms.append(room)
            print(rooms.count)
        }
    }
    // MARK: fetch data
    func fetchData(){
        
    }
    // MARK: set navigation features
    func setNavigationTitle() -> String {
        if let room = selectedRoom {
            return room.roomName
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
            if selectedUsers.count == 1 {return selectedUsers.first?.profileImageBase64 ?? ""}
            else if selectedUsers.count > 1 {return "group.png"}
            else {return "??"}
        }else {return "??"}
    }
    
    // MARK: download image
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        completion(imageUrl.convertBase64ToUIImage())
    }
}
