//
//  SwiftUIView.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 27/01/26.
//

import SwiftUI

struct IntroViews: View {
    
    @StateObject private var introModel = IntroModelViews(dialogues: dialogues)
    @State var rotating: Bool = false
    
    let squareSize: CGFloat = 96
    
    var body: some View {

        ZStack {
            Color(.sceneBackground).ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text(introModel.dialogues[introModel.count].text)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 128)
                    .bold()
                    .frame(height: 200)
                    .opacity(introModel.isVisible ? 1.0 : 0.0)
               

                if introModel.count <= 2 {
                    Spacer()
                }
              
                if introModel.count > 2 {
                    HStack {
                        Spacer()
                        
                        Rectangle()
                            .frame(width: squareSize, height: squareSize)
                            .foregroundStyle(Color.white)
                            .opacity(introModel.shape ? 1.0 : 0.0)
                            .rotationEffect(.degrees( rotating ? 360 : 0))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 9)
                                    .repeatForever(autoreverses: false)
                                ) {
                                    rotating = true
                                }
                            }
                        
                        if introModel.count > 2 && introModel.count < 6 {
                            Spacer()
                            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                                
// Lembrar de substituir isso aqui por componentes prontos futuramente
                                GridRow {
                                    Color.clear
                                        .frame(width: squareSize/2, height: squareSize/2)
                                    Rectangle()
                                        .frame(width: squareSize/2, height: squareSize/2)
                
                                }
                                
                                GridRow {
                                    Rectangle()
                                        .frame(width: squareSize/2, height: squareSize/2)
                                    Rectangle()
                                        .frame(width: squareSize/2, height: squareSize/2)
                                    Color.clear
                                        .frame(width: squareSize/2, height: squareSize/2)
                                }
                                
                            }
                            .foregroundStyle(Color.white)
                            .opacity(introModel.shape ? 1.0 : 0.0)
                            .rotationEffect(.degrees(rotating ? 360 : 0))
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 9)
                                    .repeatForever(autoreverses: false)
                                ) {
                                    rotating = true
                                }
                            }
//                            .padding(.horizontal)
                            
                            
                        }
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                    Button("Voltar") {
                        introModel.goBack( )
                        if introModel.count < 3 {
                            introModel.shape = false
                            rotating = false
                        }
                    }
                }
            }
        }.onTapGesture {
            introModel.advanceDialogue()
            
        }
        .onChange(of: introModel.count) {
            introModel.shapeAppear()
            
        }
    }
}


#Preview (traits: .landscapeLeft){
    IntroViews()
}
