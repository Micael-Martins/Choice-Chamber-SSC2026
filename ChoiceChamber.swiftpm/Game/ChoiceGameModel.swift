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
    let columns = 3
    let rows = 40
    let maxShapes = 15
    var grid: [[Color?]]
    
    //Estado do jogo
    var currentShapes: [Shape] = []
    var placedPiecesCount: Int = 12
    var isEnded: Bool = true
    
    //Organizando textos
    var isVisible: Bool = false
    var displayedDialogue: InGameText?
    
    //MARK: Label Management
    
    var currentDialogue: InGameText {
        switch placedPiecesCount {
        case 0...1:
            return .tutorial
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
        case 2...3, 5, 7, 9, 12...13:
            return .null
        default:
            return .end
        }
    }
    
    func animateDialogue() {
        withAnimation(.easeInOut(duration: placedPiecesCount < 16 ? 0.6 : 0.0 )){
            isVisible = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.displayedDialogue = self.currentDialogue
            withAnimation(.easeInOut(duration: 0.6)){
                self.isVisible = true
            }
        }
    }
    
    //Inicializando a classe
    init() {
        self.grid = Array(repeating: Array(repeating: nil, count: columns),count : rows)
        generateNewShapes()
        self.displayedDialogue = self.currentDialogue
        self.isVisible = false
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.6)) {
                self.isVisible = true
            }
        }
    }
    
    //Atualiza as opções no topo da tela
    func generateNewShapes() {
        currentShapes = Shape.generateTrio()
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
        
        if placedPiecesCount == maxShapes {
                    isEnded = true
                } else {
                    generateNewShapes()
                }
                
                return true
    }
    
    //Valida limites de matriz e colisões
    private func canPlace(shape: Shape, at origin: GridPoint) -> Bool {
        for block in shape.blocks {
            let targetX = origin.x + block.x
            let targetY = origin.y + block.y
                        
            if targetX < 0 || targetX >= columns || targetY < 0 || targetY >= rows {
            return false
            }
                        
            if grid[targetY][targetX] != nil {
            return false
            }
        }
        return true
    }
}
