//
//  Habit.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-22.
//

import Foundation
import FirebaseFirestoreSwift

struct Habit:Codable,Identifiable{
    @DocumentID var id : String?
    var description: String
    var finished: Bool = false
    var streakDays: Int = 0
    var latest : Data?
    
    private var unformatedDate = Date()
    private let dateFormatter = DateFormatter()
    
    init(
        id: String? = nil, description: String, finished: Bool, category: String, streakDays: Int){
            self.description = description
            self.finished = finished
            self.streakDays = streakDays
        }
    
    var date : String {
            
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: unformatedDate)
            
        }
}



