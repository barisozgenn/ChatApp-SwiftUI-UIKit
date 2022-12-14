// swiftlint:disable all
import Amplify
import Foundation

extension MessageRoomModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case users
    case roomName
    case lastMessageId
    case lastUpdateDate
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let messageRoomModel = MessageRoomModel.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.syncPluralName = "MessageRoomModels"
    
    model.attributes(
      .primaryKey(fields: [messageRoomModel.id])
    )
    
    model.fields(
      .field(messageRoomModel.id, is: .required, ofType: .string),
      .field(messageRoomModel.users, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(messageRoomModel.roomName, is: .required, ofType: .string),
      .field(messageRoomModel.lastMessageId, is: .required, ofType: .string),
      .field(messageRoomModel.lastUpdateDate, is: .required, ofType: .dateTime),
      .field(messageRoomModel.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(messageRoomModel.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension MessageRoomModel: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
