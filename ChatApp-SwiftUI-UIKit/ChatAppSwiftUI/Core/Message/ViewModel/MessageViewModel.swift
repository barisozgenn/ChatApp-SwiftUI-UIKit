//
//  MessageViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 1.12.2022.
//

import SwiftUI
import RealmSwift
import Combine
import Amplify

final class MessageViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var userProfile: UserModel?
    @Published var messages: [MessageModel] = []
    @Published var selectedRoom: MessageRoomModel?
    @Published var selectedUsers: [UserModel]? = []
    
    private var rooms: [MessageRoomModel] = []
    private var users : [UserModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    // In your type declaration, declare a cancellable to hold onto the subscription
    var chatsSubscription: AnyCancellable?
    
    init(selectedRoom: MessageRoomModel? = nil, selectedUsers: [UserModel]? = nil){
        
        fetchRoomsData()
        fetchUsersData()
        
        if let selectedRoom = selectedRoom {
            self.selectedRoom = rooms.first(where: {$0.id == selectedRoom.id})
            if let messages = selectedRoom.messages {
                self.messages = messages
            }
        }
        if let selectedUsers = selectedUsers {
            self.selectedUsers = selectedUsers
        }
        
        if let userProfile = selectedUsers?.first(where: {$0.realmId == realmApp.currentUser?.id ?? ""}) {
            self.userProfile = userProfile
        }else if let userProfile = users.first(where: {$0.realmId == realmApp.currentUser?.id ?? ""}) {
            self.userProfile = userProfile
        }
    }
    
    // MARK: - Helpers
    // MARK: send message
    func sendMessage(_ message: String){
        guard let userProfile = self.userProfile else {return}
        
        if var selectedRoom = selectedRoom { // MARK: existing room
            let message = MessageModel(id: UUID().uuidString,
                                       senderId: userProfile.realmId,
                                       readers: [userProfile.realmId],
                                       message: message,
                                       createdDate: Temporal.DateTime.now())
            
            selectedRoom.messages?.append(message)
            
            Amplify.DataStore.save(selectedRoom) { result in
                switch result {
                case .success(let room): print("DEBUG: add message success amplify \(room.roomName)")
                case .failure(let error): print("DEBUG: add message error amplify \(error.localizedDescription)")
                }
            }
            
            
        }else { // MARK:  new room
            guard let selectedUsers = selectedUsers
            else{return}
            var userIds = selectedUsers.map { $0.realmId }
            userIds.append(userProfile.realmId)
            
            let message = MessageModel(id: UUID().uuidString,
                                       senderId: userProfile.realmId,
                                       readers: [userProfile.realmId],
                                       message: message,
                                       createdDate: Temporal.DateTime.now())
            
            let room = MessageRoomModel(users: userIds,
                                        roomName: "\(setNavigationTitle()),  \(userProfile.name.split(separator: " ", omittingEmptySubsequences: true).first ?? "")",
                                        messages: [message], lastUpdateDate: Temporal.DateTime.now())
            
            Amplify.DataStore.save(room) {result in
                switch result {
                case .success(let room): print("DEBUG: add room success amplify \(room.roomName)")
                case .failure(let error): print("DEBUG: add room error amplify \(error.localizedDescription)")
                }
            }
        }
    }
    // MARK: set navigation features
    func setNavigationTitle() -> String {
        
        if let selectedUsers = selectedUsers {
            if selectedUsers.count < 2 {
                return selectedUsers.first(where: {$0.realmId != userProfile?.realmId})?.name ?? "not found"
            }else if selectedUsers.count >= 2 {
                var roomName = ""
                for user in selectedUsers {
                    roomName += "\(user.name.split(separator: " ", omittingEmptySubsequences: true).first ?? ""), "
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
            return selectedUsers.first(where: {$0.realmId != userProfile!.realmId})!.profileImageBase64
        }else {return "??"}
    }
    
    // MARK: -  apis
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
    func fetchRoomsData(){
        /*Amplify.DataStore.query(MessageRoomModel.self) { [weak self] result in
         switch result {
         case .failure(let error): print("DEBUG: error: \(error.localizedDescription)")
         case .success(let rooms):
         self?.rooms = rooms
         }
         }*/
        let room = MessageRoomModel.keys
        let observeQuery = Amplify.DataStore.observeQuery(for: MessageRoomModel.self,
                                                          where: room.id == selectedRoom?.id,
                                                          sort: .ascending(room.createdAt))
        
        chatsSubscription = observeQuery
            .receive(on: DispatchQueue.main)
            .sink { completed in
                switch completed {
                case .finished:
                    print("DEBUG: ObserveQuery finished")
                case .failure(let error):
                    print("DEBUG: Error observeQuery: \(error)")
                }
            } receiveValue: {[weak self] querySnapshot in
                print("[Snapshot] item count: \(querySnapshot.items.count), isSynced: \(querySnapshot.isSynced)")
                
                self?.rooms.append(contentsOf: querySnapshot.items)
            }
    }
    
    // MARK: download image
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        completion(imageUrl.convertBase64ToUIImage())
    }
}
