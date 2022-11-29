//
//  MessageBarView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 29.11.2022.
//

import SwiftUI

struct MessageBarView: View {
    @Binding var messageText : String
    
    var body: some View {
        
        HStack{
            // Message field
            HStack{
                TextField("", text:$messageText)
                    .disableAutocorrection(true)
                    .foregroundColor(Color(.darkGray))
                    .textFieldStyle(.plain)
            }
            .font(.headline)
            .padding(8)
            .background(
                Capsule()
                    .fill(Color.theme.appBackgroundColor)
                    .shadow(color: .gray, radius: 1)
            )
        
        }
        
        
    }
}

struct MessageBarView_Previews: PreviewProvider {
    static var previews: some View {
        MessageBarView(messageText: .constant(""))
    }
}
