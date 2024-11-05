//
//  MusicRepository.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//


class MusicRepository {
    private let datasource: MusicRemoteDatasource
    
    init(datasource: MusicRemoteDatasource) {
        self.datasource = datasource
    }
    
    func searchMusic(by artist: String, completion: @escaping (Result<[MusicEntity], Error>) -> Void) {
        
        datasource.searchMusic(by: artist) { result in
            switch result {
            case .success(let tracks):
                
                let entities = tracks.results.map { track in
                    MusicEntity(
                        name: track.trackName ?? "-",
                        songs: track.artistName ?? "-",
                        artworlURLString: track.artworkUrl100 ?? "",
                        preview: track.previewURL ?? ""
                    )
                }
                completion(.success(entities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
