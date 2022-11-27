//
//  TextFieldSingleLineView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 27.11.2022.
//

import SwiftUI

struct TextFieldSingleLineView: View {
    @Binding var bindText : String
    var placeHolderText: String = "Search..."
    var imageSystemName: String = "magnifyingglass"
    var isSecure = false
    
    var body: some View {
        ZStack{
            HStack{
                Image(systemName: imageSystemName)
                    .foregroundColor(bindText.isEmpty ? .gray : Color.theme.buttonColor)
                
                if isSecure {
                    SecureField(placeHolderText.capitalized, text: $bindText)
                        .disableAutocorrection(true)
                        .overlay(
                            Image(systemName: "xmark.circle.fill")
                                .padding()
                                .offset(x: 14)
                                .opacity(
                                    bindText.isEmpty ?
                                    0 : 0.6)
                                .onTapGesture {
                                    UIApplication.shared.endEditing()
                                    bindText = ""
                                }
                            ,alignment: .trailing
                        )
                        .textFieldStyle(.plain)
                }
                else {
                    TextField(placeHolderText.capitalized, text: $bindText)
                        .disableAutocorrection(true)
                        .overlay(
                            Image(systemName: "xmark.circle.fill")
                                .padding()
                                .offset(x: 14)
                                .opacity(
                                    bindText.isEmpty ?
                                    0 : 0.6)
                                .onTapGesture {
                                    UIApplication.shared.endEditing()
                                    bindText = ""
                                }
                            ,alignment: .trailing
                        )
                        .textFieldStyle(.plain)
                }
            }
            .font(.headline)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(.white)
            )
            
            VStack{
                Text(placeHolderText.uppercased())
                    .font(.caption2)
                    .padding(.bottom, 36)
                    .padding(.leading, 29)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(bindText.isEmpty ? 0.0 : 1.0)
            
            VStack{
                Spacer()
                Divider()
                    .frame(height: 1)
                    .background(bindText.isEmpty ? .gray : Color.theme.buttonColor)
                    .shadow(
                        color: .black.opacity(0.14),
                        radius: 1,x: 0, y: 3
                    )
            }
            .frame(height: 60)
        }
        .foregroundColor(Color(.darkGray))
    }
}

struct TextFieldSingleLineView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldSingleLineView(bindText: .constant("jgh"))
        .padding(.horizontal)
    }
}
