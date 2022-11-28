//
//  Settings.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import UIKit
import RxSwift

final class SettingsVC: UIViewController {
    
    //MARK: - Properties
    private var viewModel = SettingsViewModel()
    private var bag = DisposeBag()
    
    private lazy var settingCV0: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: headerView.bottom + 10, width: view.width, height: 114),
                                  collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: "settingCell0")
        return cv
    }()
    private lazy var settingCV1: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: settingCV0.bottom + 10, width: view.width, height: 270),
                                  collectionViewLayout: layout2)
        cv.backgroundColor = .clear
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: "settingCell1")
        return cv
    }()
    private lazy var settingCV2: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: settingCV1.bottom + 10, width: view.width, height: 114),
                                  collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: "settingCell2")
        return cv
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 14.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        return layout
    }()
    
    private lazy var layout2: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 14.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        return layout
    }()
    
    private lazy var headerView: UIView = {
        let frame = CGRect(x: 0, y: navigationController?.navigationBar.bottom ?? 0, width: view.width, height: 80)
        let header = SettingsHeaderView(title: "Baris Ozgen", image: UIImage(systemName: "person.fill"), frame: frame)
        return header
    }()
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Helpers
    
    func setupUI(){
        view.backgroundColor = .systemGroupedBackground
       
        view.addSubview(headerView)
        view.addSubview(settingCV0)
        view.addSubview(settingCV1)
        view.addSubview(settingCV2)
        
        bindColletionViewData()
        
        self.navigationItem.title = navigationController?.title
    }
    
    func bindColletionViewData(){
        //section 0
        // Bind items to collection view
        viewModel.settings0.bind(
            to: settingCV0.rx
                .items(cellIdentifier: "settingCell0",
                       cellType: SettingsCell.self)){ row, item, cell in
                           cell.viewModel = item
                       }.disposed(by: bag)
        
        // Bind a model selected handler
        settingCV0.rx.modelSelected(SettingsModel.self).bind { settingModel in
            print(settingModel.title)
            self.tabBarController?.navigationItem.title = settingModel.title
            
        }.disposed(by: bag)
        
        // call fetch functions
        viewModel.fetchSectionItems(section: 0)
        
        //section 1
        // Bind items to collection view
        viewModel.settings1.bind(
            to: settingCV1.rx
                .items(cellIdentifier: "settingCell1",
                       cellType: SettingsCell.self)){ row, item, cell in
                           cell.viewModel = item
                       }.disposed(by: bag)
        
        // Bind a model selected handler
        settingCV1.rx.modelSelected(SettingsModel.self).bind { settingModel in
            print(settingModel.title)
        }.disposed(by: bag)
        
        // call fetch functions
        viewModel.fetchSectionItems(section: 1)
        
        //section 2
        // Bind items to collection view
        viewModel.settings2.bind(
            to: settingCV2.rx
                .items(cellIdentifier: "settingCell2",
                       cellType: SettingsCell.self)){ row, item, cell in
                           cell.viewModel = item
                       }.disposed(by: bag)
        
        // Bind a model selected handler
        settingCV2.rx.modelSelected(SettingsModel.self).bind { settingModel in
            print(settingModel.title)
        }.disposed(by: bag)
        
        // call fetch functions
        viewModel.fetchSectionItems(section: 2)
    }
}
