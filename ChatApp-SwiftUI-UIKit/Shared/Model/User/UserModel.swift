//
//  UserModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import Foundation
struct UserModel: Identifiable, Codable, Hashable {
    var id: String?
    let name: String
    let email: String
    let profileImageUrl: String
    let registerDate: Date
}
