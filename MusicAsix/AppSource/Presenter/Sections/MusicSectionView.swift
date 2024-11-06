//
//  MusicControllerViewDelegate.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//


import UIKit


protocol MusiSectionViewDelegate: AnyObject {
    func didTapPlayPause()
    func didTapNext()
    func didTapPrevious()
}


class MusicSectionView: UIView {
    
    weak var delegate: MusiSectionViewDelegate?
    
    private lazy var nowPlayingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Now Playing"
        label.numberOfLines = 1
        return label
    }()

    private lazy var trackArtworkImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(MusiSectionViewDelegate.self, action: #selector(didTapPrevious), for: .touchUpInside)
        return button
    }()

    private lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(MusiSectionViewDelegate.self, action: #selector(didTapPlayPause), for: .touchUpInside)
        return button
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(MusiSectionViewDelegate.self, action: #selector(didTapNext), for: .touchUpInside)
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc private func didTapPlayPause() {
        togglePlayPauseIcon()
    }
    
    @objc private func didTapNext() {
        iconPause()
        delegate?.didTapNext()
    }
    
    @objc private func didTapPrevious() {
        iconPause()
        delegate?.didTapPrevious()
    }
    

    private func togglePlayPauseIcon() {
        let isPlay = (playPauseButton.currentImage == UIImage(systemName: "play.fill"))
        let iconName =  isPlay ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: iconName), for: .normal)
        delegate?.didTapPlayPause()
    }
    
    private func iconPause(){
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    

    private func setupViews() {
        addSubview(nowPlayingLabel)
        addSubview(trackArtworkImageView)
        addSubview(trackNameLabel)
        addSubview(artistNameLabel)
        addSubview(previousButton)
        addSubview(playPauseButton)
        addSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nowPlayingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            nowPlayingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            nowPlayingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            
            trackArtworkImageView.topAnchor.constraint(equalTo: nowPlayingLabel.bottomAnchor, constant: 8.0),
            trackArtworkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trackArtworkImageView.widthAnchor.constraint(equalToConstant: 50),
            trackArtworkImageView.heightAnchor.constraint(equalToConstant: 50),

             trackNameLabel.leadingAnchor.constraint(equalTo: trackArtworkImageView.trailingAnchor, constant: 16),
            trackNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            trackNameLabel.topAnchor.constraint(equalTo: nowPlayingLabel.bottomAnchor, constant: 8),

            artistNameLabel.leadingAnchor.constraint(equalTo: trackArtworkImageView.trailingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),

            previousButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            previousButton.topAnchor.constraint(equalTo: trackArtworkImageView.bottomAnchor, constant: 8),
            previousButton.widthAnchor.constraint(equalToConstant: 40),
            previousButton.heightAnchor.constraint(equalToConstant: 40),

            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: previousButton.centerYAnchor),
            playPauseButton.topAnchor.constraint(equalTo: trackArtworkImageView.bottomAnchor, constant: 8),
            playPauseButton.widthAnchor.constraint(equalToConstant: 50),
            playPauseButton.heightAnchor.constraint(equalToConstant: 50),

            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nextButton.topAnchor.constraint(equalTo: trackArtworkImageView.bottomAnchor, constant: 8),
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateUI(with track: MusicEntity) {
        trackNameLabel.text = track.songs
        artistNameLabel.text = track.name
        if let imageUrlString: String = track.artworlURLString,
           let imageUrl: URL = URL(string: imageUrlString){
            trackArtworkImageView.load(url: imageUrl)
        }
        
    }
}
