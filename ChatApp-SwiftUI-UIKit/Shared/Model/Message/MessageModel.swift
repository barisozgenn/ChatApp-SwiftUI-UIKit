//
//  MessageModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

struct MessageModel: Identifiable, Codable {
    @DocumentID var id: String?
    let senderID: String
    let readers: [String]
    let createdDate: Timestamp
}
