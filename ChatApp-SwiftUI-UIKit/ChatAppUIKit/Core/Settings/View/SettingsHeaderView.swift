//
//  SettingsHeaderView.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 28.11.2022.
//

import UIKit

class SettingsHeaderView : UIView {
    
    //MARK: - Properties
    private let menuImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "circle")
        iv.tintColor = .white
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = 30
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu Name".capitalized
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello there, I'm using ChatAPP".capitalized
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let menuDetailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .center
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "qrcode")
        iv.tintColor = UIColor.theme.buttonColor
        iv.backgroundColor = .gray.withAlphaComponent(0.29)
        iv.layer.cornerRadius = 18
        return iv
    }()
    
    //MARK: - Lifecycle
    
    init(title:String = "baris ozgen", image: UIImage?, frame: CGRect){
        super.init(frame: frame)
        
        
        backgroundColor = .white
        
        
        addSubview(menuImageView)
        menuImageView.anchor(top: topAnchor,
                             left: leftAnchor,
                             paddingTop: (frame.height - 64) / 2,
                             paddingLeft: 14)
        menuImageView.setDimensions(height: 64, width: 64)
        
        if let image = image {
            menuImageView.image = image
        }
        
        
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: menuImageView.rightAnchor, paddingTop: (frame.height - 50) / 2, paddingLeft:  29)
        
        addSubview(subTitleLabel)
        subTitleLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, paddingTop: 5)
        
        addSubview(menuDetailImageView)
        menuDetailImageView.centerY(inView: menuImageView,
                                    leftAnchor: leftAnchor,
                                    paddingLeft: frame.width - 60)
        menuDetailImageView.setDimensions(height: 40, width: 40)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

