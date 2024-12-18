//
//  TrackTableViewCell.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit


class TrackTableViewCell: UITableViewCell {
    
    private let trackArtworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let playingIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "play.circle.fill"))
        icon.tintColor = .systemBlue
        icon.isHidden = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configure(with track: MusicEntity, isPlaying: Bool) {
        trackNameLabel.text = track.songs
        artistNameLabel.text = track.name
        playingIcon.isHidden = !isPlaying
        if let imageUrlString: String = track.artworlURLString,
           let imageUrl: URL = URL(string: imageUrlString){
            trackArtworkImageView.load(url: imageUrl)
        }
    
    }
    
}



extension TrackTableViewCell{
    
    private func setupViews() {
        contentView.addSubview(trackArtworkImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(playingIcon)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            trackArtworkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            trackArtworkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trackArtworkImageView.widthAnchor.constraint(equalToConstant: 50),
            trackArtworkImageView.heightAnchor.constraint(equalToConstant: 50),
            
            
            trackNameLabel.leadingAnchor.constraint(equalTo: trackArtworkImageView.trailingAnchor, constant: 16),
            trackNameLabel.trailingAnchor.constraint(equalTo: playingIcon.leadingAnchor, constant: -16),
            trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            
            artistNameLabel.leadingAnchor.constraint(equalTo: trackArtworkImageView.trailingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: playingIcon.leadingAnchor, constant: -16),
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            playingIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playingIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            playingIcon.widthAnchor.constraint(equalToConstant: 24),
            playingIcon.heightAnchor.constraint(equalToConstant: 24),
            
        ])
    }
    
}
