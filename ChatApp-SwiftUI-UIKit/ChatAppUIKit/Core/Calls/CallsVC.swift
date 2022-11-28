//
//  CallsVC.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import UIKit

final class CallsVC: UIViewController {
    
    //MARK: - Properties
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helpers
    
    func setupUI(){
        view.backgroundColor = .purple
        self.navigationItem.title = navigationController?.title
    }
}
