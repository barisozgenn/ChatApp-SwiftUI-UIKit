// swiftlint:disable all
import Amplify
import Foundation

public struct UserModel: Model, Hashable {
    public let id: String
    public var profileImageBase64: String
    public var email: String
    public var name: String
    public var registerDate: Temporal.DateTime
    public var realmId: String
    public var createdAt: Temporal.DateTime?
    public var updatedAt: Temporal.DateTime?
    
    public init(id: String = UUID().uuidString,
                profileImageBase64: String,
                email: String,
                name: String,
                registerDate: Temporal.DateTime,
                realmId: String) {
        self.init(id: id,
                  profileImageBase64: profileImageBase64,
                  email: email,
                  name: name,
                  registerDate: registerDate,
                  realmId: realmId,
                  createdAt: nil,
                  updatedAt: nil)
    }
    internal init(id: String = UUID().uuidString,
                  profileImageBase64: String,
                  email: String,
                  name: String,
                  registerDate: Temporal.DateTime,
                  realmId: String,
                  createdAt: Temporal.DateTime? = nil,
                  updatedAt: Temporal.DateTime? = nil) {
        self.id = id
        self.profileImageBase64 = profileImageBase64
        self.email = email
        self.name = name
        self.registerDate = registerDate
        self.realmId = realmId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    public static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.name == rhs.name && lhs.name == rhs.name
    }
}
