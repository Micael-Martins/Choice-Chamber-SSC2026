import AVFoundation
import Vision

final class CameraManager: NSObject {

    let session = AVCaptureSession()
    private let videoQueue = DispatchQueue(label: "camera.video.queue")

    private let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 1
        return request
    }()

    func start() {
        print("Starting camera")
        configureSession()
        session.startRunning()
    }

    private func configureSession() {
        session.sessionPreset = .high

        guard
            let camera = AVCaptureDevice.default(
                .builtInWideAngleCamera,
                for: .video,
                position: .front
            ),
            let input = try? AVCaptureDeviceInput(device: camera)
        else { return }

        if session.canAddInput(input) {
            session.addInput(input)
        }

        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String:
                kCVPixelFormatType_32BGRA
        ]

        output.setSampleBufferDelegate(self, queue: videoQueue)

        if session.canAddOutput(output) {
            session.addOutput(output)
        }
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        else { return }

        let handler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .up,
            options: [:]
        )

        do {
            try handler.perform([handPoseRequest])

            guard
                let observation = handPoseRequest.results?.first
            else { return }

            let thumbPoints = try observation.recognizedPoints(.thumb)
            let indexPoints = try observation.recognizedPoints(.indexFinger)

            guard
                let thumbTip = thumbPoints[.thumbTip],
                let indexTip = indexPoints[.indexTip],
                thumbTip.confidence > 0.6,
                indexTip.confidence > 0.6
            else { return }

            let dx = thumbTip.location.x - indexTip.location.x
            let dy = thumbTip.location.y - indexTip.location.y
            let distance = sqrt(dx * dx + dy * dy)

            let pinchThreshold: CGFloat = 0.04

            if distance < pinchThreshold {
                print("🤏 Pinça FECHADA")
            } else {
                print("✋ Pinça ABERTA")
            }

        } catch {
            print("Erro Vision:", error)
        }
    }
}
