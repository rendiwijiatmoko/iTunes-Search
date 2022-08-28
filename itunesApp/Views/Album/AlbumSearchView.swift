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
                    SearchPlaceHolderView(searchTerm: $viewModelAlbumList.searchTerm)
                } else {
                    AlbumListView(viewModelAlbumList: viewModelAlbumList)
                }
            }
            .searchable(text: $viewModelAlbumList.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}

struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView()
    }
}
