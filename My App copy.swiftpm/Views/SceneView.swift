//
//  SwiftUIView.swift
//  My App
//
//  Created by Micael Martins de Moura on 21/01/26.
//

import SwiftUI

struct SceneView: View {
    
    var body: some View {
        ZStack {
            Color(.sceneBackground).ignoresSafeArea()
        }
    }
}

#Preview(traits: .landscapeLeft) {
    SceneView()
}
