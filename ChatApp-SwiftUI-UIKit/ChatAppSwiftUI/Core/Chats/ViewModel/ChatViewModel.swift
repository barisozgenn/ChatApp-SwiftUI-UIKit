//
//  ChatViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI
import FirebaseStorage
import Firebase

class ChatViewModel: ObservableObject {
    @Published var selectedUserList : [UserModel] = []
    @Published var rooms : [MessageRoomModel] = []
    @Published var users: [UserModel]?
    @Published var userProfile: UserModel?

    private let authService = AuthService.shared
    
    init() {
        fetchUsersData()
        fetchRoomData()
    }
    
    // MARK: fetch data
    func fetchRoomData(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let query = COLLECTION_ROOM
            .whereField("users", arrayContains: uid)
            .order(by: "createdDate", descending: false)
        
        query.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    let roomDict = diff.document.data()
                    
                    let id = roomDict["id"] as? String ?? ""
                    let roomName = roomDict["roomName"] as? String ?? ""
                    let users = roomDict["users"] as? [String] ?? []
                    let lastUpdateDate = roomDict["lastUpdateDate"] as? TimeInterval ?? Date().timeIntervalSinceReferenceDate
                    
                    let lastMessage = roomDict["lastMessage"] as? MessageModel ?? nil
                    
                    let roomItem = MessageRoomModel(id: id,users: users, roomName: roomName, lastMessage: lastMessage, lastUpdateDate: lastUpdateDate)
                    
                    self.rooms.append(roomItem)
                }
                
            }
        }
    }
    func fetchUsersData(){
        authService.fetchUserProfiles {[weak self] userProfiles in
            self?.users = userProfiles
            self?.userProfile = userProfiles.first(where: {$0.id == Auth.auth().currentUser?.uid})
        }
    }
    
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        let ref = Storage.storage().reference(withPath: "\(FirebaseFileType.profile.folderName)\(imageUrl)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            
            guard let data = data,
                  let uiImage = UIImage(data: data) else {return}
            
             completion(uiImage)
        }
    }
}
