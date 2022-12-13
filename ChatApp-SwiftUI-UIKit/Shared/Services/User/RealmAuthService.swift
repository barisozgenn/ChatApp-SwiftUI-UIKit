//
//  RealmAuthService.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 3.12.2022.
//

import RealmSwift
import SwiftUI
import Combine
import Realm

//do not forget to active Authentication Providers (email/password) on realm.mongodb
let realmApp = RealmSwift.App(id: "chat-baris-wshnz")

final class RealmAuthService: ObservableObject {
        
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
    
    func realm() async throws -> Realm {
        let realmUser = realmApp.currentUser
        
        var config = realmUser!.flexibleSyncConfiguration()
        
        config.objectTypes = [User.self]
        
        let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
        print("Successfully opened realm: \(realm)")
        return realm
    }
    init() {
        loginPublisher
            .receive(on: DispatchQueue.main)
            .flatMap {[weak self] user -> RealmPublishers.AsyncOpenPublisher in
                self?.shouldIndicateActivity = true
                
                var config = user.flexibleSyncConfiguration()
                config.objectTypes = [User.self]
                
                return Realm.asyncOpen(configuration: config)
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
