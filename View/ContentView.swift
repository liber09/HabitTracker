//
//  ContentView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-22.
//

import SwiftUI
import Firebase



struct ContentView: View {
    @State var signedIn = true
    
    var body: some View {
        ZStack{
            Color(red: 0/256, green: 0/256, blue: 0/256)
                            .ignoresSafeArea()
                        
                        if !signedIn {
                            LoginView(signedIn: $signedIn)
                        } else {
                            HabitListView()
                        }
        }
    }
}

struct RowView: View {
    let habit : Habit
    let vm : HabitList
    
    var body: some View {
        HStack {
            Text(habit.description)
            Spacer()
            Button(action: {
               vm.toggle(habit: habit)
            }){
                Image(systemName: habit.finished ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
