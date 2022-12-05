//
//  RealmAuthService.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 3.12.2022.
//

import RealmSwift
import SwiftUI
import Combine

class RealmAuthService: ObservableObject {
    var loginPublisher = PassthroughSubject<RealmSwift.User, Error>()
    var logoutPublisher = PassthroughSubject<Void, Error>()
    let userRealmPublisher = PassthroughSubject<Realm, Error>()
    var cancellables = Set<AnyCancellable>()

    @Published var shouldIndicateActivity = false
    @Published var error: String?
    
    var user: User?

    var loggedIn: Bool {
        realmApp.currentUser != nil && realmApp.currentUser?.state == .loggedIn && user != nil
    }

    init() {

        loginPublisher
            .receive(on: DispatchQueue.main)
            .flatMap {[weak self] user -> RealmPublishers.AsyncOpenPublisher in
                self?.shouldIndicateActivity = true
                let realmConfig = user.configuration(partitionValue: "user=\(user.id)")
                return Realm.asyncOpen(configuration: realmConfig)
            }
            .receive(on: DispatchQueue.main)
            .map {
                self.shouldIndicateActivity = false
                return $0
            }
            .subscribe(userRealmPublisher)
            .store(in: &self.cancellables)

        userRealmPublisher
            .sink(receiveCompletion: {[weak self] result in
                if case let .failure(error) = result {
                    self?.error = "Failed to log in and open realm: \(error.localizedDescription)"
                }
            }, receiveValue: {[weak self] realm in
                print("Realm User file location: \(realm.configuration.fileURL!.path)")
                self?.user = realm.objects(User.self).first
            })
            .store(in: &cancellables)

        logoutPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {[weak self] _ in
                self?.user = nil
            })
            .store(in: &cancellables)
    }
}
