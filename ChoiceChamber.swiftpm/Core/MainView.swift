//
//  SwiftUIView.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 31/01/26.
//

import SwiftUI

struct SceneView: View {
    
    @State private var route: Navigation = .StartPage
    
    var body: some View {
        
        ZStack {
            Color(.sceneBackground).ignoresSafeArea()
            
            switch route {
            case .StartPage:
                StartView(route: $route)
                    .transition(.opacity)
                
            case .Introduction:
                IntroViews(route: $route)
                    .transition(.opacity)
                
            case .Game:
                ChoiceGameView(route: $route)
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    SceneView()
}
