//
//  AuthViewModel.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 28.11.2022.
//

import RxSwift
import UIKit

struct AuthViewModel {
    let authService = AuthService.shared
    let email = PublishSubject<String>()
    let password = PublishSubject<String>()
    let name = PublishSubject<String>()
    
    func isValid(isLogin: Bool = true) -> Observable<Bool> {
        if isLogin {
            return Observable.combineLatest(email.asObservable().startWith(""),
                                            password.asObservable().startWith(""))
            .map { (email, password) in
                return email.contains("@") && password.count > 5
            }
            .startWith(false)
        }else {
            return Observable.combineLatest(email.asObservable().startWith(""),
                                            password.asObservable().startWith(""),
                                            name.asObservable().startWith(""))
            .map { (email, password, name) in
                return email.contains("@") && password.count > 5 && name.count > 2
            }
            .startWith(false)
        }
        
    }
    
    func apiLogin(email: String, password: String) {
        
        let authCreadential = AuthCredentials(email: email, password: password)
        // baris@test.chatApp.clone
        authService.loginUser(withCredential: authCreadential) { (error, userProfile) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let userProfile = userProfile else{return}
            print("DEBUG: user logged in: \(userProfile.name)")
        }
    }
    
    func apiRegister(email: String, password: String, name: String, image: UIImage){
        let authCreadential = AuthCredentials(email: email, password: password)
        
        ImageUploadService.uploadImage(image: image, folderType: .profile) { (urlString, fileName) in
            
            let user = UserModel(name: name, email: email, profileImageUrl: fileName, registerDate: Date().toTimestamp())
            
            self.authService.registerUser(withCredential: authCreadential, userModel: user, completion: { (error, userProfile) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let userProfile = userProfile else{return}
                print("DEBUG: user logged in: \(userProfile.name)")
            })
            
        }
    }
}
