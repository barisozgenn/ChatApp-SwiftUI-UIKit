// swiftlint:disable all
import Amplify
import Foundation

public struct MessageRoomModel: Model {
  public let id: String
  public var users: [String?]?
  public var roomName: String?
  public var messages: [MessageModel?]?
  public var lastUpdateDate: Temporal.DateTime?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      users: [String?]? = nil,
      roomName: String? = nil,
      messages: [MessageModel?]? = nil,
      lastUpdateDate: Temporal.DateTime? = nil) {
    self.init(id: id,
      users: users,
      roomName: roomName,
      messages: messages,
      lastUpdateDate: lastUpdateDate,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      users: [String?]? = nil,
      roomName: String? = nil,
      messages: [MessageModel?]? = nil,
      lastUpdateDate: Temporal.DateTime? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.users = users
      self.roomName = roomName
      self.messages = messages
      self.lastUpdateDate = lastUpdateDate
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}