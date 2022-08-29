//
//  AbumListViewModel.swift
//  iTunesSearchApp
//
//  Created by Rendi Wijiatmoko on 24/08/22.
//

import Foundation
import Combine

class AlbumListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var listAlbums: [Album] = [Album]()
    @Published var state: FetchState = .good
//    {
//        didSet {
//            print("state changed to: \(state)")
//        }
//    }
    
    let limit: Int = 20
    var page: Int = 0
    var subscriptions = Set<AnyCancellable>()
    private let service = APIService()
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.listAlbums = []
                self?.fetchAlbums(for: term)
            }.store(in: &subscriptions)
    }
    
    func loadMore(){
        fetchAlbums(for: searchTerm)
    }
    
    func fetchAlbums(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        service.fetchAlbum(searchTerm: searchTerm, page: page, limit: limit) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    for album in result.results {
                        self.listAlbums.append(album)
                    }
                    self.page += 1
                    self.state = (result.results.count == self.limit) ? .good : .loadedAll
                    print("fetched albums \(result.resultCount)")
                case .failure(let error):
                    self.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
        
//        let offset = page * limit
//        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)&offset=\(offset)") else {
//            return
//        }
//        guard let url = service.createURL(for: searchTerm) else {
//            return
//        }
//
//        print(url.absoluteString)
//        print("start featching data: \(searchTerm)")
//        state = .isLoading
//
//        service.fetch(type: AlbumResult.self, url: url) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let results):
//                    for album in result.results {
//                        self.listAlbums.append(album)
//                    }
//                    self.page += 1
//                    self.state = (result.results.count == self.limit) ? .good : .loadedAll
//                    print("fetched \(results.resultCount)")
//
//                case .failure(let error):
//                    self.state = .error("Could not load: \(error.localizedDescription)")
//                }
//            }
//        }
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("urlsession error: \(error.localizedDescription)")
//                DispatchQueue.main.async {
//                    self.state = .error("Could not load: \(error.localizedDescription)")
//                }
//            } else if let data = data {
//                do{
//                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
//                    
//                    DispatchQueue.main.async {
//                        for album in result.results {
//                            self.listAlbums.append(album)
//                        }
//                        self.page += 1
//                        
//                        self.state = (result.results.count == self.limit) ? .good : .loadedAll
//                    }
//                } catch {
//                    print("decoding error: \(error)")
//                    DispatchQueue.main.async {
//                        self.state = .error("Could not load: \(error.localizedDescription)")
//                    }
//                }
//            }
//        }.resume()
    }
    
    static func example() -> AlbumListViewModel {
        let vm = AlbumListViewModel()
        vm.listAlbums = [Album.example()]
        return vm
    }
    
}
