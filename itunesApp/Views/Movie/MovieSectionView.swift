//
//  MovieSectionView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 29/08/22.
//

import SwiftUI

struct MovieSectionView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 0) {
                ForEach(movies) { movie in
                    VStack(alignment: .leading) {
                        ImageLoadingView(urlString: movie.artworkUrl100, size: 100)
                        Text(movie.trackName)
                        Text(movie.primaryGenreName)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 80)
                    .lineLimit(1)
                    .font(.caption)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(movies: [Movie.example()])
    }
}
