//
//  StatusVC.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//
import UIKit
final class StatusVC: UIViewController {
    
    //MARK: - Properties
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helpers
    
    func setupUI(){
        view.backgroundColor = .blue
        self.navigationItem.title = navigationController?.title
    }
}
