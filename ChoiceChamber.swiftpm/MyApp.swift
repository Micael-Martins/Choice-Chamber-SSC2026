import SwiftUI

@main
struct MyApp: App {
    @State private var route: Navigation = .StartPage
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
