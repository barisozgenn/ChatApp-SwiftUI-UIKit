//
//  MessageVC.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//

import UIKit
import RxSwift

final class MessageVC: UIViewController {
    
    //MARK: - Properties
   
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helpers
    
    func setupUI(){
        view.backgroundColor = .systemGroupedBackground
        self.navigationItem.title = navigationController?.title
        
    }
}
