//
//  AlbumDetailView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 30/08/22.
//

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
    @StateObject var viewModelSongs: SongForAlbumListViewModel
    
    init(album: Album) {
        self.album = album
        self._viewModelSongs = StateObject(wrappedValue: SongForAlbumListViewModel(albumID: album.id))
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: album.artworkUrl100, size: 100)
                
                VStack(alignment:.leading) {
                    Text(album.collectionName)
                        .font(.footnote)
                        .foregroundColor(Color(.label))
                    Text(album.artistName)
                        .padding(.bottom)
                        
                    Text(album.primaryGenreName)
                    Text("\(album.trackCount) songs")
                    Text("Released: \(formatedDate(value: album.releaseDate))")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                Spacer(minLength: 20)
                BuyButton(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
            }
            .padding()
            
            AlbumListSongsView(viewModelSongs: viewModelSongs)
        }
        .onAppear {
            viewModelSongs.fetch()
        }
    }
    
    func formatedDate(value: String) -> String {
        let dateFormatterDateGetter = DateFormatter()
        // 2012-01-01T08:00:00Z
        dateFormatterDateGetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        guard let date = dateFormatterDateGetter.date(from: value) else {
            return ""
        }
        let dateForrmater = DateFormatter()
        dateForrmater.locale = Locale.current
        dateForrmater.dateStyle = .medium
        dateForrmater.timeStyle = .none
        
        return dateForrmater.string(from: date)
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album.example())
    }
}
