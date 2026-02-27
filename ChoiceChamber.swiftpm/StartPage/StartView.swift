//
//  SwiftUIView.swift
//  My App
//
//  Created by Micael Martins de Moura on 21/01/26.
//

import SwiftUI

struct StartView: View {
    @Binding var route: Navigation
    
    var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            
            Color(.sceneBackground).ignoresSafeArea()
            
            GeometryReader { geo in
                let posx: CGFloat = geo.size.width
                let posy: CGFloat = geo.size.height
                
                Button {
                    soundManager.toggleMute()
                } label: {
                    Image(systemName: soundManager.isMuted ? "music.note.slash" : "music.note")
                        .foregroundColor(Color.white)
                        .font(.system(size: 56))
                        .bold()
                }.position(
                    x: posx * 0.9,
                    y: posy * 0.1
                )
                
                Image(.logo)
                    .position(x: posx * 0.5, y: posy * 0.45)

                  Text("Press to continue...")
                        .font(.title)
                        .foregroundStyle(Color.white).opacity(0.3)
                        .position(x: posx * 0.5, y: posy * 0.6)
                        
                
            }
        }.onTapGesture {
            withAnimation(.easeInOut(duration: 2)) {
                route = .Introduction
                
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    StartView(route: .constant(.StartPage))
}
