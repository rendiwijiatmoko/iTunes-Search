//
//  SearchPlaceHolderView.swift
//  itunesApp
//
//  Created by Rendi Wijiatmoko on 29/08/22.
//

import SwiftUI

struct SearchPlaceHolderView: View {
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

struct SearchPlaceHolderView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceHolderView(searchTerm: .constant("Momo"))
    }
}
