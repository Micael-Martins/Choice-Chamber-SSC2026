//
//  SwiftUIView.swift
//  My App
//
//  Created by Micael Martins de Moura on 21/01/26.
//

import SwiftUI

struct StartView: View {
    @Binding var route: Navigation
    
    var body: some View {
        ZStack {
            
            Color(.sceneBackground).ignoresSafeArea()
            
            GeometryReader { geo in
                let posx: CGFloat = geo.size.width
                let posy: CGFloat = geo.size.height
                

                    
                    Text("Choice Chamber")
                        .font(.system(size: posx * 0.050, weight: .bold))
                        .foregroundStyle(Color.white)
                        .shadow(color: Color.white.opacity(0.2), radius: 16, x: 0, y: 0)
                        .position(x: posx * 0.5, y: posy * 0.45)

                  Text("Press to continue...")
                        .font(.title)
                        .foregroundStyle(Color.white).opacity(0.3)
                        .position(x: posx * 0.5, y: posy * 0.55)
                        
                
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
