import SwiftUI

import Firebase

struct HabitDetailsView: View {
    let db = Firestore.firestore()
    var habit : Habit?
    @ObservedObject var notificationManager: NotificationManager
    @EnvironmentObject var habitsList : HabitsVM
    @StateObject private var habitList = HabitsVM()
    @State var content : String = ""
    @State var category : String = "Category"
    @State var done : Bool = false
    @State var timesAWeek : Int = 7
    @State var setReminder : Bool = true
    @State var today = Date()

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {

            VStack{
                HStack{
                
                    TextField("Name of habit: ", text: $content)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .onChange(of: content) { newValue in
                            if content.count > 60 {
                                content = String(content.prefix(60))
                            }
                        }}
                Spacer()
                
               
  
                Menu{
                    ForEach(1..<8) { number in
                        Button(action: {timesAWeek = number}, label: {
                            Text("\(number)")
                            
                        })
                    }
                    
                } label: {
                    Label(title: { Text("\(timesAWeek) Times a week") }, icon: { Image(systemName: "figure.run") })
                }
                Section{
                    
                        VStack{
                        
                            DatePicker("Daily Reminder:", selection: $today, displayedComponents: [.hourAndMinute])
                                .padding()
                                .foregroundColor(Color(red: 192/256, green:128/256,blue: 102/256))
                            
                            
                            Toggle("Set reminder", isOn: $setReminder)
                                .padding()
                                .foregroundColor(Color(red: 192/256, green:128/256,blue: 102/256))
       
                    }
                }
                .frame(width: 240, height: 140)
                .background(Color(red: 244/256, green:221/256,blue: 220/256))
                .cornerRadius(15)
                
                    Spacer()
        }
            .accentColor(Color(red: 192/256, green:128/256,blue: 102/256))
        .onAppear(perform: setContent)
        .onDisappear{notificationManager.reloadLocalNotificaitons()}
        .navigationBarTitle("Habit Detail", displayMode: .inline)
        .navigationBarItems(trailing: Button("Save"){
            if let habit = habit{
                habitList.saveHabit(habit:habit)}
            else
            {
                
                let date = Date()
                let newHabit = Habit(content: content, done: false, timesAWeek: timesAWeek, dateTracker: [],currentStreak: 0,initialDate: date)
                habitList.saveHabit(habit: newHabit)
                
                if setReminder{
                    
                    let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: today)
                    
                    guard let hour = dateComponent.hour, let minute = dateComponent.minute else{ return}
                    
                    notificationManager.createLocalNotification(title: content, hour: hour, minute: minute){
                        error in
                        if error == nil {
                            DispatchQueue.main.async {
                                print("habit saved")
                            }
                        }
                    }
                    
                }
            }
            presentationMode.wrappedValue.dismiss()
            
        })
    }
    
    private func setContent() {
        
        if let habit = habit {
            content = habit.content
            done = habit.done
            timesAWeek = habit.timesAWeek
        }
        
    }


  }

