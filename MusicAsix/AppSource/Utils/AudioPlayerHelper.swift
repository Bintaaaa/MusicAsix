//
//  AudioPlayerHelper.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import AVFoundation

class AudioPlayerHelper {
    static let shared = AudioPlayerHelper()

    var player: AVPlayer?

    private init() { }

    func playTrack(with url: URL) {
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback)
            player =  AVPlayer(url: url)
            player?.play()
        }catch let error{
            print(error.localizedDescription)
        }
    }

    func pause() {
        player?.pause()
    }

    func togglePlayPause() {
        guard let player = player else { return }
        if player.timeControlStatus == .playing {
            pause()
        } else {
            player.play()
        }
    }
}
