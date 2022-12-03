//
//  RegisterView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 27.11.2022.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    @Environment(\.dismiss) var dismissEnvironment
    
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var selectedProfileImage: UIImage?
    @State private var profileImage: Image?

    @State private var imagePickerPresented = false
    
    @Binding var isUserNotLogin: Bool

    var body: some View {
        VStack{
            headerViews
            Spacer()
            photoView
            registerViews
                .padding(.horizontal)
            Spacer()
            Spacer()
            bottomViews
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.isUserNotLogin) { newValue in
            withAnimation(.spring()){
                isUserNotLogin = newValue
            }
        }
    }
}

extension RegisterView {
    private var headerViews: some View {
        HStack{
            VStack(alignment: .leading,spacing: 0){
                Text("Welcome,")
                    .font(.title)
                    .foregroundColor(Color(.darkGray))
                    .bold()
                Text("Create an account")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.buttonColor)
                    .bold()
            }
            Spacer()
        }
    }
    private var registerViews: some View {
        VStack(spacing: 10){
            TextFieldSingleLineView(bindText: $fullName, placeHolderText: "Name Surname", imageSystemName: "person.fill")
            
            TextFieldSingleLineView(bindText: $email, placeHolderText: "Email", imageSystemName: "envelope.fill")
                .keyboardType(.emailAddress)
            
            TextFieldSingleLineView(bindText: $password, placeHolderText: "Password", imageSystemName: "lock.fill", isSecure: true)
            
            Button {
                viewModel.apiRegister(email: email, password: password, name: fullName, image: selectedProfileImage ?? nil)
            } label: {
                Text("sign up".capitalized)
                    .withPositiveButtonModifier()
            }
            .withPositiveButtonStyle()
            .padding(.vertical)
        }
        .padding()
    }
    private var bottomViews: some View {
        HStack{
            Button {
                dismissEnvironment()
            } label: {
                Text("You have an account? Sign in.".capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.buttonColor)
                   
            }
            .withPositiveButtonStyle()
        }
        .padding(.vertical)
    }
    
    private var photoView: some View {
        VStack{
            ZStack {
                
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 92, height: 92)
                        .clipShape(Circle())
                        .padding(4)
                        .background(.white)
                        .cornerRadius(.infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(Color.theme.buttonColor,
                                        lineWidth: 4))
                }
                else {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFill()
                        .padding()
                        .frame(width: 92, height: 92)
                        .background(.white)
                        .cornerRadius(.infinity)
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(Color.theme.buttonColor,
                                        lineWidth: 4))
                    
                        .foregroundColor(.gray)
                }
                
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .padding(6)
                    .scaledToFit()
                    .background(Color.theme.buttonColor)
                    .clipShape(Circle())
                    .padding(2)
                    .background(.white)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.leading, 62)
                    .padding(.bottom, 77)
            }
            .onTapGesture {
                imagePickerPresented.toggle()
            }
            .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage) {
                ImagePicker(image: $selectedProfileImage)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 160)
    }
    
    
    func loadImage(){
        guard let selectedProfileImage = selectedProfileImage else{return}
        profileImage = Image(uiImage: selectedProfileImage)
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isUserNotLogin: .constant(true))
            .environmentObject(AuthViewModel())
    }
}
