import SwiftUI

struct ContentView: View {

    private let cameraManager = CameraManager()

    var body: some View {
        CameraPreviewView(session: cameraManager.session)
            .onAppear {
                cameraManager.start()
            }
    }
}
