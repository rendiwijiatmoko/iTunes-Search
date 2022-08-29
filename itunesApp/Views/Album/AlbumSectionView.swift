//
//  AlbumSectionView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 29/08/22.
//

import SwiftUI

struct AlbumSectionView: View {
    let albums: [Album]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(albums) { album in
                    VStack(alignment: .leading) {
                        ImageLoadingView(urlString: album.artworkUrl100, size: 100)
                        Text(album.collectionName)
                        Text(album.artistName)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 100)
                    .lineLimit(1)
                    .font(.caption)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct AlbumSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSectionView(albums: [Album.example()])
    }
}
