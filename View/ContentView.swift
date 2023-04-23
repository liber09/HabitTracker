//
//  ContentView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-22.
//

import SwiftUI
import Firebase



struct ContentView: View {
    @State var signedIn = false
    
    var body: some View {
        ZStack{
            Color(red: 98/256, green: 108/256, blue: 62/256)
                            .ignoresSafeArea()
                        
                        if !signedIn {
                            LoginView(signedIn: $signedIn)
                        } else {
                            

                        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
