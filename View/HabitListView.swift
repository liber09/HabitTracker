//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-23.
//

import SwiftUI

struct HabitListView: View {
    
    @StateObject var habitList = HabitList()
        @State var showingAddAlert = false
        @State var newHabitDescription = ""
    
    var body: some View {

                VStack {
                    Spacer()
                    List {
                        ForEach(habitList.habits) { habit in
                            RowView(habit: habit, vm: habitList)
                        }
                        .onDelete() { indexSet in
                            for index in indexSet {
                                habitList.delete(index: index)
                            }
                            
                        }
                    }
                    Spacer()
                    Button(action: {
                        showingAddAlert = true
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color.white)
                            .padding(.leading)
                        Text("Add new habit")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding([.top, .bottom, .trailing])
                    }
                    .background(Color(red: 20/256, green: 200/256, blue: 20/256))
                    .cornerRadius(20.0)
                    .alert("Add habit", isPresented: $showingAddAlert) {
                        TextField("Habit to track?", text: $newHabitDescription)
                        Button("Add", action: {
                            habitList.saveToFirestore(description: newHabitDescription,finished: false, streakDays: 0)
                            newHabitDescription = ""
                        })
                    }
                }.onAppear() {
                    habitList.listenToFirestore()
                }
            }
        }
