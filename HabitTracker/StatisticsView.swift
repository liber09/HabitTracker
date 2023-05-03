import SwiftUI

struct StatisticsView: View {
    
    @EnvironmentObject var habitList : HabitsVIewModel
    
    
    
    var body: some View {
        Text("En sammanställning av användarens utförda vanor för varje dag, vecka och månad.")
      //choose a date
        //datepicker
        //show deeds done that date
        
        
        Button(action: {}){
        Text("Show Month")
        }
    
        Button(action: {}){
        Text("Show Week")
        }
        //https://www.youtube.com/watch?v=EnNAQ-b1yPU
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
