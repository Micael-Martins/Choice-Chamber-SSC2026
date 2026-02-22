//
//  ChoiceGameShapes.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 19/02/26.
//

import SwiftUI

// Referência para criar as formas
struct GridPoint: Hashable {
    var x: Int  // Define a coluna
    var y: Int // Define a linha atual
}

// Produz cores aleatórias sempre com uma cor mais viva.
extension Color {
    static func random() -> Color {
        func strongSaturation() -> Double {
            Double.random(in: 0.85...1.0)
        }
        
        func strongBrightness() -> Double {
            Double.random(in: 0.9...1.0)
        }
        
        let hue = Double.random(in: 0...1)
        
        return Color(
            hue: hue,
            saturation: strongSaturation(),
            brightness: strongBrightness()
        )
    }
}

struct Shape: Identifiable {
    let id = UUID()
    var blocks: [GridPoint] // É a posição relativa dos blocos
    var color: Color
    
    static func generateTrio() -> [Shape] {
        let possibleShapes: [Shape] = [
            
            // Quadrado
            Shape(blocks: [GridPoint(x: 0, y: 0)],
                    color: Color.random()),
            
            //Retângulo de 3 de largura
            Shape(blocks: [GridPoint(x: 0, y: 0),
                           GridPoint(x: 1, y: 0),
                           GridPoint(x: 2, y: 0)],
                  color: Color.random()),
            
            // Forma L
            Shape(blocks: [GridPoint(x: 0, y: 0),
                                GridPoint(x: 0, y: 1),
                                GridPoint(x: 0, y: 2),
                                GridPoint(x: 1, y: 0)],
                    color: Color.random()),
            
            //Forma L apontando para a esquerda
            Shape(blocks: [GridPoint(x: 0, y: 0),
                           GridPoint(x: 1, y: 0),
                           GridPoint(x: 1, y: 1),
                           GridPoint(x: 1, y: 2)],
                  color: Color.random()),
            
            // Forma L de cabeça para baixo ( Direita )
            Shape(blocks: [GridPoint(x: 0, y: 0),
                           GridPoint(x: 0, y: 1),
                           GridPoint(x: 0, y: 2),
                           GridPoint(x: 1, y: 2)],
                  color: Color.random()),
            
            // Forma L de cabeça para baixo ( Esquerda )
            Shape(blocks: [GridPoint(x: 1, y: 0),
                           GridPoint(x: 1, y: 1),
                           GridPoint(x: 1, y: 2),
                           GridPoint(x: 0, y: 2)],
                  color: Color.random()),
            
            // Forma I - Vertical (pequeno)
            Shape(blocks: [GridPoint(x: 0, y: 0),
                                GridPoint(x: 0, y: 1)],
                    color: Color.random()),
            
            // Forma I - Horizontal (pequeno)
            Shape(blocks: [GridPoint(x: 0, y: 0),
                                GridPoint(x: 1, y: 0)],
                    color: Color.random()),
            
            // Forma < - Aberta para a direita
            Shape(blocks: [GridPoint(x: 0, y: 0),
                                GridPoint(x: 0, y: 1),
                                GridPoint(x: 1, y: 1)],
                    color: Color.random()),
            
            // Forma > - Aberta para a esquerda
            Shape(blocks: [GridPoint(x: 0, y: 1),
                                GridPoint(x: 1, y: 1),
                                GridPoint(x: 1, y: 0)],
                    color: Color.random()),

            // Forma < invertida (apontando para baixo)
            Shape(blocks: [GridPoint(x: 1, y: 0),
                                GridPoint(x: 0, y: 1),
                                GridPoint(x: 1, y: 1)],
                    color: Color.random()),

            // Forma > invertida (apontando para baixo)
            Shape(blocks: [GridPoint(x: 0, y: 0),
                                GridPoint(x: 0, y: 1),
                                GridPoint(x: 1, y: 1)],
                    color: Color.random()),

            // Forma S deitada, aberta para cima
            Shape(blocks: [GridPoint(x: 0, y: 0),
                                GridPoint(x: 1, y: 0),
                                GridPoint(x: 1, y: 1),
                                GridPoint(x: 2, y: 1)],
                    color: Color.random()),

            // Forma S deitada, aberta para baixo
            Shape(blocks: [GridPoint(x: 1, y: 0),
                                GridPoint(x: 2, y: 0),
                                GridPoint(x: 0, y: 1),
                                GridPoint(x: 1, y: 1)],
                    color: Color.random())
        ]
        // Retorna 3 formas
        return Array(possibleShapes.shuffled().prefix(3))
    }
}
