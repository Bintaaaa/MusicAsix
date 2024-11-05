//
//  MusicModelDTO.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//
import Foundation

struct SearchDTO: Decodable {
    let results: [MusicModelDTO]
}

struct MusicModelDTO: Codable {
    let artistID, collectionID, trackID: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewUrl: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let contentAdvisoryRating: String?
    let collectionArtistID: Int?
    let collectionArtistName: String?
}
