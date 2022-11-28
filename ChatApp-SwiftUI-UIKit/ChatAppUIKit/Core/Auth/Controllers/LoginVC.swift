//
//  LoginVC.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 28.11.2022.
//
import UIKit
import RxSwift

class LoginVC: UIViewController {
    
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
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view,
                              topAnchor: view.safeAreaLayoutGuide.topAnchor,
                              paddingTop: 70)
        logoImageView.setDimensions(height: 64, width: 64)
        
        view.addSubview(headerTitleLabel)
        headerTitleLabel.centerX(inView: view,
                                 topAnchor: logoImageView.bottomAnchor,
                                 paddingTop: 14)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                       passwordTextField,
                                                       loginButton,
                                                       forgotPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        
        view.addSubview(stackView)
        stackView.anchor(top: headerTitleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 58,
                         paddingLeft: 29,
                         paddingRight: 29)
        
        view.addSubview(registerButton)
        registerButton.centerX(inView: view)
        registerButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        // textfield rx
        emailTextField.rx.text.map { $0 ?? ""}
            .bind(to: viewModel.email)
            .disposed(by: bag)
        
        passwordTextField.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.password)
            .disposed(by: bag)
        
        // button rx
        viewModel.isValid()
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: bag)
        viewModel.isValid()
            .map{$0 ? UIColor.theme.buttonColor : .gray}
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: bag)
    }
    
    // MARK: - Properties
    private var viewModel = AuthViewModel()
    private var bag = DisposeBag()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "chat-app-logo-baris-green-border")
        
        return iv
    }()
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = "ChatApp"
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        return label
    }()
    
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("SIGN IN".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 4
        button.setHeight(55)
        
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(reqularText: "Don't you have an account?  ", boldText: "Sign Up")
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(reqularText: "Forgot password?  ", boldText: "Get help signing in.")
        button.setHeight(55)
        
        button.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc func didTapRegister(){
        let viewController = RegisterVC()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func didTapForgotPassword(){
        print("DEBUG: forgot password button pressed")
    }
    
    @objc func didTapLogin(){
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {return}
        
        viewModel.apiLogin(email: email, password: password)
    }
}
