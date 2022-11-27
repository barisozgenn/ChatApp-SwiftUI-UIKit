//
//  View.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 27.11.2022.
//

import SwiftUI

extension View {
    
    func withPositiveButtonModifier() -> some View {
        modifier(PositiveButtonModifier())
    }
    
    func withPositiveButtonStyle(scaleValue : CGFloat = 0.9) -> some View {
        buttonStyle(PositiveButtonStyle(scaleValue: scaleValue))
    }
}
