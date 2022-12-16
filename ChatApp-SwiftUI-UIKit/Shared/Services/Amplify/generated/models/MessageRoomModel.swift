// swiftlint:disable all
import Amplify
import Foundation

public struct MessageRoomModel: Model {
  public let id: String
  public var users: [String]?
  public var roomName: String
  public var lastMessageId: String
  public var lastUpdateDate: Temporal.DateTime
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      users: [String]? = nil,
      roomName: String,
      lastMessageId: String,
      lastUpdateDate: Temporal.DateTime) {
    self.init(id: id,
      users: users,
      roomName: roomName,
      lastMessageId: lastMessageId,
      lastUpdateDate: lastUpdateDate,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      users: [String]? = nil,
      roomName: String,
      lastMessageId: String,
      lastUpdateDate: Temporal.DateTime,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.users = users
      self.roomName = roomName
      self.lastMessageId = lastMessageId
      self.lastUpdateDate = lastUpdateDate
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}