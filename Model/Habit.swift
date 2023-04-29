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
    var finishedDates : [Date]
    var firstDate : Date
    
    init(
        id: String? = nil, description: String, finished: Bool, streakDays: Int,
            finishedDates: [Date],
            firstDate: Date){
            self.id = id
            self.description = description
            self.finished = finished
            self.streakDays = streakDays
            self.finishedDates = finishedDates
            self.firstDate = firstDate
        }
}



