import Foundation
import AVFoundation
import UIKit // For haptic feedback

class SoundManager: NSObject, AVAudioPlayerDelegate {
    static let shared = SoundManager()
    
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    
    // MARK: Audio functions
    func playSound(name: String, ext: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            print("Failed to find sound \(name).\(ext).")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            audioPlayers[name] = player
            player.play()
        } catch {
            print("Failed to play \(name): \(error.localizedDescription)")
        }
    }
    
    // Called by the OS when a sound finishes playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let key = audioPlayers.first(where: { $0.value == player })?.key {
            audioPlayers.removeValue(forKey: key)
        }
    }
    
    func stopAllSounds() {
        for player in audioPlayers.values {
            player.stop()
        }
        audioPlayers.removeAll()
    }
    
    // MARK: Haptic functions
    func tapHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func successHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func errorHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
