//
//  TitleSection.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit

class TitleSectionView: UILabel{
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Search Artist"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleSectionView{
    func setUpView(){
        addSubview(titleLabel)
    }
    
    func setUpContraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
        ])
    }
}
