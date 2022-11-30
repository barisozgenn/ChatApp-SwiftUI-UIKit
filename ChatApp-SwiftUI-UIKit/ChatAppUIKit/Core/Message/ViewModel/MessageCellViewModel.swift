//
//  MessageCellViewModel.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 30.11.2022.
//

import UIKit
import FirebaseStorage
import Firebase

struct MessageCellViewModel {
    let user: UserModel
    let message: MessageModel
    let isLast: Bool
    let rooomUserCount: Int
    
    var nameValue: String {return user.name}
    var messageValue: String {return message.message}
    var dateValue: String {return message.createdDate?.toHourMinuteString() ?? "hh:mm"}
    var isRead: Bool {return rooomUserCount == message.readers.count ? true : false}
    var isMine: Bool {return Auth.auth().currentUser?.uid == message.senderID ? true : false}
    
    func downloadImage(completion: @escaping(_ image: UIImage) -> ()) {
        let ref = Storage.storage().reference(withPath: "\(FirebaseFileType.profile.folderName)\(user.profileImageUrl)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            
            guard let data = data,
                  let uiImage = UIImage(data: data) else {return}
            
             completion(uiImage)
        }
    }
    
    init(user: UserModel, message: MessageModel, isLast: Bool, rooomUserCount: Int) {
        self.user = user
        self.message = message
        self.isLast = isLast
        self.rooomUserCount = rooomUserCount
    }
}
