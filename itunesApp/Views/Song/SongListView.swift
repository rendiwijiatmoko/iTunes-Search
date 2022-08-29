//
//  SongListView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 29/08/22.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var viewModelSongList: SongListViewModel
    
    var body: some View {
        List
        {
            ForEach(viewModelSongList.listSongs) { song in
                SongRowView(song: song)
            }
            switch viewModelSongList.state
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

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView(viewModelSongList: SongListViewModel.example())
    }
}

