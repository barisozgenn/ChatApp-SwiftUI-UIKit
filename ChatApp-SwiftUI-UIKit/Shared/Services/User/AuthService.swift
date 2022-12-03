//
//  AuthService.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import RealmSwift
import Realm

struct AuthService {
    static let shared = AuthService()
        @ObservedResults(UserModel.self, sortDescriptor: SortDescriptor(keyPath: "name",ascending: true)) var users
    
    init() {
        
    }
    
    func signOut(){
        guard let currentUser = realmApp.currentUser else {return}
        currentUser.logOut { error in
            guard error == nil else {
                print("DEBUG: Realm logout: \(error?.localizedDescription ?? "?")")
                return
            }
        }
    }
    
    func fetchUserProfile(uid: ObjectId? = nil, completion: @escaping (_ userProfile: UserModel) -> ()){
        if let uid = uid {completion(users.first(where: {$0._id == uid})!)}
      
    }
    
    func registerUser(withCredential authCredential: AuthCredentials, userModel: UserModel,  completion: @escaping(Error?, APIKeyAuth?) -> ()){
        
        realmApp.emailPasswordAuth.registerUser(email: authCredential.email, password: authCredential.password) { (error) in
            guard error == nil else {
                print("DEBUG: Realm Failed to register: \(error?.localizedDescription ?? "?")")
                completion(error, nil)
                return
            }
            print("DEBUG: Realm Successfully registered user.")
            
            self.$users.append(userModel)
            
            loginUser(withCredential: authCredential) { error, apiKey in
                completion(error, apiKey)
            }
        }
    }
    
    
    func loginUser(withCredential authCredential: AuthCredentials, completion: @escaping(Error?, APIKeyAuth?) -> ()){
        
        let realmCredential: Credentials = Credentials.emailPassword(email: authCredential.email,
                                                                     password: authCredential.password)
        
        realmApp.login(credentials: realmCredential) { result in
            switch result {
            case .failure(let error):
                print("DEBUG: Realm Login failed: \(error.localizedDescription)")
                completion(error, nil)
            case .success(let user):
                print("DEBUG: Realm Successfully logged in as user \(user.apiKeysAuth)")
                completion(nil, user.apiKeysAuth)
            }
        }
        
    }
    
    private func saveUserProfile(userModel: UserModel){
    }
    
}
