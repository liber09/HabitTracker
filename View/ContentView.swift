//
//  ContentView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-22.
//

import SwiftUI
import Firebase
import FirebaseAuth



struct ContentView: View {
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    @State var signedIn = false
    @State var goToStatistics = false
    
    var body: some View {
        ZStack{
            Text("Habit Tracker")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
            Color(red: 0/256, green: 0/256, blue: 0/256)
                            .ignoresSafeArea()
                        if !isUserLoggedIn() {
                            LoginView()
                        } else {
                            HabitListView( GoToStatisticsView: $goToStatistics)
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
            Text("Streak: " + String(habit.streakDays) + " days")
            Spacer()
            Button(action: {
                vm.toggle(habit: habit)
            }
            ){
                Image(systemName: habit.finished ? "star.fill" : "star")
                    .foregroundColor(Color.yellow)
            }
        }
    }
}
