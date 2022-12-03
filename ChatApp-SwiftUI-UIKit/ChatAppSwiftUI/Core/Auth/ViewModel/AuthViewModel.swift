//
//  AuthViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 3.12.2022.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    private let authService = AuthService.shared
    @Published var isUserNotLogin: Bool = true

    func apiLogin(email: String, password: String) {
        
        let authCreadential = AuthCredentials(email: email, password: password)
        // baris@test.chatApp.clone
        authService.loginUser(withCredential: authCreadential) {[weak self] (error, userProfile) in
            if let error = error {
                print(error.localizedDescription)
                self?.isUserNotLogin = true
                return
            }
            DispatchQueue.main.async {
                self?.isUserNotLogin = false
            }
           
        }
    }
    
    func apiRegister(email: String, password: String, name: String, image: UIImage?){
        let authCreadential = AuthCredentials(email: email, password: password)
        
        authService.registerUser(withCredential: authCreadential) {[weak self] (error, userProfile) in
            if let error = error {
                print(error.localizedDescription)
                self?.isUserNotLogin = true
                return
            }
            DispatchQueue.main.async {
                self?.isUserNotLogin = false
            }
        }
        
       /* ImageUploadService.uploadImage(image: image, folderType: .profile) { (urlString, fileName) in
            
            
        }*/
    }
    
    func logout(){
        authService.signOut()
    }
}
