//
//  LoginView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 27.11.2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @Binding var isUserNotLogin: Bool

    var body: some View {
        VStack{
            headerViews
            Spacer()
                .frame(height: 92)
            Image("chat-app-logo-baris-green-border")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .padding()
            loginViews
                .padding(.horizontal)
            Spacer()
            bottomViews
        }
        .padding(.horizontal)
        .onChange(of: viewModel.isUserNotLogin) { newValue in
            withAnimation(.spring()){
                isUserNotLogin = newValue
            }
        }
    }
}

extension LoginView {
    private var headerViews: some View {
        HStack{
            VStack(alignment: .leading,spacing: 0){
                Text("Hello,")
                    .font(.title)
                    .foregroundColor(Color(.darkGray))
                    .bold()
                Text("Welcome Back")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.buttonColor)
                    .bold()
            }
            Spacer()
        }
    }
    private var loginViews: some View {
        VStack(spacing: 10){
            TextFieldSingleLineView(bindText: $email, placeHolderText: "Email", imageSystemName: "envelope.fill")
                .keyboardType(.emailAddress)
            
            TextFieldSingleLineView(bindText: $password, placeHolderText: "Password", imageSystemName: "lock.fill", isSecure: true)
            
            HStack{
                Spacer()
                NavigationLink {
                    Text("you can create password reset page")
                } label: {
                    Text("Forgot password?".capitalized)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.buttonColor)
                       
                }
                .withPositiveButtonStyle()
            }
            .padding(.vertical)
            
            Button {
                viewModel.apiLogin(email: email, password: password)
            } label: {
                Text("Sign in".capitalized)
                    .withPositiveButtonModifier()
            }
            .withPositiveButtonStyle()
        }
        .padding()
    }
    private var bottomViews: some View {
        HStack{
            NavigationLink {
                RegisterView(isUserNotLogin: $isUserNotLogin)
                    .environmentObject(viewModel)
            } label: {
                Text("Don't you have an account? Sign up.".capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.buttonColor)
                   
            }
            .withPositiveButtonStyle()
        }
        .padding(.vertical)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isUserNotLogin: .constant(true))
            .environmentObject(AuthViewModel())
    }
}
