import Foundation
import Firebase

extension Date {
    var yesterday: Date {
            return Calendar.current.date(byAdding: .day, value: -1, to: self)!
        }
}


class HabitViewModel: ObservableObject {
    @Published var habits = [Habit]()
    @Published var date = Date()
    let db = Firestore.firestore()
    let auth = Auth.auth()
    @Published var currentHabit = [Habit]()
    
    
    func setFinished(habit: Habit) {
        
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")
        
        let calendar = Calendar.current
        
        var finishedDates = habit.finishedDates
        
        if let id = habit.id {
            if habit.finishedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
                let dateToDelete = habit.finishedDates.first(where: {calendar.isDate($0, inSameDayAs: date)})
                finishedDates.removeAll{ $0 == dateToDelete }
                
            } else {
                                
                finishedDates.append(date)
                finishedDates.sort()
            }
            habitRef.document(id).updateData(["finishedDates" : finishedDates])
        }
    }
    
    
    func saveToFirestore(habitName: String, description: String, dateCreated: Date) {
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")
        
        let habit = Habit(name: habitName, description: description, dateCreated: dateCreated)
        do {
            let _ = try habitRef.addDocument(from: habit)
        } catch {
            print("Error saving to db.\(error)")
        }
    }
    
    func checkStreak(habit: Habit) -> Int {

        var checkNext = true
        var currentStreak = 0
        let calendar = Calendar.current

        var yesterday = Date().yesterday
        
        while checkNext {
            if habit.finishedDates.contains(where: { calendar.isDate($0, inSameDayAs: yesterday) }) {
                yesterday = yesterday.yesterday
                currentStreak += 1
            } else {
                checkNext = false
            }
        }
        if habit.finishedDates.contains(where: { calendar.isDate($0, inSameDayAs: Date()) }) {
            currentStreak += 1
        }
        
        print("\(habit.name) \(currentStreak)")
        return currentStreak
    }
    
    func deleteDate(date: Date, habitRef: CollectionReference) {
    }
    
    
    func deleteFromFirestore(index: Int) {
        
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")
        let habit = habits[index]
        
        if let id = habit.id {
            habitRef.document(id).delete()
        }
    }
    
    func setCurrentHabit(date: Date) {
        currentHabit = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")

        for habit in habits {
            let dateCreatedString = dateFormatter.string(from: habit.dateCreated)
            let setDateString = dateFormatter.string(from: date)
            
            if dateCreatedString <= setDateString {
                currentHabit.append(habit)
                let streak = checkStreak(habit: habit)
                if let id = habit.id {
                   habitRef.document(id).updateData(["streak" : streak])
                }
            }
        }
    }
    
    
    func listenToFirestore() {
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")
        
        habitRef.addSnapshotListener() {
            snapshot, error in
            
            guard let snapshot = snapshot else {return}
            
            if let error = error {
                print("Error getting document \(error)")
            } else {
                self.habits.removeAll()
                for document in snapshot.documents {
                    do {
                        let habit = try document.data(as: Habit.self)
                        self.habits.append(habit)
                    } catch {
                        print("Error generating list \(error)")
                    }
                }
                self.setCurrentHabit(date: self.date)
            }
        }
    }
}

