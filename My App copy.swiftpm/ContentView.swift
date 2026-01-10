import SwiftUI

struct ContentView: View {

    @StateObject private var cameraManager = CameraManager()

    var body: some View {
        GeometryReader { geo in
            
            ZStack {
              Color.black.ignoresSafeArea()
                // area visivel de cada tela deverá ser colocada aqui
                
                if let thumb = cameraManager.thumbPoint {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .position(
                            x: (1 - thumb.x) * geo.size.width,
                            y: (1 - thumb.y) * geo.size.height
                        )
                }
                if let index = cameraManager.indexPoint {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .position(
                            x: (1 - index.x) * geo.size.width,
                            y: ( 1 - index.y) * geo.size.height
                        )
                }
            }.onAppear {
                cameraManager.start()
            }
        }
    }
}
