//
//  AlbumModel.swift
//  iTunesSearchApp
//
//  Created by Rendi Wijiatmoko on 24/08/22.
//

import Foundation

// MARK: - AlbumResult
struct AlbumResult: Codable {
    let resultCount: Int
    let results: [Album]
}

// MARK: - Result
struct Album: Codable, Identifiable {
    let wrapperType, collectionType: String
    let artistID: Int
    let id: Int
    let amgArtistID: Int?
    let artistName, collectionName, collectionCensoredName: String
    let artistViewURL, collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright, country, currency: String
    let releaseDate: String
    let primaryGenreName: String

    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case artistID = "artistId"
        case id = "collectionId"
        case amgArtistID = "amgArtistId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName
    }
}
