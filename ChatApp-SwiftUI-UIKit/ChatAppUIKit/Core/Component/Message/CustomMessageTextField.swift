//
//  CustomMessageTextField.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//


import UIKit
class CustomMessageTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let spacer = UIView()
        spacer.setDimensions(height: frame.height, width: 14)
        leftView = spacer
        leftViewMode = .always
        
        textColor = .gray
        layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = frame.height / 2
        backgroundColor = UIColor.theme.appBackgroundColor
        keyboardAppearance = .dark
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
