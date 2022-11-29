//
//  MessageRoomModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

struct MessageRoomModel: Identifiable, Codable {
    @DocumentID var id: String?
    let users: [String]
    let roomName: String?
    let messages: [MessageModel]
    let lastUpdateDate: Timestamp?
}
