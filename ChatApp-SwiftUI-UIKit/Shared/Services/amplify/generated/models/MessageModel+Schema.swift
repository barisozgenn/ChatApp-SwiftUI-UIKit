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
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let messageModel = MessageModel.keys
    
    model.pluralName = "MessageModels"
    
    model.fields(
      .field(messageModel.id, is: .required, ofType: .string),
      .field(messageModel.senderId, is: .required, ofType: .string),
      .field(messageModel.readers, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(messageModel.message, is: .required, ofType: .string),
      .field(messageModel.createdDate, is: .required, ofType: .dateTime)
    )
    }
}