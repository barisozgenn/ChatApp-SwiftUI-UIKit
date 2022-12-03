//
//  AuthViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 3.12.2022.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

class AuthViewModel: ObservableObject {
    private let dataService = RealmAuthService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isUserNotLogin: Bool = true
    @ObservedResults(User.self) var users
    
    func apiLogin(email: String, password: String) {
        dataService.error = nil
        let authCreadential = AuthCredentials(email: email, password: password)
        // baris@test.chatApp.clone
        realmApp.login(credentials: .emailPassword(email: authCreadential.email, password: authCreadential.password))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self?.dataService.error = error.localizedDescription
                    self?.isUserNotLogin = true
                }
            }, receiveValue: { [weak self] realm in
                self?.dataService.error = nil
                self?.dataService.loginPublisher.send(realm)
                self?.isUserNotLogin = false
            })
            .store(in: &dataService.cancellables)
        
    }
    
    func apiRegister(email: String, password: String, name: String, image: UIImage?){
        let authCreadential = AuthCredentials(email: email, password: password)
        let user : User = User(name: name,
                               email: email,
                               profileImageUrl: String(name.split(separator: " ").first!))
        dataService.error = nil

        realmApp.emailPasswordAuth.registerUser(email: authCreadential.email, password: authCreadential.password)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { [weak self] result in
                        self?.dataService.shouldIndicateActivity = false
                        switch result {
                        case .finished:
                            break
                        case .failure(let error):
                            self?.dataService.error = error.localizedDescription
                        }
                    },
                          receiveValue: { [weak self] _ in
                        self?.dataService.error = nil
                        self?.$users.append(user)
                        self?.apiLogin(email: authCreadential.email, password: authCreadential.password)
                    })
                    .store(in: &dataService.cancellables)
    }
    
    
    func logout(){
        dataService.shouldIndicateActivity = true
        realmApp.currentUser?.logOut()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {[weak self] realm in
                self?.dataService.shouldIndicateActivity = false
                self?.dataService.logoutPublisher.send(realm)
                self?.isUserNotLogin = true
            })
            .store(in: &dataService.cancellables)
    }
}
