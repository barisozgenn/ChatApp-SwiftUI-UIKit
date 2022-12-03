//
//  UserModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) dynamic var _id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var profileImageUrl: String
    @Persisted var registerDate = Date()
    
    convenience init(name: String, email: String, profileImageUrl: String) {
        self.init()
        self.name = name
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
}
