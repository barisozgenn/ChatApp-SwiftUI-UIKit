// swiftlint:disable all
import Amplify
import Foundation

public struct MessageModel: Model, Identifiable {
  public let id: String
  public var senderId: String
  public var readers: [String]?
  public var message: String
  public var createdDate: Temporal.DateTime
  public var roomId: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      senderId: String,
      readers: [String]? = nil,
      message: String,
      createdDate: Temporal.DateTime,
      roomId: String) {
    self.init(id: id,
      senderId: senderId,
      readers: readers,
      message: message,
      createdDate: createdDate,
      roomId: roomId,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      senderId: String,
      readers: [String]? = nil,
      message: String,
      createdDate: Temporal.DateTime,
      roomId: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.senderId = senderId
      self.readers = readers
      self.message = message
      self.createdDate = createdDate
      self.roomId = roomId
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
