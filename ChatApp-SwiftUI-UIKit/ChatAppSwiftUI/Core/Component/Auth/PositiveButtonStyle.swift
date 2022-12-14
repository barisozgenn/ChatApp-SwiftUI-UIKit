//
//  PositiveButtonStyle.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 27.11.2022.
//

import SwiftUI

struct PositiveButtonStyle: ButtonStyle {
    
    let scaleValue: CGFloat
    
    init(scaleValue: CGFloat) {
        self.scaleValue = scaleValue
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1)
            //.brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct PositiveButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            
        } label: {
            Text("Click Me bar")
                .withPositiveButtonModifier()
        }
        .withPositiveButtonStyle()
    }
}
