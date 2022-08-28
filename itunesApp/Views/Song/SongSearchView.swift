//
//  SongSearchView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 29/08/22.
//

import SwiftUI

struct SongSearchView: View {
    @StateObject var viewModelSongList = SongListViewModel()
    var body: some View {
        NavigationView {
            Group {
                if viewModelSongList.searchTerm.isEmpty {
                    SearchPlaceHolderView(searchTerm: $viewModelSongList.searchTerm)
                } else {
                    SongListView(viewModelSongList: viewModelSongList)
                }
            }
            .searchable(text: $viewModelSongList.searchTerm)
            .navigationTitle("Search Songs")
        }
    }
}

struct SongSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SongSearchView()
    }
}
