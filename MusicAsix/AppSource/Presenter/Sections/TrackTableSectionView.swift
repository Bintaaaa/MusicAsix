//
//  TrackTableSectionView.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit

struct Track: Decodable {
    let trackId: Int
    let trackName: String
    let artistName: String
    let image: String?
}

protocol TrackTableSectionViewDelegate: AnyObject {
    func didSelectTrack(_ track: Track)
}


class TrackTableSectionView: UIView {
    
    weak var delegate: TrackTableSectionViewDelegate?
    
    private var tracks: [Track] = []
    
     lazy var trackTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
         table.register(TrackTableViewCell.self, forCellReuseIdentifier: "Cell") // Mendaftarkan cell dengan identifier "Cell"
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTracks(_ tracks: [Track]) {
        self.tracks = tracks
        trackTableView.reloadData()
    }
    
   
}

extension TrackTableSectionView {
    func setUpView() {
        addSubview(trackTableView)
        trackTableView.dataSource = self 
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            trackTableView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            trackTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension TrackTableSectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TrackTableViewCell else {
                   return UITableViewCell()
               }
        let track = Track(trackId: 1, trackName: "Tulus", artistName: "Bijan", image:"https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/35/0f/55/350f55da-2104-162a-5872-cb35fef30410/mzi.morbeoaw.jpg/60x60bb.jpg" )
        
        cell.configure(with: track)
        delegate?.didSelectTrack(track)
        return cell
    }
}
