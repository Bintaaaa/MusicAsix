//
//  MusicEntity.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//


struct MusicEntity {
    var name: String
    var songs: String
    var artworlURLString: String?
    var previewURL: String
    var isSelected: Bool = false
    
    init(name: String, songs: String, artworlURLString: String, previewURL: String) {
        self.name = name
        self.songs = songs
        self.artworlURLString = artworlURLString
        self.previewURL = previewURL
    }
}
