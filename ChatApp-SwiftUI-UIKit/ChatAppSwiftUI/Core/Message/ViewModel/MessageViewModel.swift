//
//  MessageViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 1.12.2022.
//

import SwiftUI
import FirebaseStorage
import Firebase
class MessageViewModel: ObservableObject {
    
    private let authService = AuthService.shared
    private var userProfile: UserModel?
    
    @Published var selectedRoom: MessageRoomModel?
    @Published var selectedUsers: [UserModel]?
    @Published var messages: [MessageModel]?
    
    init(selectedRoom: MessageRoomModel? = nil, selectedUsers: [UserModel]? = nil){
        self.selectedRoom = selectedRoom
        self.selectedUsers = selectedUsers
        
        authService.fetchUserProfile {[weak self] userProfile in
            self?.userProfile = userProfile
        }
        
        fetchData()
    }
    
    // MARK: - Helpers
    func sendMessage(selectedRoom: MessageRoomModel?, selectedUsers: [UserModel]?, message: String){
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        guard let userProfile = self.userProfile else {return}
                
        if let selectedRoom = selectedRoom { // existed room
            
        }else { // new room
            
            guard let selectedUsers = selectedUsers else {return}
            var users: [String] = [currentUserId]
            
            for user in selectedUsers {
                users.append(user.id ?? "")
            }
            
            let roomName =
            "\(userProfile.name.split(separator: " ", omittingEmptySubsequences: true).first ?? ""), "
            + setNavigationTitle()
            
            let message = MessageModel(senderID: currentUserId, readers: [""], message: message, createdDate: Date().timeIntervalSinceNow)
            
            let newRoom = MessageRoomModel(users: users, roomName: roomName, messages: [message], lastUpdateDate: Date().timeIntervalSinceNow)
            
            let roomId = "r\(selectedUsers.count > 1 ? "g" : "p")_\(UUID(uuidString: roomName)?.uuidString ?? UUID().uuidString)"
            
            try? COLLECTION_CHAT.document(roomId).setData(from: newRoom, merge: true){  error in
                if let error = error {
                    print("DEBUG: Error writing document: \(error.localizedDescription)")
                    return
                }
               fetchData()
            }
        }
    }
    
    func fetchData(){
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
    }
    
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
    
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        let ref = Storage.storage().reference(withPath: "\(FirebaseFileType.profile.folderName)\(imageUrl)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            
            guard let data = data,
                  let uiImage = UIImage(data: data) else {return}
            
            completion(uiImage)
        }
    }
}
