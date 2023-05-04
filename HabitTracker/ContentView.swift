import SwiftUI
import Firebase

struct ContentView: View {
    @State var signedIn = false
    var body: some View {
        if !signedIn {
            LoginView(signedIn: $signedIn)
        } else {
            HabitView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView()
    }
}
