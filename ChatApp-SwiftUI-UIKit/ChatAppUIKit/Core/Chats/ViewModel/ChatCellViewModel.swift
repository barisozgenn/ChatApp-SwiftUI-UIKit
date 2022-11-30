//
//  ChatCellViewModel.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 30.11.2022.
//

import UIKit
import FirebaseStorage
import Firebase

struct ChatCellViewModel {
    let user: UserModel
    let room: MessageRoomModel?
    
    var nameValue: String {return user.name}
    
    func downloadImage(completion: @escaping(_ image: UIImage) -> ()) {
        let ref = Storage.storage().reference(withPath: "\(FirebaseFileType.profile.folderName)\(user.profileImageUrl)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            
            guard let data = data,
                  let uiImage = UIImage(data: data) else {return}
            
             completion(uiImage)
        }
    }
    
    init(user: UserModel, room: MessageRoomModel) {
        self.user = user
        self.room = room
    }
}
