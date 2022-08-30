//
//  AlbumListSongsView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 30/08/22.
//

import SwiftUI

struct AlbumListSongsView: View {
    @ObservedObject var viewModelSongs: SongForAlbumListViewModel
    var body: some View {
        ScrollView {
            if viewModelSongs.state == .isLoading
            {
                ProgressView()
            } else {
                VStack(alignment: .leading, spacing: 10){
                    ForEach(viewModelSongs.songs) { song in
                        HStack {
                            Text("\(song.trackNumber)")
                                .font(.footnote)
                                .frame(width: 25, alignment: .trailing)
                            Text(song.trackName)
                            
                            Spacer()
                            Text(formattedDuration(time:song.trackTimeMillis))
                                .font(.footnote)
                                .frame(width: 50, alignment: .center)
                            BuySongButton(urlString: song.previewURL, price: song.trackPrice, currency: song.currency)
                            
                        }
                        Divider()
                    }
                }
                .padding()
            }
            
        }
    }
    
    func formattedDuration(time: Int) -> String {
        let timeInSeconds = time / 1000
        let interval = TimeInterval(timeInSeconds)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        
        return formatter.string(from: interval) ?? ""
    }
}

struct AlbumListSongsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListSongsView(viewModelSongs: SongForAlbumListViewModel.example())
    }
}
