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
            
        case .beginning:
            return "A choice becomes real the moment we decide."
            
        case .surprise:
            return "We don’t always know the full context of our choices. Sometimes, what once seemed right changes."
            
        case .adapt:
            return "But we can always adapt when the unexpected happens."
            
        case .patience:
            return "When nothing feels right, remember that waiting is also a choice."
            
        case .reward:
            return "And realizing that makes room for better choices."
        
        case .danger:
            return "Even when we feel like we might fall apart at any moment…"
        
        case .faith:
            return "What matters most is to never give up."
            
        case .end:
            return "Your choices built this tower. Some were steady, others caught you by surprise. That’s how life is: context shifts, intentions waver, and still we keep deciding."
        }
    }
}
