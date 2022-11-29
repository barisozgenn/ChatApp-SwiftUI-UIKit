//
//  ChatsVC.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import UIKit

final class ChatsVC: UIViewController {
    
    //MARK: - Properties
    private lazy var searchTextField: UITextField = {
        let navBottom: CGFloat = (navigationController?.navigationBar.bottom ?? 0) + 55
        
        let tf = CustomSearchTextField(placeHolder: "Search", frame: CGRect(x: 10, y: navBottom, width: view.width - 60, height: 35))
        return tf
    }()
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        button.tintColor = UIColor.theme.buttonColor
        button.frame = CGRect(x: searchTextField.right + 5, y: searchTextField.top, width: searchTextField.height, height: searchTextField.height)
        
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helpers
    
    func setupUI(){
        view.backgroundColor = UIColor.theme.appBackgroundColor
        self.navigationItem.title = navigationController?.title
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                            style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "camera"),
                            style: .done, target: self, action: nil)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit)
        
        view.addSubview(searchTextField)
        view.addSubview(sortButton)
    }
}
