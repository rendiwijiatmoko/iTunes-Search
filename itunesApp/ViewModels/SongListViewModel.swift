//
//  SongsViewModel.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 28/08/22.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var listSongs: [Song] = [Song]()
    @Published var state: FetchState = .good

    let limit: Int = 20
    var page: Int = 0
    private let service = APIService()
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
            self?.state = .good
            self?.listSongs = []
            self?.page = 0
            self?.fetchSongs(for: term)
        }.store(in: &subscriptions)
    }
    
    func fetchSongs(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        service.fetchSong(searchTerm: searchTerm, page: page, limit: limit) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    for song in result.results {
                        self.listSongs.append(song)
                    }
                    self.page += 1
                    self.state = (result.results.count == self.limit) ? .good : .loadedAll
                    print("fetched songs \(result.resultCount)")
                case .failure(let error):
                    self.state = .error("Could not load: \(error.localizedDescription)")
                    print("DEBUG-- \(error)")
                }
            }
        }
    }
    
    func loadMore() {
        fetchSongs(for: searchTerm)
    }
    
    static func example() -> SongListViewModel {
        let vm = SongListViewModel()
        vm.listSongs = [Song.example()]
        return vm
    }
}
