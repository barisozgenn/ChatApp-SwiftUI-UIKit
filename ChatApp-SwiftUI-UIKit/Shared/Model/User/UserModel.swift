//
//  UserModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

struct UserModel: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let email: String
    let profileImageUrl: String
    let registerDate: Timestamp?
}
