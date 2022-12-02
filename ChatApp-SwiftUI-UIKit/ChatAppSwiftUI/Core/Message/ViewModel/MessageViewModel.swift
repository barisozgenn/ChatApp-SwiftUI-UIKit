//
//  MessageViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 1.12.2022.
//

import SwiftUI
import Firebase

class MessageViewModel: ObservableObject {
    // MARK: - Properties
    private let authService = AuthService.shared
    private var userProfile: UserModel?
    
    @Published var selectedRoom: MessageRoomModel?
    @Published var selectedUsers: [UserModel]?
    @Published var messages: [MessageModel] = []
    
    init(selectedRoom: MessageRoomModel? = nil, selectedUsers: [UserModel]? = nil){
        self.selectedRoom = selectedRoom
        self.selectedUsers = selectedUsers
        
        authService.fetchUserProfile {[weak self] userProfile in
            self?.userProfile = userProfile
        }
        
        fetchData()
    }
    
    // MARK: - Helpers
    // MARK: send message
    func sendMessage(_ message: String){
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        guard let userProfile = self.userProfile else {return}
        
        if let selectedRoom = selectedRoom { // MARK: existing room
            
            guard let roomId = selectedRoom.id else {return}
            
            let message = MessageModel(roomId: roomId, senderId: currentUserId, readers: [currentUserId], message: message, createdDate: Date().timeIntervalSinceNow)
            
            let data : [String:Any] = [
                "roomId": message.roomId,
                "senderId": message.senderId,
                "readers": message.readers,
                "message": message.message,
                "createdDate": message.createdDate as Any
            ]
            
            COLLECTION_MESSAGE.document(UUID().uuidString).setData(data)
            
            
        }else { // MARK:  new room
            
            guard let selectedUsers = selectedUsers else {return}
            var users: [String] = [currentUserId]
            
            for user in selectedUsers {
                users.append(user.id ?? "")
            }
            
            let roomName =
            "\(userProfile.name.split(separator: " ", omittingEmptySubsequences: true).first ?? ""), "
            + setNavigationTitle()
            
            let roomId = "r\(selectedUsers.count > 1 ? "g" : "p")_\(UUID(uuidString: roomName)?.uuidString ?? UUID().uuidString)"
            
            let messageModel = MessageModel(roomId: roomId, senderId: currentUserId, readers: [currentUserId], message: message, createdDate: Date().timeIntervalSinceNow)
            
            var newRoom = MessageRoomModel(users: users, roomName: roomName, lastMessage: messageModel, lastUpdateDate: Date().timeIntervalSinceNow)
            
            let data : [String:Any] = [
                "users": newRoom.users,
                "roomName": newRoom.roomName as Any,
                "lastMessage": newRoom.lastMessage as Any,
                "lastUpdateDate": newRoom.lastUpdateDate as Any
            ]
            
            COLLECTION_ROOM.document(roomId).setData(data, merge: true){ error in
                if let error = error {
                    print("DEBUG: Error writing document: \(error.localizedDescription)")
                    return
                }
                newRoom.id = roomId
                self.selectedRoom = newRoom
                self.sendMessage(messageModel.message)
            }
        }
    }
    // MARK: fetch data
    func fetchData(){
        guard let selectedRoom = self.selectedRoom,
              let roomId = selectedRoom.id else {return}
        
        let query = COLLECTION_MESSAGE
            .whereField("roomId", isEqualTo: roomId)
            .order(by: "createdDate", descending: false)
            
        query.addSnapshotListener { querySnapshot, _ in
            guard let changes = querySnapshot?.documentChanges.filter({$0.type == .added}) else {return}
            var message = changes.compactMap{ try? $0.document.data }
            self.messages.append(message)
        }
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
        }
    }
    
    // MARK: download image
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        let ref = Storage.storage().reference(withPath: "\(FirebaseFileType.profile.folderName)\(imageUrl)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            
            guard let data = data,
                  let uiImage = UIImage(data: data) else {return}
            
            completion(uiImage)
        }
    }
}
