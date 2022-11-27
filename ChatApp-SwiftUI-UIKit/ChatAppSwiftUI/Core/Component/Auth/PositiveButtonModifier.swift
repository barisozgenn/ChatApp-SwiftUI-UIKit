//
//  PositiveButtonModifier.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 27.11.2022.
//

import SwiftUI

struct PositiveButtonModifier: ViewModifier {
    
    var backgroundColor : Color = Color.theme.buttonColor
    @State private var scaleValue: CGFloat = 1
    
    func body(content: Content) -> some View {
        
        content
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.vertical, 7)
            .background(backgroundColor)
            .border(backgroundColor.opacity(0.29))
            .clipShape(Capsule())
            .shadow(color: backgroundColor.opacity(0.58),radius: 3, x: 0, y: 7)
    }
}

struct PositiveButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        /*HStack{
            Text("Name")
            Image(systemName: "arrowtriangle.up.fill")
        }.modifier(PositiveButtonModifier(backgroundColor: Color.theme.buttonColor)
        )*/
        Button {
            
        } label: {
            Text("Click Me bar")
                .withPositiveButtonModifier()
        }
        .withPositiveButtonStyle()
    }
}
