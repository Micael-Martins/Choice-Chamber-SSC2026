//
//  File.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 27/01/26.
//

struct DialogueText: Identifiable {
    let id: Int
    let text: String
}

let dialogues: [DialogueText] = [
    
    // MARK: Introduction Labels 1 - 7
    
    DialogueText(id: 1, text: "The experience was created based on the theme “Choices” and offers an interaction in which each action generates a different outcome. The shapes may change or not respond exactly to commands to make everything more playful, encouraging you to experiment with different combinations."),
    
    DialogueText(id: 2, text: "Have you ever wondered where your decisions take shape?"),
    
    DialogueText(id: 3, text: "Welcome to Choice Chamber. All the choices that arise in our lives are recorded here."),
    
    DialogueText(id: 4, text: "They arrive and take on different forms; some of them are simple, while other choices demand more attention."),
    
    DialogueText(id: 5, text: "Your task is to make a choice and take it to the base, turning it into a decision."),
    
    DialogueText(id: 6, text: "You can make different choices, but once you decide something, it’s not possible to go back."),
    
    DialogueText(id: 7, text: "So... shall we begin?")
]



