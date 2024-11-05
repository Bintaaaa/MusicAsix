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
    func didChangeSliderValue(to value: Float)
}


class MusicSectionView: UIView {
    
    weak var delegate: MusiSectionViewDelegate?
    
    private let nowPlayingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Now Playing"
        label.numberOfLines = 1
        return label
    }()

    private let trackArtworkImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
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
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(MusiSectionViewDelegate.self, action: #selector(didTapPrevious), for: .touchUpInside)
        return button
    }()

    private let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(MusiSectionViewDelegate.self, action: #selector(didTapPlayPause), for: .touchUpInside)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(MusiSectionViewDelegate.self, action: #selector(didTapNext), for: .touchUpInside)
        return button
    }()

    private let timeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(MusiSectionViewDelegate.self, action: #selector(didChangeSliderValue), for: .valueChanged)
        return slider
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
        delegate?.didTapPlayPause()
        togglePlayPauseIcon()
    }
    
    @objc private func didTapNext() {
        delegate?.didTapNext()
    }
    
    @objc private func didTapPrevious() {
        delegate?.didTapPrevious()
    }
    
    @objc private func didChangeSliderValue() {
        delegate?.didChangeSliderValue(to: timeSlider.value)
    }
    

    private func togglePlayPauseIcon() {
        let iconName = (playPauseButton.currentImage == UIImage(systemName: "play.fill")) ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
    

    private func setupViews() {
        addSubview(nowPlayingLabel)
        addSubview(trackArtworkImageView)
        addSubview(trackNameLabel)
        addSubview(artistNameLabel)
        addSubview(previousButton)
        addSubview(playPauseButton)
        addSubview(nextButton)
        addSubview(timeSlider)
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
            playPauseButton.topAnchor.constraint(equalTo: trackArtworkImageView.bottomAnchor, constant: 8),
            playPauseButton.widthAnchor.constraint(equalToConstant: 50),
            playPauseButton.heightAnchor.constraint(equalToConstant: 50),

            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nextButton.topAnchor.constraint(equalTo: trackArtworkImageView.bottomAnchor, constant: 8),
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            nextButton.heightAnchor.constraint(equalToConstant: 40),

            timeSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timeSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            timeSlider.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 8),
            timeSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
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
