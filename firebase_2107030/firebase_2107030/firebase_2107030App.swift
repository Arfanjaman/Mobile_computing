import SwiftUI
//import SwiftData
import Firebase


@main
struct firebase_2107030App: App {
    
    init() {
            FirebaseApp.configure()
            
            
        
        }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
 
