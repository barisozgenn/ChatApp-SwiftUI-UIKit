//
//  File.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//

import UIKit
class CustomSearchTextField: UITextField {
    
    private let searchImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "magnifyingglass")
        iv.tintColor = .gray
        iv.frame = CGRect(x: 10, y: 8, width: 18, height: 18)
        
        return iv
    }()
    
    init(placeHolder: String, frame: CGRect) {
        super.init(frame: frame)
        
        let spacer = UIView()
        spacer.setDimensions(height: frame.height, width: 35)
        spacer.addSubview(searchImageView)
        leftView = spacer
        leftViewMode = .always
        
        textColor = .gray
        //borderStyle = .roundedRect
        layer.cornerRadius = 10
        backgroundColor = .lightGray.withAlphaComponent(0.4)
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                      attributes: [.foregroundColor : UIColor.gray.withAlphaComponent(0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
