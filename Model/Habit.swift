//
//  Habit.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-22.
//

import Foundation
import FirebaseFirestoreSwift

struct Habit : Codable, Identifiable{
    @DocumentID var id : String?
    var description: String
    var finished: Bool = false
    var streakDays: Int = 0
    var dateTracker : [Date]
    var firstDate : Date
    
    init(
        id: String? = nil, description: String, finished: Bool, streakDays: Int,
            dateTracker: [Date],
            firstDate: Date){
            self.id = id
            self.description = description
            self.finished = finished
            self.streakDays = streakDays
            self.dateTracker = dateTracker
            self.firstDate = firstDate
        }
}



