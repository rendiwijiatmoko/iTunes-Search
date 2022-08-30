//
//  SongForAlbumListViewModel.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 30/08/22.
//

import Foundation

class SongForAlbumListViewModel: ObservableObject {
    let albumID: Int
    
    @Published var songs = [Song]()
    @Published var state: FetchState = .good
    
    private let service = APIService()
    
    init(albumID: Int) {
        self.albumID = albumID
    }
    
    func fetch() {
        self.fetchSongs(for: albumID)
    }
    
    private func fetchSongs(for albumID: Int) {
        self.state = .isLoading
        service.fetchSong(for: albumID) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let results):
                    var songs = results.results
                    _ = songs.removeFirst()
                    self.songs = songs
                    self.state = .good
                    print("fetched \(results.resultCount) songs for albumID: \(albumID)")
                case .failure(let error):
                    print("could not load \(error)")
                    self.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    static func example() -> SongForAlbumListViewModel {
        let vm = SongForAlbumListViewModel(albumID: 909253)
        vm.songs = [Song.example()]
        return vm
    }
}
