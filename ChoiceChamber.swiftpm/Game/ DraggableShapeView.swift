//
//  DraggableShapeView.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 20/02/26.
//

import SwiftUI

struct DraggableShapeView: View {
    let shape: Shape
    let blockSize: CGFloat
    var onDrop: (CGPoint) -> Void
    
    @State private var dragOffset: CGSize = .zero
    @State private var initialCenter: CGPoint = .zero
    
    @State private var isDragging: Bool = false
    
    var currentBlockSize: CGFloat {
        isDragging ? blockSize : blockSize * 0.25
    }
    
    var body: some View {
        // A base transparente que representa EXATAMENTE o bloco (0,0)
        Color.clear
            .frame(width: blockSize, height: blockSize)
            .overlay(
                // Os outros blocos são desenhados em volta deste centro
                ZStack {
                    ForEach(shape.blocks, id: \.self) { block in
                        Rectangle()
                            .fill(isDragging ? shape.color : Color.white)
                            .frame(width: currentBlockSize, height: currentBlockSize)
                            .offset(x: CGFloat(block.x) * currentBlockSize, y: CGFloat(-block.y) * currentBlockSize)
                    }
                }
            )
        // Lemos a posição global exata do bloco (0,0) ao surgir na tela
            .background(GeometryReader { geo in
                Color.clear.onAppear {
                    initialCenter = CGPoint(x: geo.frame(in: .named("GameSpace")).midX, y: geo.frame(in: .global).midY)
                }
            })
            .offset(dragOffset)
            .gesture(
                DragGesture(coordinateSpace: .named("GameSpace"))
                    .onChanged { value in
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7)) {
                            dragOffset = value.translation
                            isDragging = true
                        }
                    }
                    .onEnded { value in
                        // Calculamos o final baseado no deslocamento, ignorando onde o dedo tocou!
                        let finalCenter = CGPoint(
                            x: initialCenter.x + value.translation.width,
                            y: initialCenter.y + value.translation.height
                        )
                        onDrop(finalCenter)
                        
                        withAnimation(.spring) {
                            isDragging = false
                            dragOffset = .zero
                        }
                    }
            )
    }
}
