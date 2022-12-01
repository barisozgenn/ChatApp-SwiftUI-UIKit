//
//  MessageViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 1.12.2022.
//

import SwiftUI
import FirebaseStorage

class MessageViewModel: ObservableObject {
    
    // MARK: - Helpers
    func setNavigationTitle(selectedRoom: MessageRoomModel?, selectedUsers: [UserModel]? ) -> String {
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
    func setNavigationImage(selectedUsers: [UserModel] ) -> String {
        if selectedUsers.count == 1 {return selectedUsers.first?.profileImageUrl ?? ""}
        else if selectedUsers.count > 1 {return "group.png"}
        else {return "??"}
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
