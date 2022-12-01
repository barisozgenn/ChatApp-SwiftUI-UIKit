//
//  ChatHeaderView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 29.11.2022.
//

import SwiftUI

struct ChatHeaderView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name: String = "Barış ÖZGEN"
    @State var unread: String = "7"
    @State var imageUrl: String = "7"
    @State var image: UIImage? = UIImage(systemName: "person")
    @EnvironmentObject private var viewModel: MessageViewModel
    
    var body: some View {
            ZStack {
            }
            .frame(width: 1, height: 1)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("tapped")
                    } label: {
                        btnBack
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .background(.cyan)
                            .clipShape(Circle())
                        }
                       Text(name)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped")
                    } label: {
                        Image(systemName: "video")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("tapped")
                    } label: {
                        Image(systemName: "phone")
                    }
                }
            })
            .onAppear{
                viewModel.downloadImage(imageUrl: imageUrl) { image in
                    withAnimation(.spring()){
                        self.image = image
                    }
                }
            }
    }
}
extension ChatHeaderView {
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left")
            Text(unread)
        }
        .foregroundColor(Color.theme.buttonColor)
        .fontWeight(.semibold)
        .font(.title2)
    }
    }
}

struct ChatHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeaderView()
            .environmentObject(MessageViewModel())
    }
}
