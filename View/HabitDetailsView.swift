//
//  HabitDetailsView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-24.
//

import SwiftUI

struct HabitDetailsView: View {
    var body: some View {
        VStack{
            Text("Test")
                .foregroundColor(.white)
        }
    }
}

struct HabitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailsView()
        
        /*
        func addRecurringReminder(title: String, at date: Date) -> String? {
                let rem = EKReminder(eventStore: EventsCalendarManager.eventStore)
                rem.title = title
                rem.addAlarm(EKAlarm(relativeOffset: .zero))
                rem.addRecurrenceRule(EKRecurrenceRule(recurrenceWith: .daily, interval: 1, end: .none))
                rem.calendar = EventsCalendarManager.reminderCategory()
                
                let dueComponents = SharedFormatter.calendar.dateComponents([.hour,.minute,.day,.month,.year], from: date)
                rem.dueDateComponents = dueComponents
                do {
                    try EventsCalendarManager.eventStore.save(rem, commit: true)
                    return rem.calendarItemIdentifier
                } catch {
                    print(error)
                }
                return nil
           }
         */
    }
         
}
