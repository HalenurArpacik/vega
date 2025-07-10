//
//  ContentView.swift
//  exampleProject
//
//  Created by Halenur Arpacık on 10.07.2025.
//

import SwiftUI

struct AsyncURLImageView: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: .black, radius: 10)
            
        } placeholder: {
            VStack {
                ProgressView()
                    .controlSize(.large)
                Text("loading...")
            }
        }
        .padding()
        .background(.red)
    }
}

#Preview {
    AsyncURLImageView(url: URL(string: "https://picsum.photos/200/300"))
}
