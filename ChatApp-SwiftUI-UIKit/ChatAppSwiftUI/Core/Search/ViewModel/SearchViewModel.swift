//
//  SearchViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import Foundation
import RealmSwift

final class SearchViewModel: ObservableObject {
    private let auth = RealmAuthService()

    @ObservedResults(User.self) var users
    @Published var userProfile: User? = nil
    
    init(){
        fetchData()
    }
    func fetchData(){
        self.userProfile = users.first(where: {$0._id == realmApp.currentUser!.id})!
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
}
