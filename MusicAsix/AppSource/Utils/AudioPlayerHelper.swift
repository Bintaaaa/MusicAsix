//
//  AudioPlayerHelper.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import AVFoundation

class AudioPlayerHelper {
    static let shared = AudioPlayerHelper()

    private var player: AVPlayer?

    private init() { }

    func playTrack(with url: URL) {
        player = AVPlayer(url: url)
        player?.play()
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
