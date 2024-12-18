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
    
    private var trackTableBottomConstraintWithController: NSLayoutConstraint!
    private var trackTableBottomConstraintWithoutController: NSLayoutConstraint!

    
    
    private lazy var musicControllerView: MusicSectionView = {
        let controllerView = MusicSectionView(frame: .zero)
        controllerView.translatesAutoresizingMaskIntoConstraints = false
        controllerView.delegate = self
        controllerView.isHidden = true
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
        hideMusicControllerView()
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
            titleSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchSection.topAnchor.constraint(equalTo: titleSection.bottomAnchor),
            searchSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        trackTableBottomConstraintWithController = trackTableSeaction.bottomAnchor.constraint(equalTo: musicControllerView.topAnchor)
            trackTableBottomConstraintWithoutController = trackTableSeaction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

            NSLayoutConstraint.activate([
                trackTableSeaction.topAnchor.constraint(equalTo: searchSection.bottomAnchor),
                trackTableSeaction.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trackTableSeaction.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                trackTableBottomConstraintWithoutController
            ])
            
            NSLayoutConstraint.activate([
                musicControllerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                musicControllerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                musicControllerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                musicControllerView.heightAnchor.constraint(equalToConstant: 140)
            ])
    }
    
    private func hideMusicControllerView() {
        musicControllerView.isHidden = true
        trackTableBottomConstraintWithController.isActive = false
        trackTableBottomConstraintWithoutController.isActive = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    private func showMusicControllerView() {
        musicControllerView.isHidden = false
        trackTableBottomConstraintWithoutController.isActive = false
        trackTableBottomConstraintWithController.isActive = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        trackTableSeaction.updatePlayingTrack(nil)
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
    
    func didUpdateNowPlaying(track: MusicEntity?, index: Int?) {
        musicControllerView.updateUI(with: track!)
        trackTableSeaction.updatePlayingTrack(index!)
    }
    
    func didUpdateTracks(_ tracks: [MusicEntity]) {
        DispatchQueue.main.async {
            self.trackTableSeaction.setTracks(tracks)
        }
    }
}

extension HomeViewController: TrackTableSectionViewDelegate{
    func didSelectTrack(_ track: MusicEntity, index: Int) {
        showMusicControllerView()
        musicControllerView.updateUI(with: track)
        homeViewModel.selectTrack(at: index)
    }
}

extension HomeViewController: MusiSectionViewDelegate {
    func didTapPlayPause() {
        homeViewModel.playAndPause()
    }
    
    func didTapNext() {
        homeViewModel.playNext()
    }
    
    func didTapPrevious() {
        homeViewModel.playPrevious()
    }
}
