//
//  ViewController.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    
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
            musicControllerView.heightAnchor.constraint(equalToConstant: 150) // Tinggi controller
        ])
    }
}

extension HomeViewController: UISearchBarDelegate{}

extension HomeViewController: TrackTableSectionViewDelegate{
    func didSelectTrack(_ track: Track) {
        
        let exampleTrack = Track(trackId: 1, trackName: "Example Song", artistName: "Example Artist", image: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/35/0f/55/350f55da-2104-162a-5872-cb35fef30410/mzi.morbeoaw.jpg/60x60bb.jpg")
               musicControllerView.updateUI(with: exampleTrack)
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
