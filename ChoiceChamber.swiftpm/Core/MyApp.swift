import SwiftUI

@main
struct MyApp: App {
    @State private var route: Navigation = .StartPage
    
    var body: some Scene {
        WindowGroup {
            SceneView()
                .onAppear{
                    SoundManager.shared.playBackgroundMusic(fileName: "a_Choicefull_felling")
                }
        }
    }
}
