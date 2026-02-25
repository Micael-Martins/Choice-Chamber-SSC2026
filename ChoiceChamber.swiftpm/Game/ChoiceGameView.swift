//
//  ChoiceGame.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 31/01/26.
//

import SwiftUI

struct ChoiceGameView: View {

    @Binding var route: Navigation
    
    @State var model = ChoiceGameModel()
    @State var finish = false
    @State private var shake: Bool = false
    
    var body: some View {
        ZStack {
            GeometryReader{ geo in
                let geox: CGFloat = geo.size.width
                let geoy: CGFloat = geo.size.height
                let blockSize: CGFloat = geox * 0.08
                
                Color(.sceneBackground).ignoresSafeArea()                .overlay(
                    RadialGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(model.placedPiecesCount == 10 ? 0.7 : 0.0)]),
                                   center: .center,
                                   startRadius: 50,
                                   endRadius: 500)
                    .animation(.easeInOut(duration: 8.0), value: model.placedPiecesCount)
                    .ignoresSafeArea()
                )
                
                // MARK: - Labels
                
                // Area destinada para a representação dos textos
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
                
                // MARK: - Tower Base + Grid (aplique shake aqui)
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
                                            .stroke(row < 40 && model.placedPiecesCount < 14 ? Color.white.opacity(0.02)
                                                    : Color.white.opacity(0.00) , lineWidth: 1)
                                            .frame(width: !model.isEnded ? blockSize : blockSize / 4,
                                                   height: !model.isEnded ? blockSize : blockSize / 4)
                                        
                                        // Método de inserção de peças na torre
                                        if let pieceColor = model.grid[row][col] {
                                            Rectangle()
                                                .fill(pieceColor)
                                                .frame(width: !model.isEnded ? blockSize : blockSize / 4,
                                                       height: !model.isEnded ? blockSize : blockSize / 4)
                                                .shadow(color: pieceColor, radius: 10)
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
                            let effectiveBlockSize = !model.isEnded ? blockSize : blockSize / 4
                            let gridHeight = CGFloat(model.rows) * effectiveBlockSize
                            return baseY - gridHeight / 2
                        }()
                    )
                }
                
                // Aplica animação quando uma nova peça é inserida na torre e ela coloca mais um nível no eixo y
                .offset(y: !model.isEnded ? CGFloat(max(0, model.highestOccupiedRow - 2)) * blockSize : 0)
                .animation(.spring(response: 2.0, dampingFraction: 0.8), value: model.highestOccupiedRow)
                
                .offset(x: shake ? 10 : -10) // valor pode ser ajustado
                
                //Faz a torre tremer quando o total de peças é 14
                .onChange(of: model.placedPiecesCount) {
                    if model.placedPiecesCount == 14 {
                       withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                           shake = true
                        }
                    } else {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            shake = false
                        }
                    }
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
                    .position(x: geox * 0.5, y: geoy * 0.4) // Posiciona no topo
                    .zIndex(2) // Garante que as peças flutuem por cima do texto e da torre
                }
                
// MARK: - Navigation Buttons
                
                if model.endButton && model.isEnded == false {
                    Button {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            model.isEnded = true
                        }
                    } label: {
                        Image(systemName: "minus.magnifyingglass")
                            .foregroundColor(Color.white)
                            .font(.system(size: 56))
                            .bold()
                    }.position(x: geox * 0.9, y: geoy * 0.9)
                        .transition(.scale.combined(with: .opacity))
                        .animation(.easeInOut(duration: 1.0), value: model.placedPiecesCount)
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
                
            }.coordinateSpace(name: "GameSpace")
        }.onChange(of: model.currentDialogue) {
            model.animateDialogue()
            }
        .onChange(of: finish) {
            if finish {
                withAnimation {
                    route = .StartPage
                }
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ChoiceGameView(route: .constant(.Game))
}

