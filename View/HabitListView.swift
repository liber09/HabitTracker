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
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color.white)
                            .padding(.leading)
                        Text("Add new habit")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding([.top, .bottom, .trailing])
                    }
                    .background(Color(red: 177/256, green: 112/256, blue: 54/256))
                    .cornerRadius(40.0)
                    .alert("Lägg till", isPresented: $showingAddAlert) {
                        TextField("Lägg till", text: $newHabitDescription)
                        Button("Add", action: {
                            habitList.saveToFirestore(description: newHabitDescription,finished: false, streakDays: 1)
                            newHabitDescription = ""
                        })
                    }
                }.onAppear() {
                    habitList.listenToFirestore()
                }
            }
        }
