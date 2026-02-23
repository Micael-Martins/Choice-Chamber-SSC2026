//
//  GameDialogues.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 19/02/26.
//

import Foundation

enum InGameText: Equatable {
    case null
    case tutorial
    case intro
    case beginning
    case surprise
    case adapt
    case patience
    case reward
    case danger
    case faith
    case end
    
    var text: String {
        switch self {
        case .null:
            return ""
            
        case .tutorial:
            return "Bring the choice down with a pinching gesture with your hands"
            
        case .intro:
            return "Some choices are really simple to deal with; others can be hard to make or accept."
            
        case .beginning:
            return "A choice stops being an idea the moment you commit to it"
            
        case .surprise:
            return "Some choices don’t resemble anything you’ve faced before. And you can’t immediately see where they belong."
            
        case .adapt:
            return "But we can always adapt when the unexpected happens."
            
        case .patience:
            return "When nothing feels right and your mind won’t settle, allow yourself to slow down..."
            
        case .reward:
            return "And realizing that creates space to act with courage instead of doubt."
        
        case .danger:
            return "Even when we feel like we might fall apart at any moment…"
        
        case .faith:
            return "There is no perfect set of choices. What makes the difference is that you didn’t stop."
            
        case .end:
            return "Your choices built this tower. Some were steady, others caught you by surprise. That’s how life is: context shifts, intentions waver, and still we keep deciding."
        }
    }
}
