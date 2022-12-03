//
//  MessageRoomModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//

import Foundation
struct MessageRoomModel: Identifiable, Codable {
    var id: String?
    let users: [String]
    let roomName: String?
    let lastMessage: MessageModel?
    let lastUpdateDate: Date
}
