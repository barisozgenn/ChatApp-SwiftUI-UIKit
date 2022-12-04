//
//  MessageRoomModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//

import RealmSwift
import Foundation
class MessageRoomModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var users = List<String>()
    @Persisted var roomName: String
    @Persisted var messages = List<MessageModel>()
    @Persisted var lastUpdateDate = Date()
    
    convenience init(users: [String], roomName: String, messages: [MessageModel]) {
        self.init()
        self.users.append(objectsIn: users)
        self.roomName = roomName
        self.messages.append(objectsIn: messages)
    }
}
