//
//  AlbumSearchView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 24/08/22.
//

import SwiftUI

struct AlbumSearchView: View {
    @StateObject var viewModelAlbumList = AlbumListViewModel()
    var body: some View {
        NavigationView {
            Group {
                if viewModelAlbumList.searchTerm.isEmpty {
                    AlbumPlaceHolderView(searchTerm: $viewModelAlbumList.searchTerm)
                } else {
                    AlbumListView(viewModelAlbumList: viewModelAlbumList)
                }
            }
            .searchable(text: $viewModelAlbumList.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}

struct AlbumPlaceHolderView: View {
    @Binding var searchTerm: String
    let suggestion: [String] = ["rammstain", "cry to me", "maneskin"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
            ForEach(suggestion, id: \.self) { text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                        .font(.title2)
                }

        }
    }
    }
}

struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView()
    }
}
