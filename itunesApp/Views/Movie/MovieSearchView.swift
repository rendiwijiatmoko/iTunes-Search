//
//  MovieSearchView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 28/08/22.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject var viewModelMovieList = MovieListViewModel()
    var body: some View {
        NavigationView {
            Group {
                if viewModelMovieList.searchTerm.isEmpty {
                    SearchPlaceHolderView(searchTerm: $viewModelMovieList.searchTerm)
                } else {
                    MovieListView(viewModelMovieList: viewModelMovieList)
                }
            }
            .searchable(text: $viewModelMovieList.searchTerm)
            .navigationTitle("Search Movies")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
