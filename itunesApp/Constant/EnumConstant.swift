//
//  EnumConstant.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 28/08/22.
//

import Foundation

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}

enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    case movie
    
    var id: String {
        self.rawValue
    }
    
    func name() -> String {
        switch self {
        case .all:
            return "All"
        case .album:
            return "Albums"
        case .song:
            return "Songs"
        case .movie:
            return "Movies"
        }
    }
}
