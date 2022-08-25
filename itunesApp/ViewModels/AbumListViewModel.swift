//
//  AbumListViewModel.swift
//  iTunesSearchApp
//
//  Created by Rendi Wijiatmoko on 24/08/22.
//

import Foundation
import Combine

class AlbumListViewModel: ObservableObject {
    
    enum State: Comparable {
        case good
        case isLoading
        case loadedAll
        case error(String)
    }
    
    enum EntityType: String {
        case album
        case song
        case movie
    }
    
    @Published var searchTerm: String = ""
    @Published var listAlbums: [Album] = [Album]()
    @Published var state: State = .good {
        didSet {
            print("state changed to: \(state)")
        }
    }
    
    let limit: Int = 20
    var page: Int = 0
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
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
        
        guard state == State.good else {
            return
        }
        
//        let offset = page * limit
//        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)&offset=\(offset)") else {
//            return
//        }
        guard let url = createURL(for: searchTerm) else {
            return
        }
        
        print(url.absoluteString)
        print("start featching data: \(searchTerm)")
        state = .isLoading
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("urlsession error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.state = .error("Could not load: \(error.localizedDescription)")
                }
            } else if let data = data {
                do{
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    
                    DispatchQueue.main.async {
                        for album in result.results {
                            self.listAlbums.append(album)
                        }
                        self.page += 1
                        
                        self.state = (result.results.count == self.limit) ? .good : .loadedAll
                    }
                } catch {
                    print("decoding error: \(error)")
                    DispatchQueue.main.async {
                        self.state = .error("Could not load: \(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
    
    func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Swift.Result<T, APIError>) -> Void) {
        
        guard let url = url else {
            let error = APIError.badURL
            completion(Swift.Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Swift.Result.failure(APIError.urlSession(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Swift.Result.failure(APIError.badResponse(response.statusCode)))
            }
            else if let data = data {
                do{
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(Swift.Result.success(result))
                    
                } catch {
                    completion(Swift.Result.failure(.decoding(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    func createURL(for searchTerm: String, type: EntityType = .album) -> URL? {
        // https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5
        let baseURL = "https://itunes.apple.com/search"
        let offset = page * limit
        let queryItems = [URLQueryItem(name: "term", value: searchTerm),
                          URLQueryItem(name: "entity", value: type.rawValue),
                          URLQueryItem(name: "limit", value: String(limit)),
                          URLQueryItem(name: "offset", value: String(offset))]
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}
