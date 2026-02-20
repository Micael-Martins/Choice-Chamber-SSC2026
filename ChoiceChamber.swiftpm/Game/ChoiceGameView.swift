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
                
                Color(.sceneBackground).ignoresSafeArea()
                
                // MARK: Tower Base
                Image(.base)
                    .position(x: geox * 0.5, y: geoy * 0.9)
                
                // MARK: Labels
                if let dialogue = model.displayedDialogue {
                    Text(dialogue.text)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .bold()
                        .position(
                            x: model.placedPiecesCount != 16 ? geox * 0.5 : geox * 0.75,
                            y: model.placedPiecesCount != 16 ? geoy * 0.2 : geoy * 0.4)
                        .padding()
                        .opacity(model.isVisible ? 1.0 : 0)
                        .frame(width: model.placedPiecesCount != 16 ? 800 : 400,
                                height: 400)

                }
                // MARK: Tower Grid
                
                
                Button("teste pra frente"){
                    model.placedPiecesCount += 1
                }
                
                if model.placedPiecesCount > 0 {
                    Button("teste pra trás"){
                        model.placedPiecesCount -= 1
                    }
                }
                
                if model.placedPiecesCount == 16 {
                    Button("Acabar") {
                        finish = true
                    }
                    .position(x: geox * 0.5)
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
