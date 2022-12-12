// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "606a66e870d735bd120b9edf0486a064"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: MessageRoomModel.self)
    ModelRegistry.register(modelType: UserModel.self)
  }
}