//
//  SettingsViewModel.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 28.11.2022.
//

import UIKit
import RxSwift
import RxCocoa

struct SettingsViewModel {
    var settings0 = PublishSubject<[SettingsModel]>()
    var settings1 = PublishSubject<[SettingsModel]>()
    var settings2 = PublishSubject<[SettingsModel]>()
    
    func fetchSectionItems(section: Int){
        switch section {
        case 1:
            let settings = SettingsModel.allCases.filter({$0.section == 1})
            settings1.onNext(settings)
            settings1.onCompleted()
            break
        case 2:
            let settings = SettingsModel.allCases.filter({$0.section == 2})
            settings2.onNext(settings)
            settings2.onCompleted()
            break
        default:
            let settings = SettingsModel.allCases.filter({$0.section == 0})
            settings0.onNext(settings)
            settings0.onCompleted()
            break
        }
    }
}
