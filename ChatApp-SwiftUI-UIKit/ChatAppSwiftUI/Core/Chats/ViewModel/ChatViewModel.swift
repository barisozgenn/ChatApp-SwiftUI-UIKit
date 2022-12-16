//
//  ChatViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI
import Amplify
import Combine

class ChatViewModel: ObservableObject {
    @Published var selectedUserList : [UserModel] = []
    @Published var userProfile: UserModel?
    
    @Published var rooms: [MessageRoomModel] = []
    @Published var users : [UserModel] = []

    // In your type declaration, declare a cancellable to hold onto the subscription
    var chatsSubscription: AnyCancellable?
    
    init() {
        fetchUsersData()
    }
    
    // MARK: fetch data
    func fetchSelectedRoomUsers(_ selectedRoom : MessageRoomModel) -> [UserModel] {
       
        var selectedUsers: [UserModel] = []
        guard let selectedRoomUsers = selectedRoom.users else {return []}
        
            for userId in selectedRoomUsers {
                guard let selectedUser = users.first(where: {$0.realmId == userId}) else {return []}
                selectedUsers.append(selectedUser)
            }
            return selectedUsers
    }
    func fetchUsersData(){
        Amplify.DataStore.query(UserModel.self) { [weak self] result in
            switch result {
            case .failure(let error): print("DEBUG: error: \(error.localizedDescription)")
            case .success(let users):
                self?.users = users
                self?.userProfile = users.first(where: {$0.realmId == realmApp.currentUser!.id})
                self?.fetchRoomsData()
            }
        }
       
    }
    func fetchRoomsData(){
        let room = MessageRoomModel.keys
        /*let observeQuery = Amplify.DataStore.observeQuery(for: MessageRoomModel.self,
                                where: room.users.contains(userProfile?.realmId ?? "?"),
                                       sort: .ascending(room.createdAt))
        
        chatsSubscription = observeQuery
            .receive(on: DispatchQueue.main)
            .sink { completed in
                        switch completed {
                        case .finished:
                            print("DEBUG: ObserveQuery finished")
                        case .failure(let error):
                            print("DEBUG: Error observeQuery: \(error)")
                        }
                    } receiveValue: {[weak self] querySnapshot in
                        print("[Snapshot] item count: \(querySnapshot.items.count), isSynced: \(querySnapshot.isSynced)")
                        
                        self?.rooms.append(contentsOf: querySnapshot.items)
                    }*/
        // without combine
       Amplify.DataStore.query(MessageRoomModel.self,
                                where: room.users.contains(userProfile?.realmId ?? "?"),
                                       sort: .descending(room.createdAt)) { [weak self] result in
            switch result {
            case .failure(let error): print("DEBUG: error: \(error.localizedDescription)")
            case .success(let rooms):
                self?.rooms = rooms
            }
        }
    }
    // Then, when you're finished observing, cancel the subscription
    func unsubscribeFromChats() {
        chatsSubscription?.cancel()
    }
    
    func downloadImage(imageUrl: String,completion: @escaping(_ image: UIImage) -> ()) {
        completion(imageUrl.convertBase64ToUIImage())
    }
    
}
