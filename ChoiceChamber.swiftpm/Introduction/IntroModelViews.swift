//
//  File.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 27/01/26.
//

import SwiftUI

final class IntroModelViews: ObservableObject {
    
    @Published var count: Int = 0
    @Published var isVisible: Bool = true
    @Published var shape: Bool = false
    
    
    let dialogues: [DialogueText]
    
    init (dialogues: [DialogueText]) {
        self.dialogues = dialogues
    }
    
    func advanceDialogue() {
        guard count < 6 else { return }
        
        withAnimation(.easeInOut(duration: count < 1 ? 2.0 : 0.6)) {
            isVisible = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (count < 1 ? 3.0 : 0.6)) {
            if self.count < 6 {
                self.count += 1
            } else {
                // Alguma coisa no futuro
            }

            withAnimation(.easeInOut(duration: self.count < 1 ? 2.0 : 0.6)) {
                self.isVisible = true
            }
            
        }
        
    }
    
    func shapeAppear() {
        
        guard count > 2, shape == false else { return }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard self.count > 2 else { return }
                
            withAnimation(.easeInOut(duration: 2.0)) {
                    self.shape = true
            }
        }
    }
    
    func goBack() {
        if count > 0 {
            count -= 1
        }
    }
    
}

