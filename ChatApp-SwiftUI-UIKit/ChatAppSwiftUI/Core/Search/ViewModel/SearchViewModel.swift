//
//  SearchViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    
    init(){
        fetchData()
    }
    func fetchData(){
        //self?.users = documents.compactMap({try? $0.data(as: UserModel.self)})
    }
}
