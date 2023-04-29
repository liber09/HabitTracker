//
//  HabitList.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-22.
//

import Foundation
import Firebase
import FirebaseAuth

class HabitList : ObservableObject {
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    @Published var habits = [Habit]()
    @Published var dates: [String] = []
    
    func delete(index: Int) {
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")
        
        let habit = habits[index]
        let id = habit.id
        habitRef.document(id!).delete()
        
    }
    
    func toggle(habit: Habit) {
        guard let user = auth.currentUser else {return}
        var streakDays = 0
        let habitRef = db.collection("users").document(user.uid).collection("habits").document(habit.id!)
        habitRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        if let finishedDates = data?["finishedDates"] as? [Timestamp] {
                            let today = Date()
                            let calendar = Calendar.current
                            
                            if finishedDates.contains(where: { calendar.isDate($0.dateValue(), inSameDayAs: today) }){
                                streakDays += 1}
                            
                            
                            // Check if habit was done yesterday and compute streak
                            if let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
                               finishedDates.contains(where: { calendar.isDate($0.dateValue(), inSameDayAs: yesterday) }) {
                                streakDays += 1
                                
                                // Continue checking back one day at a time
                                var currentDay = yesterday
                                while let previousDay = calendar.date(byAdding: .day, value: -1, to: currentDay),
                                      finishedDates.contains(where: { calendar.isDate($0.dateValue(), inSameDayAs: previousDay) }) {
                                    streakDays += 1
                                    currentDay = previousDay
                                }
                            }
                        }
                    } else {
                        print("Habit document does not exist")
                    }
                }
        var finishedDates = habit.finishedDates
        if !habit.finished{
            finishedDates.append(Date())
        }else{
            finishedDates.popLast()
        }
        let id = habit.id!
        habitRef.updateData(["finished" : !habit.finished, "streakDays" : streakDays,"finishedDates": finishedDates])
    }
    
    func saveToFirestore(description: String, finished: Bool, streakDays: Int, finishedDates: [Date], firstDate: Date) {
            guard let user = auth.currentUser else {return}
            let habitRef = db.collection("users").document(user.uid).collection("habits")
            
        let habit = Habit(description: description, finished: finished, streakDays: streakDays, finishedDates: finishedDates, firstDate: firstDate)
            
            do {
                 try habitRef.addDocument(from: habit)
                habits.append(habit)
            } catch {
                print("Error saving to db")
            }
        }
    
    func listenToFirestore() {
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")
        
        habitRef.addSnapshotListener() {
            snapshot, err in
            
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("error getting document \(err)")
            } else {
                self.habits.removeAll()
                for document in snapshot.documents {
                    do {
                        let habit = try document.data(as : Habit.self)
                        self.habits.append(habit)
                    } catch {
                        print("Error reading from db")
                    }
                }
            }
        }
    }
}
