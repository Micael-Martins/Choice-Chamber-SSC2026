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
    
    // MARK: Introduction Labels
    
    DialogueText(id: 1, text: "The experience was created based on the theme “Choices” and offers an interaction in which each action generates a different outcome. The shapes may change or not respond exactly to commands to make everything more playful, encouraging you to experiment with different combinations."),
    
    DialogueText(id: 2, text: "Have you ever wondered where your decisions take shape?"),
    
    DialogueText(id: 3, text: "Welcome to the Choice Chamber. This is where choices materialize, no longer mere thoughts or words, but forms you can hold and place."),
    
    DialogueText(id: 4, text: "They arrive in different forms. Some are simple, like a square. Others demand more attention to fit."),
    
    DialogueText(id: 5, text: "Your task is to choose which shape will build your tower."),
    
    DialogueText(id: 6, text: "Feel free to build it whenever you like. But once placed, a choice cannot be undone."),
    
    DialogueText(id: 7, text: "So... shall we begin?")
]



