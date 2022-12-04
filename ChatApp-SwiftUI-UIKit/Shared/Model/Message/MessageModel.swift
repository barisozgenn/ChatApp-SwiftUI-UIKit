//
//  MessageModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//
import Foundation
import RealmSwift

class MessageModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var  senderId: String
    @Persisted var  readers = List<String>()
    @Persisted var  message: String
    @Persisted var  createdDate = Date()
    
    convenience init(senderId: String, readers: [String], message: String) {
        self.init()
        self.senderId = senderId
        self.readers.append(objectsIn: readers)
        self.message = message
    }
}
