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
                if model.isVisible, let dialogue = model.displayedDialogue {
                    Text(dialogue.text)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .bold()
                        .position(
                            x:  !model.isEnded ? geox * 0.5 : geox * 0.75,
                            y:  !model.isEnded ? geoy * 0.15 : geoy * 0.4)
                        .padding()
                        .frame(width: !model.isEnded ? 800 : 400,
                                height: 400)
                        .transition(.opacity)
                }
                
                    // MARK: - Tower Base
                Group {
                    Image(.base)
                        .position(x: model.isEnded ? geox * 0.1 : geox * 0.5,
                                  y: model.isEnded ? geoy * 1.4 : geoy * 0.9)
                        .scaleEffect(model.isEnded ? 0.5 : 1.0)
                    
                    // MARK: Tower Grid
                    VStack(spacing: 0) {
                        ForEach((0..<model.rows).reversed(), id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<model.columns, id: \.self) { col in
                                    ZStack {
                                        Rectangle()
                                            .stroke(row < 2 && model.placedPiecesCount < 3 ? Color.white.opacity(0.05)
                                                    : Color.white.opacity(0.00) , lineWidth: 1)
                                            .frame(width: !model.isEnded ? blockSize : blockSize / 2,
                                                   height: !model.isEnded ? blockSize : blockSize / 2)
                                        
                                        if let pieceColor = model.grid[row][col] {
                                            Rectangle()
                                                .fill(pieceColor)
                                                .frame(width: !model.isEnded ? blockSize : blockSize / 2,
                                                       height: !model.isEnded ? blockSize : blockSize / 2)
                                                .shadow(color: pieceColor, radius: 4)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .position(
                        x: !model.isEnded ? geox * 0.5 : geox * 0.30,
                        y: {
                            let baseY = !model.isEnded ? geoy * 0.9 : geoy * 0.95
                            let effectiveBlockSize = !model.isEnded ? blockSize : blockSize / 2
                            let gridHeight = CGFloat(model.rows) * effectiveBlockSize
                            return baseY - gridHeight / 2
                        }()
                    )
                }
                .offset(y: !model.isEnded ? CGFloat(max(0, model.highestOccupiedRow - 2)) * blockSize : 0)
                .animation(.spring(response: !model.isEnded ? 0.8 : 2.0), value: model.highestOccupiedRow)
                
                if model.endButton && model.isEnded == false {
                    Button {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            model.isEnded = true
                        }
                    } label: {
                        Image(systemName: "minus.magnifyingglass")
                            .foregroundColor(Color.white)
                            .font(.system(size: 48))
                            .bold()
                    }.position(x: geox * 0.9, y: geoy * 0.9)
                        .transition(.scale.combined(with: .opacity))
                        .animation(.spring(response: 0.8, dampingFraction: 0.7), value: model.endButton)
                }
                
                if model.isEnded {
                    Button {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            route = .StartPage
                        }
                    } label: {
                        Image(systemName: "play.fill")
                            .foregroundColor(Color.white)
                            .font(.system(size: 48))
                            .bold()
                    }.position(x: geox * 0.9, y: geoy * 0.9)
                }
                
                // MARK: - Choices Area (Topo da tela)
                if model.placedPiecesCount <= 14 {
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
