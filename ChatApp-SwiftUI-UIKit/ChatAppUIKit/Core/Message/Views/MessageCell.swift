//
//  MessageCell.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 30.11.2022.
//

import UIKit

class MessageCell: UICollectionViewCell{
    //MARK: - Properties
    var viewModel: MessageCellViewModel? {
        didSet { setupUI() }
    }
    
    private var isMine : Bool = false
    private var isRead : Bool = false
    private var isGroup : Bool = false
    
    private let imageUserView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "circle")
        iv.tintColor = .white
        iv.layer.cornerRadius = 16
        return iv
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Barış Özgen".capitalized
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .brown
        return label
    }()
    
   private lazy var backgroundUIView: UIView = {
        let uiview = UIView()
        uiview.backgroundColor = .white
        uiview.layer.cornerRadius = 14
        return uiview
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "messaga will be shown here".capitalized
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 5
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "14:29".capitalized
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()
    
    private let imageReadView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "checkmark")
        iv.tintColor = .gray
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor =  UIColor.theme.appBackgroundColor
        
        addSubview(backgroundUIView)
        addSubview(imageUserView)
        addSubview(nameLabel)
        addSubview(messageLabel)
        addSubview(dateLabel)
        addSubview(imageReadView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func setupUI(){
        guard let viewModel = viewModel else { return }
        
        dateLabel.text = viewModel.dateValue
        nameLabel.text = viewModel.nameValue
        messageLabel.text = viewModel.messageValue
        imageReadView.tintColor = viewModel.isRead ? .green : .gray
        isRead = viewModel.isRead
        isGroup = viewModel.rooomUserCount > 2 ? true : false
        isMine = viewModel.isMine
        
        backgroundUIView.backgroundColor = isMine ? UIColor.theme.balloonMineColor : UIColor.theme.balloonOtherColor
        
        let backgroundUIViewX = isMine ? frame.width - 200 : isGroup ? 36 : 0
        backgroundUIView.frame = CGRect(x: backgroundUIViewX , y: 0, width: frame.width - 100, height: 200)
        
        let nameLabelY : CGFloat = isGroup && !isMine ? 32 : 4
        nameLabel.frame = CGRect(x: backgroundUIView.frame.minX + 4 , y: nameLabelY, width: backgroundUIView.width - 8, height: backgroundUIView.height - 15)
        
        
        if !isMine && isGroup {
           
            imageUserView.frame = CGRect(x: 0, y: backgroundUIView.height - 34, width: 32, height: 32)
        }
        
        imageReadView.frame = CGRect(x: backgroundUIView.frame.maxX - 18 , y: nameLabel.frame.maxY, width: 15, height: 15)
       
        dateLabel.frame = CGRect(x: backgroundUIView.frame.maxX - 90 , y: nameLabel.frame.maxY, width: 75, height: 15)
        dateLabel.textAlignment = .right
    }
}
