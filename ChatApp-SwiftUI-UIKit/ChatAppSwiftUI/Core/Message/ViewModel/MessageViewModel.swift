//
//  MessageViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 1.12.2022.
//

import SwiftUI
import RealmSwift
import Combine

final class MessageViewModel: ObservableObject {
    // MARK: - Properties
    
    let realm = try! Realm()
    @Published var userProfile: User?
    @Published var messages: [MessageModel] = []
    @Published var selectedRoom: MessageRoomModel?
    @Published var selectedUsers: [User]? = []
    
    @ObservedResults(MessageRoomModel.self, sortDescriptor: SortDescriptor(keyPath: "lastUpdateDate",ascending: true)) var rooms
    @ObservedResults(User.self) var users
    var cancellables = Set<AnyCancellable>()

    init(selectedRoom: MessageRoomModel? = nil, selectedUsers: [User]? = nil){
        if let selectedRoom = selectedRoom {
            self.selectedRoom = selectedRoom
            rooms.objectWillChange
                .receive(on: DispatchQueue.main)
                .sink { _ in
                
                } receiveValue: { [weak self] _ in
                    self?.fetchMessages()
                }
                .store(in: &cancellables)

        }
        if let selectedUsers = selectedUsers {self.selectedUsers = selectedUsers}
       
        if let userProfile = selectedUsers?.first(where: {$0._id == realmApp.currentUser?.id ?? ""}) {
            self.userProfile = userProfile
        }else if let userProfile = users.first(where: {$0._id == realmApp.currentUser?.id ?? ""}) {
            self.userProfile = userProfile
        }
    }
    
    // MARK: - Helpers
    // MARK: send message
    func sendMessage(_ message: String){
        guard let userProfile = self.userProfile else {return}
        
        if let selectedRoom = selectedRoom { // MARK: existing room
            let message = MessageModel(senderId: userProfile._id,
                                       readers: [userProfile._id],
                                       message: message)
            
            let room = realm.objects(MessageRoomModel.self).where{($0._id == selectedRoom._id)}.first!
            
            try! realm.write {
                room.messages.append(message)
            }
            
        }else { // MARK:  new room
            guard let selectedUsers = selectedUsers
            else{return}
            var userIds = selectedUsers.map { $0._id }
            userIds.append(userProfile._id)
            
            let message = MessageModel(senderId: userProfile._id,
                                       readers: [userProfile._id],
                                       message: message)
            
            let room = MessageRoomModel(users: userIds,
                                        roomName: setNavigationTitle() + (userProfile.name),
                                        messages: [message])
            
            //$rooms.append(room)
            try! realm.write {
                    realm.add(room)
                }
        }
    }
    // MARK: set navigation features
    func setNavigationTitle() -> String {
        
        if let selectedUsers = selectedUsers {
            if selectedUsers.count == 2 {
                return selectedUsers.first?.name ?? ""
            }else if selectedUsers.count > 2 {
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
            // you can add group photo here
            return selectedUsers.first(where: {$0._id != userProfile!._id})!.profileImageBase64
        }else {return "??"}
    }
    
    // MARK: - room messages
    func fetchMessages(){
        if let selectedRoom = selectedRoom {
            let room = realm.objects(MessageRoomModel.self).where{($0._id == selectedRoom._id)}.first!
            let roomMessages = room.messages.map({$0 as MessageModel})
            for newMessage in roomMessages {
                if !messages.contains(newMessage) {
                    messages.append(newMessage)
                }
            }
        }
    }
    // MARK: download image
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        completion(imageUrl.convertBase64ToUIImage())
    }
}
