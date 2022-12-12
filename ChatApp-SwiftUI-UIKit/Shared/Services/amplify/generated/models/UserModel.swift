// swiftlint:disable all
import Amplify
import Foundation

public struct UserModel: Model {
  public let id: String
  public var profileImageBase64: String?
  public var email: String?
  public var name: String?
  public var registerDate: Temporal.DateTime?
  public var realmId: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      profileImageBase64: String? = nil,
      email: String? = nil,
      name: String? = nil,
      registerDate: Temporal.DateTime? = nil,
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
      profileImageBase64: String? = nil,
      email: String? = nil,
      name: String? = nil,
      registerDate: Temporal.DateTime? = nil,
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
}