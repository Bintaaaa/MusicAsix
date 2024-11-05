//
//  TrackTableSectionView.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit



protocol TrackTableSectionViewDelegate: AnyObject {
    func didSelectTrack(_ track: MusicEntity)
}


class TrackTableSectionView: UIView {
    
    weak var delegate: TrackTableSectionViewDelegate?
    
    private var tracks: [MusicEntity] = []
    
     lazy var trackTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
         table.register(TrackTableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    private lazy var emptyStateLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Search to see the list of songs"
            label.textAlignment = .center
            label.textColor = .gray
            label.isHidden = true
            return label
        }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
           let indicator = UIActivityIndicatorView(style: .large)
           indicator.translatesAutoresizingMaskIntoConstraints = false
           indicator.hidesWhenStopped = true
           return indicator
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
        updateEmptyState()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTracks(_ tracks: [MusicEntity]) {
        self.tracks = tracks
        trackTableView.reloadData()
        stopLoading()
    }
    
   
}

extension TrackTableSectionView {
    func setUpView() {
        addSubview(trackTableView)
        addSubview(emptyStateLabel)
        addSubview(loadingIndicator)
        trackTableView.dataSource = self
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            trackTableView.topAnchor.constraint(equalTo: topAnchor),
            trackTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func updateEmptyState() {
        emptyStateLabel.isHidden = !tracks.isEmpty
        trackTableView.isHidden = tracks.isEmpty
    }
    
    func startLoading() {
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
            trackTableView.isHidden = true
            emptyStateLabel.isHidden = true
        }
        
    func stopLoading() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        trackTableView.isHidden = false
        emptyStateLabel.isHidden = true
    }
}

extension TrackTableSectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TrackTableViewCell else {
                   return UITableViewCell()
               }
        
        let track = tracks[indexPath.row]
        cell.configure(with: track)
        return cell
    }
}
