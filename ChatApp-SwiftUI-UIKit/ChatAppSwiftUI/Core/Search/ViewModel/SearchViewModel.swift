//
//  SearchViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import Firebase

class SearchViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    
    init(){
        fetchData()
    }
    func fetchData(){
        
        COLLECTION_USER_PROFILE.getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("DEBUG: Error writing document: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else {return}
            
            self?.users = documents.compactMap({try? $0.data(as: UserModel.self)})
        }
    }
}
