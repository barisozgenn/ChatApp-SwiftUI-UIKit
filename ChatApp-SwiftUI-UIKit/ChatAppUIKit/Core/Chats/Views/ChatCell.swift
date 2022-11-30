//
//  ChatCell.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 30.11.2022.
//


import UIKit

class ChatCell: UICollectionViewCell{
    //MARK: - Properties
    var viewModel: ChatCellViewModel? {
        didSet { setupUI() }
    }
    
    private let menuImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "circle")
        iv.tintColor = .white
        return iv
    }()
    
    private let menuImageViewBackground: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 7
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu Name".capitalized
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "".capitalized
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    private let menuDetailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "circle.fill")
        iv.tintColor = .systemBlue
        iv.layer.opacity = 0
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor =  UIColor.theme.appBackgroundColor
        
        addSubview(menuImageViewBackground)
        menuImageViewBackground.anchor(top: topAnchor,
                              left: leftAnchor,
                              paddingTop: 4,
                              paddingLeft: 4)
        menuImageViewBackground.setDimensions(height: 50, width: 50)

        menuImageViewBackground.addSubview(menuImageView)
        menuImageView.anchor(top: menuImageViewBackground.topAnchor,
                             left: menuImageViewBackground.leftAnchor,
                              paddingTop: 4,
                              paddingLeft: 4)
        menuImageView.setDimensions(height: 24, width: 24)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: menuImageView,
                           leftAnchor: menuImageView.rightAnchor,
                           paddingLeft: 29)
        addSubview(subTitleLabel)
        subTitleLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor)
        
        addSubview(menuDetailImageView)
        menuDetailImageView.centerY(inView: menuImageView,
                                    leftAnchor: rightAnchor,
                           paddingLeft: -34)
        menuDetailImageView.setDimensions(height: 24, width: 24)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func setupUI(){
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.user.name
        
        if let room = viewModel.room {
            if let lastMessage = room.messages.last {
                subTitleLabel.text = lastMessage.message
                if room.users.count == lastMessage.readers.count {
                    menuDetailImageView.layer.opacity = 1
                }
            }
        }
        
        viewModel.downloadImage {[weak self] image in
            self?.menuImageView.image = image
        }
    }
}
