// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "5032c82ae68de076765166a6dc605de1"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: MessageRoomModel.self)
    ModelRegistry.register(modelType: MessageModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}