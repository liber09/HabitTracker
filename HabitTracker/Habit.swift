import Foundation


struct Habit: Identifiable, Equatable{
    var id: ObjectIdentifier
    
    
    var content : String
    var done : Bool = false
    var category : String = ""
    var timesAWeek : Int
    var dateTracker : [Date]
    var currentStreak: Int
    var initialDate : Date
   // var setReminder : Bool = false
    
    init(id: String? = nil, content: String, done: Bool, category: String, timesAWeek: Int, dateTracker: [Date], currentStreak: Int, initialDate: Date) {
        self.content = content
        self.done = done
        self.category = category
        self.timesAWeek = timesAWeek
        self.dateTracker = dateTracker
        self.currentStreak = currentStreak
        self.initialDate = initialDate
       // self.setReminder = setReminder
    }
}
