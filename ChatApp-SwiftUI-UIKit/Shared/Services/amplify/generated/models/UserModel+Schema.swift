// swiftlint:disable all
import Amplify
import Foundation

extension UserModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case profileImageBase64
    case email
    case name
    case registerDate
    case realmId
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userModel = UserModel.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.syncPluralName = "UserModels"
    
    model.attributes(
      .primaryKey(fields: [userModel.id])
    )
    
    model.fields(
      .field(userModel.id, is: .required, ofType: .string),
      .field(userModel.profileImageBase64, is: .optional, ofType: .string),
      .field(userModel.email, is: .optional, ofType: .string),
      .field(userModel.name, is: .optional, ofType: .string),
      .field(userModel.registerDate, is: .optional, ofType: .dateTime),
      .field(userModel.realmId, is: .required, ofType: .string),
      .field(userModel.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(userModel.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension UserModel: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
