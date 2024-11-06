//
//  DependencyContainer.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//


class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    private init() {}
    
    func makeMusicService() -> MusicRemoteDatasource {
        return MusicRemoteDatasource()
    }
    
    func makeMusicRepository() -> MusicRepository {
        return MusicRepository(datasource: makeMusicService())
    }
    
    func makeMusicViewModel() -> HomeViewModel {
        return HomeViewModel(musicRepository: makeMusicRepository())
    }
}
