//
//  SettingsCell.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 28.11.2022.
//

import UIKit

class SettingsCell: UICollectionViewCell{
    //MARK: - Properties
    var viewModel: SettingsModel? {
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
    
    private let menuDetailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .gray
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(menuImageViewBackground)
        menuImageViewBackground.anchor(top: topAnchor,
                              left: leftAnchor,
                              paddingTop: 8,
                              paddingLeft: 14)
        menuImageViewBackground.setDimensions(height: 32, width: 32)

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
        
        titleLabel.text = viewModel.title
        menuImageView.image = UIImage(systemName: viewModel.image)
        menuImageViewBackground.backgroundColor = viewModel.bgColor
    }
}
