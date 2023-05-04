import SwiftUI

struct StatisticsView: View {
    
    @EnvironmentObject var habitList : HabitsVM
    
    
    var body: some View {
        Text("Users habit count per day, week or month")
      
    
        Button(action: {}){
        Text("Show Month")
        }
    
        Button(action: {}){
        Text("Show Week")
        }
        
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
