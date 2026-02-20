//
//  ChoiceGame.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 31/01/26.
//

import SwiftUI

struct ChoiceGame: View {

    @Binding var route: Navigation
    
    @State var model = ChoiceGameModel()
    @State var finish = false
    
    var body: some View {
        ZStack {
            GeometryReader{ geo in
                let geox: CGFloat = geo.size.width
                let geoy: CGFloat = geo.size.height
                let blockSize: CGFloat = geox * 0.08
                
                Color(.sceneBackground).ignoresSafeArea()
                
                // MARK: - Labels
                if let dialogue = model.displayedDialogue {
                    Text(dialogue.text)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .bold()
                        .position(
                            x: model.placedPiecesCount != 16 ? geox * 0.5 : geox * 0.75,
                            y: model.placedPiecesCount != 16 ? geoy * 0.15 : geoy * 0.4)
                        .padding()
                        .opacity(model.isVisible ? 1.0 : 0)
                        .frame(width: model.placedPiecesCount != 16 ? 800 : 400,
                                height: 400)

                }
                
                
                    // MARK: - Tower Base
                Group {
                    Image(.base)
                        .position(x: geox * 0.5, y: geoy * 0.9)
                    
                    // MARK: Tower Grid
                    VStack(spacing: 0) {
                        ForEach((0..<model.rows).reversed(), id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<model.columns, id: \.self) { col in
                                    ZStack {
                                        Rectangle()
                                            .stroke(row < 2 ? Color.white.opacity(0.05) : Color.white.opacity(0.00) , lineWidth: 1)
                                            .frame(width: blockSize, height: blockSize)
                                        
                                        if let pieceColor = model.grid[row][col] {
                                            Rectangle()
                                                .fill(pieceColor)
                                                .frame(width: blockSize, height: blockSize)
                                                .shadow(color: pieceColor, radius: 10)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .position(
                        x: geox * 0.5,
                        y: (geoy * 0.9) - (CGFloat(model.rows) * blockSize / 2)
                    )
                }
                .offset(y: CGFloat(max(0, model.highestOccupiedRow - 2)) * blockSize)
                .animation(.spring(response: 0.8, dampingFraction: 0.8), value: model.highestOccupiedRow)
                
                // MARK: Choices Area (Topo da tela)
                if !model.isEnded {
                    HStack(spacing: geox * 0.05) {
                        ForEach(model.currentShapes) { shape in
                            DraggableShapeView(shape: shape, blockSize: blockSize) { dropLocation in
                                
                                model.handleDrop(location: dropLocation,
                                           shape: shape,
                                           blockSize: blockSize,
                                           geox: geox,
                                           geoy: geoy)
                            }
                        }
                    }
                    .position(x: geox * 0.5, y: geoy * 0.35) // Posiciona no topo
                    .zIndex(2) // Garante que as peças flutuem por cima do texto e da torre
                }
            }
        }.onChange(of: model.currentDialogue) {
            model.animateDialogue()
        }.onChange(of: finish) {
            if finish {
                withAnimation {
                    route = .StartPage
                }
            }
        }
    }
    
    
}

#Preview(traits: .landscapeLeft) {
    ChoiceGame(route: .constant(.Game))
}
