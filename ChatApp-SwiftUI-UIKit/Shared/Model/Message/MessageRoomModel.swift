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
    @Persisted var users: MutableSet<String>
    @Persisted var roomName: String
    @Persisted var messages: MutableSet<MessageModel>
    @Persisted var lastUpdateDate = Date()
    
    convenience init(users: MutableSet<String>, roomName: String, lastMessage: MutableSet<MessageModel>) {
        self.init()
        self.users = users
        self.roomName = roomName
        self.messages = lastMessage
    }
}
