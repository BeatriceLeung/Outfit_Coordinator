//
//  SignupView.swift
//  frontend
//
//  Created by June Qin on 3/2/25.
//

import SwiftUI

struct SignupView: View {
    let bodyBlue = Color.blue.opacity(0.7)
    @EnvironmentObject private var model: dayKitModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""

    
    private var isFormValid: Bool {
        !username.isEmpty && !password.isEmpty && (password.count >= 6 && password.count <= 10)
    }
    private func signUp() async {
        do {
            try await model.signUp(username: username, password: password)
            appState.routes.append(.login)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        VStack{
            Text("sign up!")
              .font(
                Font.custom("Nunito", size: 48)
                  .weight(.black)
              )
              .foregroundColor(.black)
            ZStack {
                Rectangle()
                    .overlay(
                        VStack{
                            Text("create account:")
                                .font(
                                    Font.custom("Nunito", size: 36)
                                        .weight(.black)
                                )
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                            VStack{
                                Text("username:")
                                    .font(
                                        Font.custom("Nunito", size: 20)
                                            .weight(.heavy)
                                    )
                                    .foregroundColor(.white)
                                    .frame(width: 163, alignment: .topLeading)
                                ZStack {
                                    TextField("", text: $username)
                                      .padding(.horizontal, 10)
                                      .frame(width: 200, height: 42)
                                      .overlay(
                                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                            .stroke(Color.white, lineWidth: 1)
                                            .fill(Color.white)
                                      )
                                      .textInputAutocapitalization(.never)
                                  }.padding(4)
                            }
                            .padding(.vertical, 5)
                            VStack{
                                Text("password:")
                                    .font(
                                        Font.custom("Nunito", size: 20)
                                            .weight(.heavy)
                                    )
                                    .foregroundColor(.white)
                                    .frame(width: 163, alignment: .topLeading)
                                ZStack {
                                    SecureField("", text: $password)
                                      .padding(.horizontal, 10)
                                      .frame(width: 200, height: 42)
                                      .overlay(
                                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                            .stroke(Color.white, lineWidth: 1)
                                            .fill(Color.white)
                                      )
                                  }.padding(4)
                            }
                            .padding(.vertical, 5)
                            
                            if !errorMessage.isEmpty {
                                            Text(errorMessage)
                                                .foregroundColor(.red)
                                                .font(.subheadline)
                                                .padding(.top, 8)
                                        }
                            
                            Button(action: {
                                Task {
                                    await signUp()
                                }
                            }) {
                                Text("submit")
                                    .font(
                                        Font.custom("Nunito", size: 20)
                                            .weight(.heavy)
                                    )
                                    .foregroundColor(.black)

                                }
                                .foregroundColor(.white)
                                .frame(width: 85, height: 32)
                                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                .cornerRadius(50)
                                .padding(.vertical, 20)
                        }
                    )
                    .foregroundColor(.clear)
                    .frame(width: 300, height: 500)
                    .background(Color(red: 0.27, green: 0.76, blue: 0.89))
                    
                
            }
            .frame(width: 300, height: 600)
            .background(.white)
        }
    }
}

#Preview {
    SignupView()
}
