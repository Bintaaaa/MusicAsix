//
//  HomeViewModel.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didUpdateTracks(_ tracks: [MusicEntity])
    func didUpdateNowPlaying(track: MusicEntity?, index: Int?)
    func didStartLoading()
}


class HomeViewModel {
    private let musicRepository: MusicRepository
    weak var delegate: HomeViewModelDelegate?
    
    private var tracks: [MusicEntity] = []
    private var currentTrackIndex: Int? = nil
    
    init(musicRepository: MusicRepository) {
        self.musicRepository = musicRepository
    }
    
    func searchMusic(by artist: String) {
        delegate?.didStartLoading()
        musicRepository.searchMusic(by: artist) { [weak self] result in
            switch result {
            case .success(let entities):
                self?.delegate?.didUpdateTracks(entities)
                self?.tracks = entities
            case .failure(let error):
                print("failure.. \(error)")
            }
        }
    }
    
    func selectTrack(at index: Int) {
        guard index >= 0 && index < tracks.count else { return }
        currentTrackIndex = index
        let selectedTrack = tracks[index]
        playTrack(selectedTrack)
    }
    
    private func playTrack(_ track: MusicEntity) {
        delegate?.didUpdateNowPlaying(track: track, index: self.currentTrackIndex)
        guard let url = URL(string: track.previewURL) else {return}
        AudioPlayerHelper.shared.playTrack(with: url)
    }
    
    func playNext() {
        guard let currentTrackIndex = currentTrackIndex else { return }
        let nextIndex = (currentTrackIndex + 1) % tracks.count
        selectTrack(at: nextIndex)
    }
    
    func playPrevious() {
        guard let currentTrackIndex = currentTrackIndex else { return }
        let previousIndex = (currentTrackIndex - 1 + tracks.count) % tracks.count
        selectTrack(at: previousIndex)
    }
    
    func playAndPause() {
        AudioPlayerHelper.shared.togglePlayPause()
    }
}
