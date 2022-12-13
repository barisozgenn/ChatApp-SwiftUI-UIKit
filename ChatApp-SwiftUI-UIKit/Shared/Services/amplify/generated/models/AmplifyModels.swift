// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "d692f868ec832673dedb6145f5ea6f30"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: MessageRoomModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}