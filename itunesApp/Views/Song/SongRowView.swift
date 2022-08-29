//
//  SongRowView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 29/08/22.
//

import SwiftUI

struct SongRowView: View {
    let song: Song
    var body: some View {
        HStack {
             
            ImageLoadingView(urlString: song.artworkUrl60, size: 60)
            
            VStack(alignment: .leading) {
                Text(song.trackName)
                Text(song.artistName + " " + song.collectionName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            
            Spacer(minLength: 20)
           
            BuyButton(urlString: song.trackViewURL, price: song.trackPrice, currency: song.currency)
        }
    }
}

struct BuyButton: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let url = URL(string: urlString), let price = price {
            Link(destination: url) {
                Text("\(Int(price)) \(currency)")
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
}

struct ImageLoadingView: View {
    let urlString: String
    let size: CGFloat
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty :
                ProgressView()
                    .frame(width: size)
            case .failure(_):
                Color.gray
                    .frame(width: size)
            case .success(let image):
                image
                    .border(Color(white: 0.8))
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: size)
    }
}


struct SongRowView_Previews: PreviewProvider {
    static var previews: some View {
        SongRowView(song: Song.example())
    }
}
