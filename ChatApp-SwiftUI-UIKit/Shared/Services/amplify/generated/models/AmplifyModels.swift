// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "386f369d332fda130848cc59f3a8de67"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: MessageRoomModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}