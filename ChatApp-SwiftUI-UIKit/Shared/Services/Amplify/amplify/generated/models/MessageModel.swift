// swiftlint:disable all
import Amplify
import Foundation

public struct MessageModel: Embeddable, Identifiable {
    public var id: String
    var senderId: String
    var readers: [String]?
    var message: String
    var createdDate: Temporal.DateTime
}
