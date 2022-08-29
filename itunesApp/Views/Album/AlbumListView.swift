//
//  AlbumListView.swift
//  iTunesSearchApp
//
//  Created by Rendi Wijiatmoko on 24/08/22.
//

import SwiftUI

struct AlbumListView: View {
    @ObservedObject var viewModelAlbumList: AlbumListViewModel
    
    var body: some View {
        List
        {
            ForEach(viewModelAlbumList.listAlbums) { album in
                AlbumRowView(album: album)
            }
            switch viewModelAlbumList.state
            {
            case .good:
                Color.red.frame(height:50)
                    .onAppear{
                        viewModelAlbumList.loadMore()
                    }
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

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(viewModelAlbumList: AlbumListViewModel.example())
    }
}
