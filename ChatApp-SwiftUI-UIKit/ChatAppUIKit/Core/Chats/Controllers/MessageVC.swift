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
    private lazy var headerView: UIView = {
        let frame = CGRect(x: 7, y: 0, width: 245, height: 35)
        let headerView = UIView()
        headerView.frame = frame
        headerView.addSubview(MessageHeaderView(name: "Barış Özgen", image: nil, frameRect: headerView.frame))
        return headerView
    }()
    
    private lazy var bottomView: UIView = {
        let frame = CGRect(x: 0, y: view.height - 80, width: view.width, height: 80)
        let bottomView = UIView()
        bottomView.frame = frame
        bottomView.backgroundColor = UIColor.theme.tabBarBackgroundColor
        bottomView.addSubview(plusButton)
        bottomView.addSubview(messageTextField)
        bottomView.addSubview(cameraButton)
        bottomView.addSubview(microphoneButton)
        bottomView.addSubview(attachmentButton)
        return bottomView
    }()
    
    private lazy var backgroundHeaderView: UIView = {
        let frame = CGRect(x: 0, y: 0, width: view.width, height: 80)
        let bottomView = UIView()
        bottomView.frame = frame
        bottomView.backgroundColor = UIColor.theme.appBackgroundColor
        return bottomView
    }()
    
    private let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "img-background-seamless")
        iv.layer.opacity = 0.7
        return iv
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.theme.buttonColor
        button.frame = CGRect(x: 14, y: 10, width: 30, height: 30)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    private lazy var attachmentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.split.bottomrightquarter"), for: .normal)
        button.tintColor = UIColor.theme.buttonColor
        button.frame = CGRect(x: view.width - 134, y: 10, width: 30, height: 30)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = UIColor.theme.buttonColor
        button.frame = CGRect(x: view.width - 80, y: 10, width: 30, height: 30)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    private lazy var microphoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "mic"), for: .normal)
        button.tintColor = UIColor.theme.buttonColor
        button.frame = CGRect(x: view.width - 40, y: 10, width: 30, height: 30)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private lazy var messageTextField: UITextField = {
        let tf = CustomMessageTextField(frame: CGRect(x: 50, y: 5, width: view.width - 145, height: 40))
        return tf
    }()
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .always
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.userInterfaceStyle == .dark  {
            backgroundImage.layer.opacity = 0.2
        }else { backgroundImage.layer.opacity = 0.7}
    }
    
    //MARK: - Helpers
    
    func setupUI(){
        view.backgroundColor = UIColor.theme.pageBackgroundColor
        
        navigationItem.titleView = headerView
        tabBarController?.tabBar.isHidden = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "phone"),
                            style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "video"),
                            style: .done, target: self, action: nil)]
        view.addSubview(backgroundHeaderView)
        view.addSubview(backgroundImage)
        backgroundImage.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        view.addSubview(bottomView)
        if traitCollection.userInterfaceStyle == .dark  {
            backgroundImage.layer.opacity = 0.2
        }else { backgroundImage.layer.opacity = 0.7}
    }
}
