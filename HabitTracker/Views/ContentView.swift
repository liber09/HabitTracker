import SwiftUI
import Firebase

struct ContentView : View {
    
    @State var signedIn = false
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
            if !signedIn {
                SignInView(signedIn: $signedIn)
                
            }else {
                HabitListView(notificationManager: notificationManager)
            }
            
        }
  //  }
}


struct SignInView : View {
    @Binding var signedIn : Bool
    var auth = Auth.auth()
    
    var body: some View {
 ZStack{
                Button(action:{
                    auth.signInAnonymously(){ result, error in
                        if let error = error {
                            print("error signing in")
                            
                        } else{
                            signedIn = true
                            
                        } }}){
                            
                            
                            Text("Sign in")
                                .foregroundColor(Color(red: 50/256, green:200/256,blue: 50/256))
                        }.buttonStyle(.bordered)
            }
        }
}

struct HabitListView: View {
    
    
    @EnvironmentObject var habitsList : HabitsVM
    @ObservedObject var notificationManager: NotificationManager
    @State var showingHabitDetails = false
    @State var selectedHabit : Habit?
    @State var showingStatistics = false
    @State var showToggle = true
    @StateObject private var habitList = HabitsVM()
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                HStack{
                    
                    List() {
                        
                        ForEach(habitList.habits) { habit in
     
                            Section{
                                
                                HStack{
                                    HabitsTextView(habit: habit)
                                    
                                    Spacer()
                                    HabitsToggleView(habit: habit)
                                        .onChange(of: habit.done) { _ in
                                habitList.streakCounter(habit: habit)
                                            habitList.listen2FS()
                                        }
                                    
                                }
                                
                                Button(action: {
                             
                                    selectedHabit = habit
                                    showingHabitDetails = true
                                    
                                }){
                                    Label("Edit", systemImage: "pencil")
                                }
                            }
                        }
                        .onDelete(){
                            indexSet in
                            for index in indexSet{
                                
                                habitList.deleteHabit(index: index)

                            }
                        }
                        
                        .navigationTitle("Habits")
                        .foregroundColor(Color(red: 244/256, green:221/256,blue: 220/256))
                        .cornerRadius(10)
                        .colorMultiply(Color(red: 244/256, green:221/256,blue: 220/256))
                        
                    }
       
                    .listStyle(InsetGroupedListStyle())
                    .onAppear(perform: notificationManager.reloadAuthorizationStatus)
                    .onChange(of: notificationManager.authorizationStatus){ authorizationStatus in
                        switch authorizationStatus {
                        case .notDetermined:
                            notificationManager.requestAuthorization()
                            
                        case .authorized:
                            
                            notificationManager.reloadLocalNotificaitons()
                            
                        default:
                            break
                            
                        }
                        
                    }
                    
                }
                VStack{
                    Button(action: {showingStatistics = true
                        
                    })
                    {
                        Text("Show Statistics")
                        
                    }
                }
                
            }
            
            .navigationTitle("Habit")
            .navigationBarItems(trailing: NavigationLink(destination: HabitDetailsView(   notificationManager: notificationManager)){
                Image(systemName: "plus.circle")
            })
        }
        .sheet(isPresented: $showingHabitDetails) {
            NavigationView {
                HabitDetailsView(habit: selectedHabit, notificationManager: notificationManager)
                    .navigationBarItems(trailing: Button("Done") {
                        self.showingHabitDetails = false
                    })
            }
        }
        .sheet(isPresented: $showingStatistics) {
            NavigationView {
           StatisticsView()
                    .navigationBarItems(trailing: Button("Back") {
                        self.showingHabitDetails = false
                    })
            }
        }
        .accentColor(Color(red: 192/256, green:128/256,blue: 102/256))
        .onAppear(){
            habitList.listen2FS()
        }
        
    }
       
}
   


struct HabitlistView: View {
    
    
    @EnvironmentObject var habitsList : HabitsVM
    @ObservedObject var notificationManager: NotificationManager
    @State var showingHabitDetails = false
    @State var selectedHabit : Habit?
    @State var showingStatistics = false
    @State var showToggle = true
    @StateObject private var _habitList = HabitsVM()
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                HStack{
                    
                    List() {
                        
                        ForEach(_habitList.habits) { habit in
     
                            Section{
                                
                                HStack{
                                    HabitsTextView(habit: habit)
                                    
                                    Spacer()
                                    HabitsToggleView(habit: habit)
                                        .onChange(of: habit.done) { _ in
                                            _habitList.streakCounter(habit: habit)
                                            _habitList.listen2FS()
                                        }
                                    
                                }
                                
                                Button(action: {
                             
                                    selectedHabit = habit
                                    showingHabitDetails = true
                                    
                                    
                                }){
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                            }
                        }
                        
                        .onDelete(){
                            indexSet in
                            for index in indexSet{
                                
                                _habitList.deleteHabit(index: index)
                                
                                
                            }
                        }
                        
                        .navigationTitle("Habits")
                        .foregroundColor(Color(red: 244/256, green:221/256,blue: 220/256))
                        .cornerRadius(10)
                        .colorMultiply(Color(red: 244/256, green:221/256,blue: 220/256))
                        
                    }
       
                    .listStyle(InsetGroupedListStyle())
                    .onAppear(perform: notificationManager.reloadAuthorizationStatus)
                    .onChange(of: notificationManager.authorizationStatus){ authorizationStatus in
                        switch authorizationStatus {
                        case .notDetermined:
                            notificationManager.requestAuthorization()
                            
                        case .authorized:
                            
                            notificationManager.reloadLocalNotificaitons()
                            
                        default:
                            break
                            
                        }
                        
                    }
                    
                }
                VStack{
                    Image("Rabbit")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Button(action: {showingStatistics = true
                        
                    })
                    {
                        Text("Statistics")
                        
                    }
                }
                
            }
            
            .navigationTitle("Habit")
            .navigationBarItems(trailing: NavigationLink(destination: HabitDetailsView(   notificationManager: notificationManager)){
                Image(systemName: "plus.circle")
            })
        }
        .sheet(isPresented: $showingHabitDetails) {
            NavigationView {
                HabitDetailsView(habit: selectedHabit, notificationManager: notificationManager)
                    .navigationBarItems(trailing: Button("Done") {
                        self.showingHabitDetails = false
                    })
            }
        }
        .sheet(isPresented: $showingStatistics) {
            NavigationView {
           StatisticsView()
                    .navigationBarItems(trailing: Button("Back") {
                        self.showingHabitDetails = false
                    })
            }
        }
        .accentColor(Color(red: 192/256, green:128/256,blue: 102/256))
        .onAppear(){
            _habitList.listen2FS()
        }
        
    }
       
}

struct HabitsTextView: View {
    let habit: Habit
    @EnvironmentObject var habitList: HabitsVM
    
    var body: some View {
    
            HStack{
                
                Text(String(habit.currentStreak))
                    .fontWeight(.semibold)

                
                Text(habit.content)
                    .foregroundColor(.black)

            }.onAppear{habitList.resetToggle(habit: habit); habitList.streakCounter(habit: habit)}
    }
    }


struct HabitsToggleView: View {
    let habit: Habit
    
    @EnvironmentObject var habitList: HabitsVM
    var body: some View {
        Button(action: {
            habitList.toggle(habit: habit)
        
            
        }) {
            Image(systemName: habit.done ? "checkmark.seal.fill" : "seal" )
                .foregroundColor(Color(red: 192/256, green:128/256,blue: 102/256))
            
        }
        
       
    }
    
}
