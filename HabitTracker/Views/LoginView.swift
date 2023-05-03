import SwiftUI
import Firebase

struct LoginView: View {
    @Binding var signedIn: Bool
    var auth = Auth.auth()
    
    var body: some View {
        Button(action: {
            auth.signInAnonymously { result, error in
                if let error {
                    print(error)
                } else {
                    signedIn = true
                }
            }
        }) {
            Text("Sign in")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    @State static private var dummySignedIn = false
    static var previews: some View {
        LoginView(signedIn: $dummySignedIn)
    }
}
