//
//  LoginView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @Binding var signedIn : Bool
    var auth = Auth.auth()
    
    var body: some View {
        Button(action: {
                    auth.signInAnonymously { result, error in
                        if let error = error {
                            print("error signing in \(error)")
                        } else {
                            signedIn = true
                        }
                    }
                }){
                    HStack{
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding(.leading)
                        Text("Sign in")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding([.top, .bottom, .trailing])
                    }
                }
                .background(Color(red: 200/256, green: 100/256, blue: 20/256))
                .cornerRadius(20.0)
    }
}
