//
//  ViewController.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Halloooo"
        title.textColor = .black
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Hello"
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }


}

