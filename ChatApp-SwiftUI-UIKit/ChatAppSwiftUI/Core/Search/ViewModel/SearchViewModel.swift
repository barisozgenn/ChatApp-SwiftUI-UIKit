//
//  SearchViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import Foundation
import RealmSwift
import Amplify

final class SearchViewModel: ObservableObject {
    private let auth = RealmAuthService()

    @ObservedResults(User.self) var realmUsers
    @Published var users : [UserModel] = []
    @Published var userProfile: UserModel?

    init(){
        fetchUsersData()
    }
    func logout(){
        realmApp.currentUser?.logOut()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] user in
                self?.auth.shouldIndicateActivity = false
                self?.auth.logoutPublisher.send(user)
            })
            .store(in: &auth.cancellables)
    }
    func fetchUsersData(){
        Amplify.DataStore.query(UserModel.self) { [weak self] result in
            switch result {
            case .failure(let error): print("DEBUG: error: \(error.localizedDescription)")
            case .success(let users):
                self?.users = users
                self?.userProfile = users.first(where: {$0.realmId == realmApp.currentUser!.id})
            }
        }
       
    }
}
