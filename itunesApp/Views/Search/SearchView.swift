//
//  SearchView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 29/08/22.
//

import SwiftUI

struct SearchView: View {
    @State private var searchTerm: String = ""
    @State private var selectedEntityType = EntityType.all
    
    @StateObject private var viewModelAlbumList = AlbumListViewModel()
    @StateObject private var viewModelMovieList = MovieListViewModel()
    @StateObject private var viewModelSongList = SongListViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                Picker("Select the media", selection: $selectedEntityType) {
                    ForEach(EntityType.allCases) { type in
                        Text(type.name())
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Divider()
                
                if searchTerm.count == 0 {
                    SearchPlaceHolderView(searchTerm: $searchTerm)
                        .frame(maxHeight: .infinity)
                } else {
                    switch selectedEntityType {
                    case .all:
                        SearchAllListView()
                    case .album:
                        AlbumListView(viewModelAlbumList: viewModelAlbumList)
                    case .song:
                        SongListView(viewModelSongList: viewModelSongList)
                    case .movie:
                        MovieListView(viewModelMovieList: viewModelMovieList)
                    }
                }
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: searchTerm) { newValue in
            viewModelAlbumList.searchTerm = newValue
            viewModelSongList.searchTerm = newValue
            viewModelMovieList.searchTerm = newValue
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
