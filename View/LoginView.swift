//
//  LoginView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-23.
//

import SwiftUI
import FirebaseAuth


struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @Binding var signedIn : Bool
    var auth = Auth.auth()
    
    var isSignInButtonDisabled: Bool {
            [email, password].contains(where: \.isEmpty)
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                
                TextField("Email",
                          text: $email,
                           
                          prompt: Text("Email").foregroundColor(.gray)
                    
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
                    if(isValidEmail(email) && isValidPassword(password)){
                        signUp(email: email, password: password)
                    }else{
                        let alert = UIAlertController(title: "Check info",
                                                      message: "Please check email and password mus be at least 6 characters.",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK",
                                                      style: .default,
                                                      handler: { _ in
                             print("OK tap")
                        }))

                        // 3. Snow
                        present(alert, animated: true, completion: nil)
                    }
                } label: {
                    Image(systemName: "person.crop.circle.badge.plus")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .padding(.leading)
                    Text("Sign Up")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color(red: 20/256, green: 20/256, blue: 200/256))
                .cornerRadius(20)
                .padding()
                
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
    func signUp(email: String, password: String){
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailPred.evaluate(with: email)
     }
     
     func isValidPassword(_ password: String) -> Bool {
       let minPasswordLength = 6
       return password.count >= minPasswordLength
     }
}
