//
//  HabitStatisticsView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-29.
//

import SwiftUI

struct HabitStatisticsView: View {
    @StateObject var habitList = HabitList()
    @State var goToStatistics = false
    
    var body: some View {
        var filterChoosen = ""
        let filteredHabits = habitList.habits.filter { $0.lastDate == Date() }
        let filteredHabitsWeek = habitList.habits.filter { $0.lastDate == Date() }
        let filteredHabitsMonth = habitList.habits.filter { $0.lastDate == Date() }
        HStack{
            Button {
                print("Show todays stats")
                filterChoosen = "day"
            } label: {
                Image(systemName: "calendar.circle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                Text("Today")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color(red: 20/256, green: 200/256, blue: 20/256))
            .cornerRadius(20)
            .padding()
            Button {
                print("Show weekly stats")
                filterChoosen = "week"
            } label: {
                Image(systemName: "calendar.circle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                Text("Last week")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color(red: 20/256, green: 200/256, blue: 20/256))
            .cornerRadius(20)
            .padding()
            Button {
                print("Show monthly stats")
                filterChoosen = "month"
            } label: {
                Image(systemName: "calendar.circle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                Text("Last month")
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
        
        VStack{
            List {
                if filterChoosen == "day"{
                    ForEach(filteredHabits) { habit in
                        RowView(habit: habit, vm: habitList)
                    }
                    
                }else if filterChoosen == "week"{
                    ForEach(filteredHabitsWeek) { habit in
                        RowView(habit: habit, vm: habitList)
                        
                        
                    }
                    
                }else if filterChoosen == "month"{
                    ForEach(filteredHabitsMonth) { habit in
                        RowView(habit: habit, vm: habitList)
                    }
                }
                
            }
        }
        
    }
}

