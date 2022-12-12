// swiftlint:disable all
import Amplify
import Foundation

public struct MessageModel: Embeddable {
  var id: String
  var senderId: String?
  var readers: [String?]?
  var message: String
  var createdDate: Temporal.DateTime
}