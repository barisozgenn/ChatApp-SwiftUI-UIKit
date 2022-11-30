//
//  MessageHeaderView.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 29.11.2022.
//

import UIKit
class MessageHeaderView : UIView {
    
    //MARK: - Properties
    private let menuImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "circle")
        iv.tintColor = .white
        iv.backgroundColor = .systemGreen
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu Name".capitalized
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Lifecycle
    
    init(name:String = "baris ozgen", image: UIImage?, frameRect: CGRect){
        super.init(frame: frameRect)
        
        addSubview(menuImageView)
        let imgWidth =  frameRect.height + 7
        menuImageView.frame = CGRect(x: 0, y: 1, width: imgWidth, height: imgWidth)
        menuImageView.layer.cornerRadius = imgWidth / 2
        
        if let image = image {
            menuImageView.image = image
        }
        
        titleLabel.text = name
        addSubview(titleLabel)
        titleLabel.centerY(inView: menuImageView,
                           leftAnchor: menuImageView.rightAnchor,
                                paddingLeft: 7)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func didTapBack(){
       
    }
    
}

