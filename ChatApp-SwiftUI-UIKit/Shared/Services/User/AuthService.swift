//
//  AuthService.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import Firebase

struct AuthService {
    var userSession: Firebase.User?
    
    static let shared = AuthService()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func signOut(){
        try? Auth.auth().signOut()
    }
    
    func fetchUserProfile(uid: String? = "", completion: @escaping (_ userProfile: UserModel) -> ()){
        var userId = ""
        
        if let uid = uid {userId = uid}
        else if let uid = userSession?.uid {userId = uid}
        else {return}
        
        COLLECTION_USER_PROFILE.document(userId).getDocument { snapshot, error in
            
            if let error = error {
                print("DEBUG: Error fetching document: \(error.localizedDescription)")
                return
            }
            guard let userDict = snapshot?.data() else {return}
            
            let id = userDict["id"] as? String ?? ""
            let name = userDict["name"] as? String ?? ""
            let email = userDict["email"] as? String ?? ""
            let profileImageUrl = userDict["profileImageUrl"] as? String ?? ""
            let registerDate = userDict["registerDate"] as? Timestamp ?? Date().toTimestamp()
            
            let user = UserModel(id: id,name: name, email: email, profileImageUrl: profileImageUrl, registerDate: registerDate)
                    
            completion(user)
          
        }
    }
    
    func registerUser(withCredential authCredential: AuthCredentials, userModel: UserModel,  completion: @escaping (Error?, _ userProfile: UserModel?) -> ()){
        
        Auth.auth().createUser(withEmail: authCredential.email, password: authCredential.password) { (result, error) in
            
            if let error = error {
                print("DEBUG: Error writing document: \(error.localizedDescription)")
                completion(error, nil)
            }
            
            guard let user = result?.user else {return}
            saveUserProfile(user: user, userModel: userModel)
            
            fetchUserProfile { userProfile in
                completion(nil, userProfile)
            }
        }
    }
    
    func loginUser(withCredential authCredential: AuthCredentials, completion: @escaping (Error?, _ userProfile: UserModel?) -> ()){
        Auth.auth().signIn(withEmail: authCredential.email, password: authCredential.password) { (result, error) in
            
            if let error = error {
                print("DEBUG: Error writing document: \(error.localizedDescription)")
                completion(error, nil)
            }
            
            fetchUserProfile { userProfile in
                completion(nil, userProfile)
            }
        }
    }
    
    private func saveUserProfile(user: Firebase.User, userModel: UserModel){
        
        COLLECTION_USER_PROFILE.document(user.uid).setData(userModel.toDictionary(), merge: true){  error in
            if let error = error {
                print("DEBUG: Error writing document: \(error.localizedDescription)")
                return
            }
        }
    }
}

extension Encodable {
    func toDictionary() -> [String:Any] {
        var dict = [String:Any]()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard let key = child.label else { continue }
            let childMirror = Mirror(reflecting: child.value)
            
            switch childMirror.displayStyle {
            case .struct, .class:
                let childDict = (child.value as! Encodable).toDictionary()
                dict[key] = childDict
            case .collection:
                let childArray = (child.value as! [Encodable]).map({ $0.toDictionary() })
                dict[key] = childArray
            case .set:
                let childArray = (child.value as! Set<AnyHashable>).map({ ($0 as! Encodable).toDictionary() })
                dict[key] = childArray
            default:
                dict[key] = child.value
            }
        }
        
        return dict
    }
}
