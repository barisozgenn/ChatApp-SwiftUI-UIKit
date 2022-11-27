//
//  StatusView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 26.11.2022.
//

import SwiftUI

struct StatusView: View {
    @State private var section = 0
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack(spacing: 14){
                HStack(spacing: 14){
                    Image(systemName: "person")
                        .fontWeight(.bold)
                        .frame(width: 64, height: 64)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("Baris Ozgen")
                            .font(.title)
                        Text("Hi there, I'm using ChatApp")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                    Image(systemName: "qrcode")
                        .fontWeight(.bold)
                        .frame(width: 32, height: 32)
                        .padding(4)
                        .foregroundColor(Color.theme.buttonColor)
                        .background(.gray.opacity(0.29))
                        .clipShape(Circle())
                }
                .padding(.horizontal)
                .padding(.vertical, 7)
                .background(.white)
                
                
                VStack(spacing: 1){
                    ForEach(SettingsModel.allCases.filter({$0.section == 0})) { setting in
                        VStack{
                            HStack{
                                Image(systemName: setting.image)
                                    .fontWeight(.bold)
                                    .frame(width: 32, height: 32)
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .background(Color(uiColor: setting.bgColor))
                                    .cornerRadius(4)
                                
                                Text(setting.title)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 7)
                        .background(.white)
                        
                    }
                }
                VStack(spacing: 1){
                    ForEach(SettingsModel.allCases.filter({$0.section == 1})) { setting in
                        VStack{
                            HStack{
                                Image(systemName: setting.image)
                                    .fontWeight(.bold)
                                    .frame(width: 32, height: 32)
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .background(Color(uiColor: setting.bgColor))
                                    .cornerRadius(4)
                                
                                Text(setting.title)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 7)
                        .background(.white)
                        
                    }
                }
                VStack(spacing: 1){
                    ForEach(SettingsModel.allCases.filter({$0.section == 2})) { setting in
                        VStack{
                            HStack{
                                Image(systemName: setting.image)
                                    .fontWeight(.bold)
                                    .frame(width: 32, height: 32)
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .background(Color(uiColor: setting.bgColor))
                                    .cornerRadius(4)
                                
                                Text(setting.title)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 7)
                        .background(.white)
                        
                    }
                }
               
                Spacer()
            }
            
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
