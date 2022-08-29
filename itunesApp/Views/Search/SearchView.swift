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
                            .onAppear {
                                viewModelAlbumList.searchTerm = searchTerm
                                viewModelSongList.searchTerm = searchTerm
                                viewModelMovieList.searchTerm = searchTerm
                            }
                    case .album:
                        AlbumListView(viewModelAlbumList: viewModelAlbumList)
                            .onAppear {
                                viewModelAlbumList.searchTerm = searchTerm
                            }
                    case .song:
                        SongListView(viewModelSongList: viewModelSongList)
                            .onAppear {
                                viewModelSongList.searchTerm = searchTerm
                            }
                    case .movie:
                        MovieListView(viewModelMovieList: viewModelMovieList)
                            .onAppear {
                                viewModelMovieList.searchTerm = searchTerm
                            }
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
