//
//  AuthService.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//


struct AuthService {
    var userSession: UserModel?
    
    static let shared = AuthService()
    
    init() {
        
    }
    
    func signOut(){
        
    }
    
    func fetchUserProfile(uid: String? = "", completion: @escaping (_ userProfile: UserModel) -> ()){
        
    }
    
    func registerUser(withCredential authCredential: AuthCredentials, userModel: UserModel){}
    
    
    func loginUser(withCredential authCredential: AuthCredentials, completion: @escaping(Error?, AuthCredentials) -> ()){
    }
    
    private func saveUserProfile(user: UserModel, userModel: UserModel){
        
    }
    
}
