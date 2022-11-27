//
//  LoginView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 27.11.2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                headerViews
                Spacer()
                loginViews
                    .padding(.horizontal)
                Spacer()
                bottomViews
            }
            .padding(.horizontal)
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
                RegisterView()
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
        LoginView()
    }
}
