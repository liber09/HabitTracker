import SwiftUI

struct HabitView: View {
    
    @StateObject var habitsviewModel = HabitViewModel()
    @State var showingAddAlert = false
    @State var newHabitName = ""
    
    var body: some View {
        VStack {
            DatePicker("test", selection: $habitsviewModel.date, displayedComponents: .date).onChange(of: habitsviewModel.date) { date in
             habitsviewModel.setCurrentHabit(date: date)
            }
            List {
                ForEach(habitsviewModel.currentHabit) { habit in
                    RowView(habit: habit, vm: habitsviewModel)
                }
                .onDelete() { indexSet in
                    for index in indexSet {
                        HabitViewModel.deleteFromFirestore(index: index)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            Button(action: {
                showingAddAlert = true
                print("!")
            }) {
                Text("Add")
            }
            .alert("Add", isPresented: $showingAddAlert) {
                TextField("Add", text: $newHabitName)
                Button("Add", action: { habitsviewModel.saveToFirestore(habitName: newHabitName, description: "---", dateCreated: habitsviewModel.date)
                    newHabitName = ""
                })
            }
        }.onAppear() {
          habitsviewModel.listenToFirestore()
        }
    }
    
    private struct RowView: View {
        let habit: Habit
        let vm: HabitViewModel
        
        var body: some View {
            HStack {
                Text(habit.name)
                Spacer()
                Text("Latest streak: \(habit.streak)")
                Spacer()
                Button(action: {
                    vm.setFinished(habit: habit)
                }) {

                    Image(systemName: habit.finishedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: vm.date) }) ? "checkmark.square" : "square")
                
                }.buttonStyle(.borderless) //
            }
        }
    }
}


struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView()
    }
}
