//
//  SettingsModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 27.11.2022.
//

import Foundation
import SwiftUI
enum SettingsModel: String, CaseIterable, Identifiable, Codable {
    case starredMessages
    case linkedDevice
    case account
    case privacy
    case chats
    case notifications
    case storageAndData
    case help
    case tellAFriend
    
    var id : String { return rawValue}
    
    var title : String {
        switch self {
        case .starredMessages: return "starred Messages".capitalized
        case .linkedDevice:return "linked Device".capitalized
        case .account:return "account".capitalized
        case .privacy:return "privacy".capitalized
        case .chats:return "chats".capitalized
        case .notifications:return "notifications".capitalized
        case .storageAndData:return "storage And Data".capitalized
        case .help:return "help".capitalized
        case .tellAFriend:return "tell A Friend".capitalized
        }
    }
    
    var image : String {
        switch self {
        case .starredMessages: return "star.fill"
        case .linkedDevice:return "laptopcomputer"
        case .account:return "key.fill"
        case .privacy:return "lock.fill"
        case .chats:return "message.fill"
        case .notifications:return "app.badge"
        case .storageAndData:return "arrow.up.arrow.down"
        case .help:return "info"
        case .tellAFriend:return "heart.fill"
        }
    }
    
    var bgColor: UIColor {
        switch self {
        case .starredMessages: return .systemYellow
        case .linkedDevice:return .green
        case .account:return .systemBlue
        case .privacy:return .cyan
        case .chats:return .systemGreen
        case .notifications:return .red
        case .storageAndData:return .green
        case .help:return .blue
        case .tellAFriend:return .systemPink
        }
    }
    
    var section : Int {
        switch self {
        case .starredMessages: return 0
        case .linkedDevice:return 0
        case .account:return 1
        case .privacy:return 1
        case .chats:return 1
        case .notifications:return 1
        case .storageAndData:return 1
        case .help:return 2
        case .tellAFriend:return 2
        }
    }
}
