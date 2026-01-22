import AVFoundation
import Vision

// Essa classe configura a camera, pode iniciar ou parar e entrega os frames para o app.
final class CameraManager: NSObject, ObservableObject {   // É uma classe do tipo final por que não pode ser herdada por outras classes.

    @Published var thumbPoint: CGPoint? = nil
    @Published var indexPoint: CGPoint? = nil
    @Published var isNext: Bool = false
    
    let session = AVCaptureSession() // instancia uma AVCaptureSession dentro de session. orquestrando os inputs e outputs
    private let videoQueue = DispatchQueue(label: "camera.video.queue") // Cria uma instância constante videoQueue. Define em qual thread os frames da camera serão entregues
   
    private let handPoseRequest: VNDetectHumanHandPoseRequest = { // Essa constante, que é do tipo VNDetectHumanHandPoseRequest, cria um request que é também do mesmo tipo, configura o máximo de mãos detectadas para um e retorna request para HandPoseRequest. Não entendo o por que desse código ser escrito dessa maneira.
        let request = VNDetectHumanHandPoseRequest()
            request.maximumHandCount = 1
            return request
        }()
    
    

    func start() { // Essa função é a responsável por iniciar a camera e também as demais funções presentes neste arquivo. Ele configura as configurações de camera feitas abaixo e diz "vai"
        print("Starting camera")
        configureSession()
        session.startRunning()
    }

    private func configureSession() { // Essa função tem como principal objetivo a configuração da camera que será usada.
        session.sessionPreset = .high // É a configuração da qualidade

        guard let camera = AVCaptureDevice.default( //Observa se a camera será aberta, se for ela ficará no molde de vídeo, com a camera frontal e eu não sei o que é o primeiro.
            .builtInWideAngleCamera,
            for: .video,
            position: .front
        ),
        let input = try? AVCaptureDeviceInput(device: camera) // Vai tentar receber como input a camera, se não conseguir, vai retornar nada a função.
        else { return }

        if session.canAddInput(input) { // Se for possível adicionar input, então adicione input? Não entendi isso também.
            session.addInput(input)
        }

        let output = AVCaptureVideoDataOutput() // Acredito que esta parte do código seja responsável por fazer o recebimento dos frames que são usados pelo vision para identificar a presença de uma mão ou não.
        output.videoSettings = [ // Configura como o output vai ser processado.
            kCVPixelBufferPixelFormatTypeKey as String:
                kCVPixelFormatType_32BGRA
        ]

        output.setSampleBufferDelegate(self, queue: videoQueue) // Faço nem ideia

        if session.canAddOutput(output) { // Se for possível ter o output, então adicione esse output a sessão?
            session.addOutput(output)
        }
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate { // Eu entendo como extensões funcionam, mas não entendi a necessidade de fazer isso aqui.
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let pixelBuffer = // Não sei o que isso faz
                CMSampleBufferGetImageBuffer(sampleBuffer)
        else { return }
        
        let handler = VNImageRequestHandler(  // Configuração do Vision para ele entender o que ele vai analisar, como e as opções?
            cvPixelBuffer: pixelBuffer,
            orientation: .down,
            options: [:]
        )
        
        do {
            try handler.perform([handPoseRequest]) // O vision tentará executar o handler VNImageRequestHandler com o handPoseRequest
            
            guard let observation = handPoseRequest.results?.first else { return } // Em observation será guardado o primeiro resultado, se houver algum, de hadPoseRequest. Se for nulo, retornará.
            
                let thumbPoints = try observation.recognizedPoints(.thumb) // Aqui ele vai pegar o dicionário de pontos do dedão
                let indexPoints = try observation.recognizedPoints(.indexFinger) // Aqui ele vai pegar o dicionário de pontos do dedo indicador
                
                guard
                    
                    let thumbTip = thumbPoints[.thumbTip], // Aqui ele vai garantir que thumbTip e indexTip tenham ambos um nível de confiança acima de 0.6, e que ambos existam. Se não ele retornará.
                    let indexTip = indexPoints[.indexTip],
                    
                        thumbTip.confidence > 0.6,
                    indexTip.confidence > 0.6
                else { return }
            
            DispatchQueue.main.async {
                self.thumbPoint = thumbTip.location
                self.indexPoint = indexTip.location
            }
                
                let dx = thumbTip.location.x - indexTip.location.x // Aqui é feita a conta que define se os dois pontos estão próximos ou não. Porém, eu não entendi a conta.
                let dy = thumbTip.location.y - indexTip.location.y
                let distance = sqrt(dx * dx + dy * dy)
                
                let pinchThreshold: CGFloat = 0.02 // Define a distância máxima para uma pinça
                
                if distance < pinchThreshold { // Se a distança entre os pontos do dedo indicador e dedão forem menor que 0.04 a pinça está fechada
                    isPressed()
                } else { // se não, está aberta.
                    isNotPressed()
                    
                }
                
            } catch { // Se o vision não conseguir ser executado, ele vem pra cá, sinalizando o que o impediu de funcionar e analisar a mão.
                print("Erro Vision: ", error)
            }
        }
    
        func isPressed() { // Fiz essa função para ser utilizada quando a pinça for realizada
            DispatchQueue.main.async {
                print("🤏 Pinça FECHADA")
                self.isNext = true
            }
        }
    
    func isNotPressed() { // E Essa quando a pinça não estiver sendo feita
        DispatchQueue.main.async {
            print("✋ Pinça ABERTA")
            self.isNext = false
        }
    }
    
    private func visionOrientation() -> CGImagePropertyOrientation {
        return .leftMirrored
    }
    }
