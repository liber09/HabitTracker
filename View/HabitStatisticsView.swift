//
//  HabitStatisticsView.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-04-29.
//

import SwiftUI

struct HabitStatisticsView: View {
    @StateObject var habitList = HabitList()
    
    var body: some View {
        let filteredItems = habitList.habits.filter { $0.lastDate == Date() }
    }
    
    struct HabitStatisticsView_Previews: PreviewProvider {
        static var previews: some View {
            HabitStatisticsView()
        }
    }
}
