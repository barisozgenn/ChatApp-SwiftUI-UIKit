//
//  SearchViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import Foundation
import RealmSwift

class SearchViewModel: ObservableObject {
    
    @ObservedResults(User.self) var users
    
    init(){
        fetchData()
    }
    func fetchData(){
      
    }
}
