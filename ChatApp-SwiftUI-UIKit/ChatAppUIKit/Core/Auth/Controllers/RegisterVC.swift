//
//  RegisterVC.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 28.11.2022.
//

import UIKit
import RxSwift

class RegisterVC: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Helpers
    func setupUI(){
        view.backgroundColor = UIColor.theme.tabBarBackgroundColor
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
        
        view.addSubview(photoButton)
        photoButton.centerX(inView: view,
                            topAnchor: view.safeAreaLayoutGuide.topAnchor,
                            paddingTop: 70)
        photoButton.setDimensions(height: 92, width: 92)
        
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField,
                                                       emailTextField,
                                                       passwordTextField,
                                                       passwordRepeatTextField,
                                                       registerButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        
        view.addSubview(stackView)
        stackView.anchor(top: photoButton.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 58,
                         paddingLeft: 29,
                         paddingRight: 29)
        
        view.addSubview(loginButton)
        loginButton.centerX(inView: view)
        loginButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        // textfield rx
        emailTextField.rx.text.map { $0 ?? ""}
            .bind(to: viewModel.email)
            .disposed(by: bag)
        
        passwordTextField.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.password)
            .disposed(by: bag)
        
        nameTextField.rx.text.map({$0 ?? ""})
            .bind(to: viewModel.name)
            .disposed(by: bag)
        
        // image rx
        //photoButton?.rx.
            
        
        // button rx
        viewModel.isValid(isLogin: false)
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: bag)
        viewModel.isValid(isLogin: false)
            .map{$0 ? UIColor.theme.buttonColor : .gray}
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: bag)
    }
    
    // MARK: - Properties
    private var viewModel = AuthViewModel()
    private var bag = DisposeBag()
    
    private var profileImage: UIImage?
    
    private lazy var photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.imageView?.contentMode = .scaleAspectFill
        button.backgroundColor = .black
        button.tintColor = UIColor.theme.buttonColor
        button.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
        button.addTarget(self, action: #selector(didTapPhoto), for: .touchUpInside)
        button.layer.cornerRadius = 46
        button.layer.borderColor = UIColor.gray.withAlphaComponent(0.29).cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    private let nameTextField: UITextField = CustomTextField(placeHolder: "Name")
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeHolder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let passwordRepeatTextField: UITextField = {
        let tf = CustomTextField(placeHolder: "Password repeat")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.theme.buttonColor, for: .normal)
        button.setTitle("SIGN UP".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 4
        button.setHeight(55)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(reqularText: "You have an account?  ", boldText: "Sign In")
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    @objc func didTapLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapRegister(){
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let name = nameTextField.text,
              let image = profileImage else {return}
        
        viewModel.apiRegister(email: email, password: password, name: name, image: image)
    }
    
    @objc func didTapPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
}

// MARK: - ImagePicker Delegates
extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        profileImage = selectedImage
        
        photoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        photoButton.layer.borderColor = UIColor.red.withAlphaComponent(0.58).cgColor
        photoButton.layer.masksToBounds = true
        
        self.dismiss(animated: true, completion: nil)
    }
}
