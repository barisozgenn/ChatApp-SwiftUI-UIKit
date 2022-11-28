//
//  MainTabbarController.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import UIKit
//import Firebase

final class MainTabBarController: UITabBarController {
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        checkUserLoggedIn()
        
    }
    
    //MARK: - Properties
    
    
    //MARK: - Helpers
    
    func configureViewControllers(){
        
        let status = templateNavigationController(title: "Status", image: "circle.circle", rootViewController: StatusVC())
        let calls = templateNavigationController(title: "Calls", image: "phone", rootViewController: CallsVC())
        let communities = templateNavigationController(title: "Communities", image: "person.3", rootViewController: CommunitiesVC())
        let chats = templateNavigationController(title: "Chats", image: "message", rootViewController: ChatsVC())
        let settings = templateNavigationController(title: "Settings", image: "gear", rootViewController: SettingsVC())
        
        viewControllers = [status,calls,communities,chats,settings]
        
        tabBar.backgroundColor = UIColor.theme.tabBarBackgroundColor
        tabBar.barTintColor = .lightGray // unselected
        tabBar.tintColor = UIColor.theme.buttonColor // selected
        
        selectedViewController = viewControllers![3]
    }
    
    func templateNavigationController(title: String, image: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.title = title
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.tabBarItem.selectedImage = UIImage(systemName: "\(image).fill")
        nav.navigationBar.barStyle = .default
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationItem.largeTitleDisplayMode = .always
        nav.navigationBar.backgroundColor = UIColor.theme.tabBarBackgroundColor
        return nav
    }
    
    // MARK: - API
    func checkUserLoggedIn(){
       /* if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav =  UINavigationController(rootViewController: controller)
                nav.modalTransitionStyle = .coverVertical
                nav.modalPresentationStyle = .overFullScreen
                self.present(nav, animated: true)
            }
        }*/
    }
    
    //MARK: - Actions
    
}
