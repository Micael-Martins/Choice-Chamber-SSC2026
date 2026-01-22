import SwiftUI

struct ContentView: View {

    @StateObject private var cameraManager = CameraManager()
    
    func expand(_ value: CGFloat) -> CGFloat {
        let minValue: CGFloat = 0.30
        let maxValue: CGFloat = 0.60

        let clamped = max(min(value, maxValue), minValue)
        return (clamped - minValue) / (maxValue - minValue)
    }

    var body: some View {
        ZStack {
        }
//        GeometryReader { geo in
//            ZStack {
//                
//                CameraPreviewView(session: cameraManager.session).ignoresSafeArea()
////                Color.black.ignoresSafeArea()
//
//                // Polegar
//                if let thumb = cameraManager.thumbPoint {
//                    Circle()
//                        .fill(cameraManager.isNext ? Color.red : Color.white)
//                        .frame(width: 20, height: 20)
//                        .position(
//                            x: (1 - expand(thumb.x)) * geo.size.width,
//                            y: (1 - expand(thumb.y)) * geo.size.height
//                        )
//                }
//
//                // Indicador
//                if let index = cameraManager.indexPoint {
//                    Circle()
//                        .fill(cameraManager.isNext ? Color.red : Color.white)
//                        .frame(width: 20, height: 20)
//                        .position(
//                            x: ( 1 - expand(index.x)) * geo.size.width,
//                            y: (1 - expand(index.y)) * geo.size.height
//                        )
//                }
//            }
//            .onAppear {
//                cameraManager.start()
//            }
//        }
    }
}
