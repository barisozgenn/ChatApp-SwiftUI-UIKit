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
    @Persisted var profileImageBase64: String
    @Persisted var registerDate = Date()
    
    convenience init(name: String, email: String, profileImageBase64: String) {
        self.init()
        self.name = name
        self.email = email
        self.profileImageBase64 = profileImageBase64
    }
}
