//
//  SoundManager.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 25/02/26.
//

import Foundation
import AVFoundation
import Observation

@Observable
class SoundManager {
    // Faço um singleton para facilitar o uso do manager aonde eu quiser
    static let shared = SoundManager()
    
    // player de audio
    private var backGroundMusic: AVAudioPlayer?
    
    var isMuted: Bool = false
    
    private init() {}
    
    func playBackgroundMusic(fileName: String, format: String = "mp3") {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: format) else {
            print("Error: Audio file \(fileName).\(format) not founded")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            backGroundMusic = try AVAudioPlayer(contentsOf: url)
            backGroundMusic?.numberOfLoops = -1 // Cria o loop
            backGroundMusic?.volume = isMuted ? 0 : 1
            backGroundMusic?.prepareToPlay()
            backGroundMusic?.play()
            
        } catch {
            print("Initialization Error with AVAPlayer: \(error.localizedDescription)")
        }
    }
    
    func pauseMusic() {
        backGroundMusic?.pause()
    }
    
    func toggleMute() {
        isMuted.toggle()
        
        if isMuted {
            backGroundMusic?.setVolume(0.0, fadeDuration: 0.5)
        } else {
            backGroundMusic?.setVolume(1, fadeDuration: 0.5)
        }
    }
    
}
