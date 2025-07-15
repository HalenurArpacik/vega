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
        List {
            ForEach(viewModel.imageInfoList, id: \.id) { info in
                VStack {
                    if let url = URL(string: info.download_url),
                       // istek bitince, viewModel, burayı tekrardan çalıştırır - çünkü observable
                       let uiImage = viewModel.images[url] {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: .black, radius: 10)
                    } else if let url = URL(string: info.download_url) {
                        ProgressView()
                            .task {
                                await viewModel.loadImage(at: url)
                            }
                    }
                    
                    
                }
                .onAppear {
                    if info == viewModel.imageInfoList.last {
                        Task {
                            await viewModel.loadNextPage()
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.loadNextPage()
        }
        //120fps -> 60fps -> 1 / 60frame -> 16.67ms 1frame
    }
}

#Preview {
    AsyncImageListView()
}

