//
//  SearchAllListView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 29/08/22.
//

import SwiftUI

struct SearchAllListView: View {
    @ObservedObject var viewModelAlbumList: AlbumListViewModel
    @ObservedObject var viewModelMovieList: MovieListViewModel
    @ObservedObject var viewModelSongList: SongListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                HStack {
                    Text("Songs")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        SongListView(viewModelSongList: viewModelSongList)
                    } label: {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .padding(.horizontal)
                
                SongSectionView(songs: viewModelSongList.listSongs)
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Text("Albums")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        AlbumListView(viewModelAlbumList: viewModelAlbumList)
                    } label: {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .padding(.horizontal)
                
                AlbumSectionView(albums: viewModelAlbumList.listAlbums)
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Text("Movies")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        MovieListView(viewModelMovieList: viewModelMovieList)
                    } label: {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .padding([.horizontal, .bottom])
                
                MovieSectionView(movies: viewModelMovieList.listMovies)
                Divider()
                    .padding(.bottom)
            }
        }
    }
}

struct SearchAllListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAllListView(viewModelAlbumList: AlbumListViewModel.example(), viewModelMovieList: MovieListViewModel.example(), viewModelSongList: SongListViewModel.example())
    }
}
