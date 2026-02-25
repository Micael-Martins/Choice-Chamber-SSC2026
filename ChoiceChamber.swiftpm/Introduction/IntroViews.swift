//
//  SwiftUIView.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 27/01/26.
//

import SwiftUI

struct IntroViews: View {
    
    @StateObject private var introModel = IntroModelViews(dialogues: dialogues)
    @State var square: Bool = true
    @Binding var route: Navigation

    
    
    var body: some View {

        ZStack {
            
            GeometryReader { geo in
                
                let geox: CGFloat = geo.size.width
                let geoy: CGFloat = geo.size.height
                
                let squareSize: CGFloat = geox * 0.08
                
                Color(.sceneBackground).ignoresSafeArea()
                
                // MARK: Text
                    
                    Text(introModel.dialogues[introModel.count].text)
                    .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 128)
                        .bold()
                        .frame(height: 200)
                        .opacity(introModel.isVisible ? 1.0 : 0.0)
                        .position(x: geox * 0.5, y: introModel.count > 2 ? geoy * 0.40 : geoy * 0.45)
                
                // MARK: - Shapes
                   
                    if introModel.count > 2 {
                            
                            Rectangle()
                            .frame(width: introModel.count > 3 ? squareSize/2 : squareSize,
                                   height: introModel.count > 3 ? squareSize/2 : squareSize)
                        
                                .foregroundStyle(Color.white)
                                .opacity(introModel.shape && introModel.count < 4 ? 1.0 : 0.0)
                                .position(
                                    x: introModel.count > 3 ? geox * 0.48 : geox * 0.3,
                                    y: introModel.count > 3 ? geoy * 0.569 : geoy * 0.6)
                                .animation(.spring(duration: 1.0), value: introModel.count)

                                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                                    

                                    GridRow {
                                        Rectangle()
                                            .frame(width: squareSize/2, height: squareSize/2)
                                            .opacity(introModel.count > 3 ? 1 : 0)
                                        Rectangle()
                                            .frame(width: squareSize/2, height: squareSize/2)
                    
                                    }
                                    
                                    GridRow {
                                        Rectangle()
                                            .frame(width: squareSize/2, height: squareSize/2)
                                        Rectangle()
                                            .frame(width: squareSize/2, height: squareSize/2)
                                    }
                                    
                                }
                                .foregroundStyle(introModel.count > 4 ? Color.green : Color.white)
                                .shadow(color: Color.green, radius: introModel.count > 4 ? 8 : 0)
                                .opacity(introModel.shape ? 1.0 : 0.0)
                                .position(
                                    x: introModel.count > 3 ? geox * 0.50 : geox * 0.7,
                                    y: introModel.count > 5 ? geoy * 0.85 : geoy * 0.6)
                                .animation(.spring(duration: 1.0), value: introModel.count)
                                .zIndex(1)
                        
                        // MARK: - Bottom Base
                        
                        if introModel.count > 4 {
                            Image(.base)
                                .opacity(introModel.count > 5 ? 1 : 0)
                                .position(x: geox * 0.5, y: geoy * 0.9)
                                .animation(.easeInOut(duration: 1.0), value: introModel.count)
                                .zIndex(0)
                            
                        }
                    }
                
                Button {
                    introModel.advanceDialogue()
                    } label: {
                        Image(systemName: "arrowshape.forward.fill")
                            .foregroundColor(Color.white)
                            .font(.system(size: 48))
                            .bold()
                    }.position(x: geox * 0.9, y: geoy * 0.9)
            }
            
        }.onChange(of: introModel.count) {
            introModel.shapeAppear()
            
        }
        .onAppear {
            introModel.finish = {
                withAnimation(.easeInOut(duration: 1.0)) {
                    route = .Game
                }
            }
        }
    }
}


#Preview (traits: .landscapeLeft){
    IntroViews(route: .constant(.Introduction))
}
