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
        let filteredHabits = habitList.habits.filter { $0.lastDate == Date() }
        HStack{
            Button {
                print("Show todays stats")
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
                    ForEach(filteredHabits) { habit in
                        RowView(habit: habit, vm: habitList)
                    }
                        
                    }
                }
        }
        
        }
    
    
    struct HabitStatisticsView_Previews: PreviewProvider {
        static var previews: some View {
            HabitStatisticsView()
        }
    }

