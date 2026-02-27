//
//  ChoiceChamberModel.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 19/02/26.
//

import SwiftUI
import Observation

@Observable
class ChoiceGameModel {
    
    // Dimensões
    let columns = 5
    let rows = 40
    let maxShapes = 15
    var grid: [[Color?]]
    
    //Estado do jogo
    var currentShapes: [Shape] = []
    var placedPiecesCount: Int = 0
    var isEnded: Bool = false
    
    //Organizando textos
    var isVisible: Bool = false
    var displayedDialogue: InGameText?
    var endButton: Bool = false
    
    //MARK: Label Management
    
    var currentDialogue: InGameText {
        if isEnded {
            return .end
        }
        switch placedPiecesCount {
        case 0...1:
            return .tutorial
        case 2...3:
            return .intro
        case 4:
            return .beginning
        case 6:
            return .surprise
        case 8:
            return .adapt
        case 10:
            return .patience
        case 11:
            return .reward
        case 14:
            return .danger
        case 15:
            return .faith
        default:
            return .null
        }
    }
    
    func animateDialogue() {
        withAnimation(.easeInOut(duration: placedPiecesCount < 15 ? 0.8 : 0.0 )){
            isVisible = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.displayedDialogue = self.currentDialogue
            withAnimation(.easeInOut(duration: 0.6)){
                self.isVisible = true
            }
        }
    }
    
    //MARK: Tower Management
    
    //Inicializando a classe
    init() {
        self.grid = Array(repeating: Array(repeating: nil, count: columns),count : rows)
        generateNewShapes()
        self.displayedDialogue = self.currentDialogue
        self.isVisible = false
        self.grid[0][2] = .green
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.6)) {
                self.isVisible = true
            }
        }
    }
    
    //Atualiza as opções no topo da tela
    func generateNewShapes() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.linear(duration: 0.35)) {
                self.currentShapes = Shape.generateTrio()
            }
        }
    }
    
    func generateCrazyShapes() {
        currentShapes = Shape.generateCrazyShape()
    }
    
    //Posicionamento de peças
    func place(shape: Shape, at origin: GridPoint) -> Bool {
        guard canPlace(shape: shape, at: origin) else { return false}
        
        for block in shape.blocks {
            let targetX = origin.x + block.x
            let targetY = origin.y + block.y
            grid[targetY][targetX] = shape.color
        }
        
        placedPiecesCount += 1
        
        currentShapes = []
        
        if placedPiecesCount == maxShapes {
            endButton = true
            
        } else {
            if placedPiecesCount == 6 {
                generateCrazyShapes()
            }
            else if placedPiecesCount == 10 {
                shuffleShapesQuickly()
            }
            else {
                generateNewShapes()
            }
        }
                return true
    }
    
    // Valida limites de matriz, colisões e suporte (gravidade)
        private func canPlace(shape: Shape, at origin: GridPoint) -> Bool {
            var hasSupport = false // Rastreador para saber se a peça está apoiada
            
            for block in shape.blocks {
                let targetX = origin.x + block.x
                let targetY = origin.y + block.y
                            
                // 1. Verificação de Limites (Paredes e Teto/Chão)
                if targetX < 0 || targetX >= columns || targetY < 0 || targetY >= rows {
                    return false
                }
                            
                // 2. Verificação de Colisão (Sobreposição)
                if grid[targetY][targetX] != nil {
                    return false
                }
                
                // 3. Verificação de Suporte (Gravidade)
                // Se o bloco toca o chão (0) OU se a célula logo abaixo dele não está vazia
                if targetY == 0 {
                    hasSupport = true
                } else if grid[targetY - 1][targetX] != nil {
                    hasSupport = true
                }
            }
            
            // A peça só pode ser colocada se não colidir E tiver pelo menos um ponto de apoio
            return hasSupport
        }
    
    // Calcula a linha mais alta que possui um bloco posicionado
        var highestOccupiedRow: Int {
            for row in (0..<rows).reversed() {
                for col in 0..<columns {
                    if grid[row][col] != nil {
                        return row + 1 // +1 porque a base (linha 0) tem altura 1
                    }
                }
            }
            return 0 // Torre vazia
        }
    
    // MARK: - Funções de Apoio para a view
    func handleDrop(location: CGPoint, shape: Shape, blockSize: CGFloat, geox: CGFloat, geoy: CGFloat) {
        
        // 1. Onde a grid começa visualmente
        let gridLeftEdge = (geox * 0.5) - (CGFloat(columns) * blockSize / 2)
        
        // 2. Onde o Chão (linha 0) está visualmente agora?
        // Precisamos espelhar a matemática da câmera que fizemos no Passo 2
        let offsetRows = max(0, highestOccupiedRow - 2)
        let gridBottomEdge = (geoy * 0.9) + (CGFloat(offsetRows) * blockSize)

        // 3. Ajuste do Centro para a Quina (Facilita arredondar para a matriz)
        let blockLeftX = location.x - (blockSize / 2)
        let blockBottomY = location.y + (blockSize / 2) // O Y visual cresce para baixo
        
        // 4. 'round' age como um imã, puxando para a linha/coluna mais próxima
        let col = Int(round((blockLeftX - gridLeftEdge) / blockSize))
        let row = Int(round((gridBottomEdge - blockBottomY) / blockSize))
        
        let dropPoint = GridPoint(x: col, y: row)
        let success = place(shape: shape, at: dropPoint)
        
        if success {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
    
    func shuffleShapesQuickly(for duration: TimeInterval = 6.0) {
        let startTime = Date()
        var interval: TimeInterval = 0.005
        func shuffleStep() {
            generateNewShapes()
            interval += 0.05
            let totalTime = Date().timeIntervalSince(startTime)
            if totalTime < duration {
                DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                    shuffleStep()
                }
            }
            // Quando terminar, pode fazer outra ação se quiser
        }
        shuffleStep()
    }
    
}
