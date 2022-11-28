//
//  Communities.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import UIKit

final class CommunitiesVC: UIViewController {
    
    //MARK: - Properties
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helpers
    
    func setupUI(){
        view.backgroundColor = .orange
        self.navigationItem.title = navigationController?.title
    }
}
