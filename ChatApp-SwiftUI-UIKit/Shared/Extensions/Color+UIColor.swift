//
//  Color+UIColor.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI

extension Color{
    static let theme = ColorTheme()
    
    struct ColorTheme{
        let balloonMineColor = Color("BalloonMineColor")
        let balloonOtherColor = Color("BalloonOtherColor")
        let buttonColor = Color("ButtonColor")
        let pageBackgroundColor = Color("PageBackgroundColor")
        let tabBarBackgroundColor = Color("TabBarBackgroundColor")
        let textFieldColor = Color("TextFieldColor")
        let appBackgroundColor = Color("AppBackgroundColor")
    }
}
extension UIColor{
    static let theme = ColorTheme()
    
    struct ColorTheme{
        let balloonMineColor = UIColor(named: "BalloonMineColor")
        let balloonOtherColor = UIColor(named: "BalloonOtherColor")
        let buttonColor = UIColor(named: "ButtonColor")
        let pageBackgroundColor = UIColor(named: "PageBackgroundColor")
        let tabBarBackgroundColor = UIColor(named: "TabBarBackgroundColor")
        let textFieldColor = UIColor(named: "TextFieldColor")
        let appBackgroundColor = UIColor(named: "AppBackgroundColor")
    }
}
