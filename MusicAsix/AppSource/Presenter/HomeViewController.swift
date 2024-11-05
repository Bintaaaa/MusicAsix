//
//  ViewController.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeViewModel: HomeViewModel
    
    private lazy var titleSection: TitleSectionView = {
        let header = TitleSectionView(frame: .zero)
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var searchSection: SearchBarSectionView = {
        let search = SearchBarSectionView(frame: .zero)
        search.searchBar.delegate = self
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var trackTableSeaction: TrackTableSectionView = {
        let table = TrackTableSectionView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        return table
    }()
    
    private lazy var musicControllerView: MusicSectionView = {
        let controllerView = MusicSectionView(frame: .zero)
            controllerView.translatesAutoresizingMaskIntoConstraints = false
            controllerView.delegate = self
            return controllerView
        }()
    
        init(homeViewModel: HomeViewModel) {
            self.homeViewModel = homeViewModel
            super.init(nibName: nil, bundle: nil)
            homeViewModel.delegate = self
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubView()
        setUpContrains()
    }


}

extension HomeViewController{
    func setUpSubView(){
        view.addSubview(titleSection)
        view.addSubview(searchSection)
        view.addSubview(trackTableSeaction)
        view.addSubview(musicControllerView)
    }
    
    func setUpContrains(){
        NSLayoutConstraint.activate([
            titleSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleSection.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchSection.topAnchor.constraint(equalTo: titleSection.bottomAnchor),
            searchSection.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            trackTableSeaction.topAnchor.constraint(equalTo: searchSection.bottomAnchor),
            trackTableSeaction.leftAnchor.constraint(equalTo: view.leftAnchor),
            trackTableSeaction.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trackTableSeaction.bottomAnchor.constraint(equalTo: musicControllerView.topAnchor),
            
            musicControllerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            musicControllerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            musicControllerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            musicControllerView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let artist = searchBar.text, !artist.isEmpty else{
            return
        }
        performSearch(for: artist)
        searchBar.resignFirstResponder()
    }
    func performSearch(for artist: String)  {
         homeViewModel.searchMusic(by: artist)
        }
}

extension HomeViewController: HomeViewModelDelegate{
    func didStartLoading() {
        trackTableSeaction.startLoading()
    }
    
    func didFailWithError(_ error: any Error) {
        
    }
    
    func didUpdateNowPlaying(track: MusicEntity?) {
        
    }
    
    func didUpdateTracks(_ tracks: [MusicEntity]) {
        DispatchQueue.main.async {
            self.trackTableSeaction.setTracks(tracks)
        }
    }
}

extension HomeViewController: TrackTableSectionViewDelegate{
    func didSelectTrack(_ track: MusicEntity) {
        
    }
}

extension HomeViewController: MusiSectionViewDelegate {
    func didTapPlayPause() {
        print("Play/Pause tapped")
    }

    func didTapNext() {
        print("Next tapped")
    }

    func didTapPrevious() {
        print("Previous tapped")
    }

    func didChangeSliderValue(to value: Float) {
        print("Slider value changed to: \(value)")
    }
}
