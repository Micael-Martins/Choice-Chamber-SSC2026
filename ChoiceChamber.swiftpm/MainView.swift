//
//  SwiftUIView.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 31/01/26.
//

import SwiftUI

struct MainView: View {
    
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
                    .transition(.move(edge: .bottom))
                
            case .Game:
                ChoiceGame(route: $route)
                    .transition(.identity)
            }
        }
        .animation(.easeInOut(duration: 3), value: route)
    }
}

#Preview {
    MainView()
}
