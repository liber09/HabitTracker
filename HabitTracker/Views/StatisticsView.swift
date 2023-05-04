import SwiftUI

struct HabitStatisticsView: View {
    @EnvironmentObject var habitsList : HabitsVM
    @StateObject var habitList = HabitsVM()
    @State var goToStatistics = false
    
    var body: some View {
        var filterChoosen = ""
        let filteredHabits = habitList.habits.filter { $0.dateTracker.max() == Date() }
        let filteredHabitsWeek = habitList.habits.filter { $0.dateTracker.max() == Date() }
        let filteredHabitsMonth = habitList.habits.filter { $0.dateTracker.max() == Date() }
        
        VStack{
            Button {
                print("Show todays stats")
                filterChoosen = "day"
            } label: {
                Image(systemName: "calendar.circle")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                Text("Today")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0/256, green: 255/256, blue: 0/256))
            .cornerRadius(20)
            .padding()
            Button {
                print("Show last weeks stats")
                filterChoosen = "week"
            } label: {
                Image(systemName: "calendar.circle")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                Text("Last Week")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color(red: 255/256, green: 255/256, blue: 0/256))
            .cornerRadius(20)
            .padding()
            Button {
                print("Show last months stats")
                filterChoosen = "month"
            } label: {
                Image(systemName: "calendar.circle")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                Text("Last month")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color(red: 255/256, green: 0/256, blue: 0/256))
            .cornerRadius(20)
            .padding()
        }
    }
}
        /*
        VStack{
            List {
                if filterChoosen == "day"{
                    ForEach(filteredHabits) { habit in
                        habitsList(habit: habit, vm: habitList)
                    }
                }
                //else if filterChoosen == "week"{
                 //   ForEach(filteredHabitsWeek) { habit in
                    //    habitsList(habit: habit, vm: habitList)
                  //  }
               // }else if filterChoosen == "month"{
               //     ForEach(filteredHabitsMonth) { habit in
               //         habitsList(habit: habit, vm: habitList)
                  //  }
                }
            }
        }
    }
}
*/
