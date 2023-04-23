//
//  LoginView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State var name: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @Binding var signedIn : Bool
    var auth = Auth.auth()
    
    var isSignInButtonDisabled: Bool {
            [name, password].contains(where: \.isEmpty)
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                
                TextField("Name",
                          text: $name,
                           
                          prompt: Text("Login").foregroundColor(.gray)
                    
                )
                .foregroundColor(.white)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white, lineWidth: 2)
                }
                .padding(.horizontal)

                HStack {
                    Group {
                        if showPassword {
                            TextField("Password",
                                        text: $password,
                                        prompt: Text("Password").foregroundColor(.gray))
                        } else {
                            SecureField("Password",
                                        text: $password,
                                        prompt: Text("Password").foregroundColor(.gray))
                        }
                    }
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 2)
                    }

                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.white)
                    }

                }.padding(.horizontal)

                Spacer()

                Button {
                    print("do login action")
                } label: {
                    Image(systemName: "person.circle")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .padding(.leading)
                    Text("Sign In")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color(red: 20/256, green: 200/256, blue: 20/256))
                .cornerRadius(20)
                .padding()
            }
        }
}
