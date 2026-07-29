# Choice Chamber 

An interactive narrative experience focusing on the weight and impact of human choices, proudly developed for the Swift Student Challenge 2026. 

## Concept & Motivation 🟥
This project is an attempt to express the complexities of the decision-making process in a unique, interactive format. Making choices can be daunting—it often feels like selecting one option inherently means losing another. However, this experience is designed to reflect a different perspective: these decisions, with all their trade-offs and uncertainties, are almost always the very choices that forge our true path in life.

## Overview 🟦
Choice Chamber explores decision-making through engaging interactive mechanics and a carefully crafted audiovisual atmosphere. Built entirely with SwiftUI, the project blends custom UI elements, intuitive drag-and-drop interactions, and an original soundtrack to create a seamless storytelling experience. 

## Features 🟨
* **Interactive Narrative:** Engage with thought-provoking dialogues and scenarios where your choices actively shape the outcome.
* **Custom Interactions:** Fluid drag-and-drop mechanics (`DraggableShapeView`) built natively in SwiftUI for intuitive puzzle-solving and decision execution.
* **Original Soundtrack:** Features a custom-composed theme ("A Choicefull Feeling") integrated seamlessly through a dedicated `SoundManager` for full immersion.
* **Clean Architecture:** Structured with a lightweight, custom routing system (`SimpleRouter`) to handle scene transitions and view rendering efficiently.

## Project Structure 🟪
* **Core:** Application entry point, main routing logic, and audio lifecycle management.
* **Game:** Core mechanics, state models (`ChoiceGameModel`), dialogue systems, and interactive shape views.
* **Introduction & StartPage:** Onboarding views, narrative labels, and introductory animations.
* **Resources & Assets:** Custom UI color sets, vector assets, and original audio tracks.

## Requirements 🟧
* iOS 17.0+ / iPadOS 17.0+ / macOS 14.0+
* Swift Playgrounds 4.4+ or Xcode 15.0+

## How to Run 🟩
1. Download or clone the repository.
2. Double-click `ChoiceChamber.swiftpm` to open it in **Swift Playgrounds** (Mac/iPad) or **Xcode**.
3. Build and run the project on your preferred device or simulator.

## Author ⬜️
**Micael Martins de Moura**

iOS Developer 
