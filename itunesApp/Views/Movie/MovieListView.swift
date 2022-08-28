//
//  MovieListView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 28/08/22.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModelMovieList: MovieListViewModel
    
    var body: some View {
        List
        {
            ForEach(viewModelMovieList.listMovies) { movie in
                Text(movie.trackName)
            }
            switch viewModelMovieList.state
            {
            case .good:
                Color.red.frame(height:50)
//                    .onAppear{
//                        viewModelMovieList.loadMore()
//                    }
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
            case .loadedAll:
                Color.green.frame(height: 50)
            case .error(let message):
                Text(message)
                    .foregroundColor(.pink)
            }
            
        }
        .listStyle(.plain)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModelMovieList: MovieListViewModel())
    }
}
