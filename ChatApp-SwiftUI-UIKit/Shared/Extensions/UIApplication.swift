//
//  UIApplication.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI
import UIKit
extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
