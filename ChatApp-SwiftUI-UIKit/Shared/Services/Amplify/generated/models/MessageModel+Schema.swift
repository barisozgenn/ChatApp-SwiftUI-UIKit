// swiftlint:disable all
import Amplify
import Foundation

extension MessageModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case senderId
    case readers
    case message
    case createdDate
    case roomId
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let messageModel = MessageModel.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "MessageModels"
    
    model.attributes(
      .primaryKey(fields: [messageModel.id])
    )
    
    model.fields(
      .field(messageModel.id, is: .required, ofType: .string),
      .field(messageModel.senderId, is: .required, ofType: .string),
      .field(messageModel.readers, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(messageModel.message, is: .required, ofType: .string),
      .field(messageModel.createdDate, is: .required, ofType: .dateTime),
      .field(messageModel.roomId, is: .required, ofType: .string),
      .field(messageModel.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(messageModel.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension MessageModel: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}