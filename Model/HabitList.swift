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
    
    func delete(index: Int) {
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")
        
        let habit = habits[index]
        let id = habit.id
        habitRef.document(id!).delete()
        
    }
    
    func toggle(habit: Habit) {
        guard let user = auth.currentUser else {return}
        let habitRef = db.collection("users").document(user.uid).collection("habits")
        
        let id = habit.id!
        var streakDays = habit.streakDays
        if !habit.finished{
            streakDays+=1
        }else{
            streakDays-=1
        }
        habitRef.document(id).updateData(["finished" : !habit.finished, "streakDays" : streakDays])
        
    }
    
    func saveToFirestore(description: String, finished: Bool, streakDays: Int) {
            guard let user = auth.currentUser else {return}
            let habitRef = db.collection("users").document(user.uid).collection("habits")
            
        let habit = Habit(description: description, finished: finished, streakDays: streakDays)
            
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
