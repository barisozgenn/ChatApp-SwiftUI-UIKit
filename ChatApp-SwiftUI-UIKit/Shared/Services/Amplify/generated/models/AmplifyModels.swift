// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "f7a24446918e805ff5a1ab839279e725"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: MessageModel.self)
    ModelRegistry.register(modelType: MessageRoomModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}