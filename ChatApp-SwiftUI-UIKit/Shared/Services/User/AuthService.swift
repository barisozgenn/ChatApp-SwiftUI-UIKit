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
    
    func fetchUserProfile(uid: String? = "", completion: @escaping (_ userProfile: UserModel) -> ()){
        
    }
    
    func registerUser(withCredential authCredential: AuthCredentials, completion: @escaping(Error?, APIKeyAuth?) -> ()){
        
        realmApp.emailPasswordAuth.registerUser(email: authCredential.email, password: authCredential.password) { (error) in
            guard error == nil else {
                print("DEBUG: Realm Failed to register: \(error?.localizedDescription ?? "?")")
                completion(error, nil)
                return
            }
            print("DEBUG: Realm Successfully registered user.")
            
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
    
    private func saveUserProfile(user: UserModel, userModel: UserModel){
        
    }
    
}
