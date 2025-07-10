//
//  AyncImageListView.swift
//  exampleProject
//
//  Created by Halenur Arpacık on 10.07.2025.
//

import SwiftUI

struct AsyncImageListView: View {
    @State private var viewModel = AsyncImageListViewModel()
    
    var body: some View {
        List(0..<20) { index in
            let url = URL(string: "https://picsum.photos/seed/\(index)/200/300")!
            // istek bitince, viewModel, burayı tekrardan çalıştırır - çünkü observable
            if let imageData = viewModel.images[url], let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .black, radius: 10)
            } else {
                // ilk buraya gelir, istek yapılır
                ProgressView()
                    .task {
                        await viewModel.loadImage(at: url)
                        // istek bitmeden ekran kaydılır ve ekrandan çıkarsa, istek iptal edilir
                    }
            }
        }
        
        //120fps -> 60fps -> 1 / 60frame -> 16.67ms 1frame
    }
}

#Preview {
    AsyncImageListView()
}
