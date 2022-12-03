//
//  MessageModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//
import Foundation
struct MessageModel: Identifiable, Codable {
    var id: String?
    let roomId: String
    let senderId: String
    let readers: [String]
    let message: String
    let createdDate: Date?
}
