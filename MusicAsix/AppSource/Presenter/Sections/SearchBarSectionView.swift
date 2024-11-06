//
//  SearchBarView.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit

class SearchBarSectionView: UIView {
     lazy var searchBar:UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
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

extension SearchBarSectionView{
    func setUpView(){
        addSubview(searchBar)
    }
    
    func setUpContraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 48.0),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
