//
//  HomeViewModel.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

protocol HomeViewModelDelegate: AnyObject {
    func didUpdateTracks(_ tracks: [MusicEntity])
    func didFailWithError(_ error: Error)
    func didUpdateNowPlaying(track: MusicEntity?)
    func didStartLoading()
}


class HomeViewModel {
    private let musicRepository: MusicRepository
    weak var delegate: HomeViewModelDelegate?

    init(musicRepository: MusicRepository) {
        self.musicRepository = musicRepository
    }

    func searchMusic(by artist: String) {
        delegate?.didStartLoading()
        musicRepository.searchMusic(by: artist) { [weak self] result in
            switch result {
            case .success(let entities):
                self?.delegate?.didUpdateTracks(entities)
            case .failure(let error):
                self?.delegate?.didFailWithError(error)
            }
        }
    }
}
