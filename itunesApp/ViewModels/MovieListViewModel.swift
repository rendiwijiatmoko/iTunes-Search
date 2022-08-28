//
//  MovieListViewModel.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 28/08/22.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var listMovies: [Movie] = [Movie]()
    @Published var state: FetchState = .good
    
    var defaultLimits = 50
    
    private let service = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.listMovies = []
                self?.fetchMovies(for: term)
            }.store(in: &subscriptions)
    }
    
    func fetchMovies(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        service.fetchMovie(searchTerm: searchTerm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.listMovies = result.results
                    
                    if result.resultCount == self.defaultLimits {
                        self.state = .good
                    } else {
                        self.state = .loadedAll
                    }
//                    for movie in result.results {
//                        self.listMovies.append(movie)
//                    }
                    self.state =  .good
                    print("fetched \(result.resultCount)")
                case .failure(let error):
                    self.state = .error("Could not load: \(error.localizedDescription)")
                    print("DEBUG-- \(error)")
                }
            }
        }
    }
    
    func loadMore(){
        fetchMovies(for: searchTerm)
    }
}
