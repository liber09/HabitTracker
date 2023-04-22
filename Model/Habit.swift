//
//  Habit.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-22.
//

import Foundation

struct Habit:Identifiable{
    var id = UUID()
    var description: String
    var finished: Bool = false
    var category: String = ""
    var streakDays: Int
    
    private var unformatedDate = Date()
    private let dateFormatter = DateFormatter()
    
    init(
        id: String? = nil, description: String, finished: Bool, category: String, streakDays: Int){
            self.description = description
            self.finished = finished
            self.category = category
            self.streakDays = streakDays
        }
    
    var date : String {
            
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: unformatedDate)
            
        }
}



