//
//  AsyncImageListViewModel.swift
//  exampleProject
//
//  Created by Halenur Arpacık on 10.07.2025.
//

import Foundation
import UIKit 

// MVVM -> Model - View - ViewModel

// macro

@Observable
class AsyncImageListViewModel {
    
    @ObservationIgnored let imageLoader: ImageLoader 
    var images: [URL: UIImage] = [:]
    var imageInfoList: [ImageInfo] = []
    
    private var currentPage = 1
    private let pageLimit = 10
    private var isLoading = false
    
    init(imageLoader: ImageLoader = ImageLoader()) {
        self.imageLoader = imageLoader
    }
    
    

    
    // Load metadata (URLs, authors, etc.)
        func loadNextPage() async {
            guard !isLoading else { return }
            isLoading = true
            
            do {
                let url = URL.picsumURL(page: currentPage, limit: pageLimit)
                let (data, _) = try await URLSession.shared.data(from: url)
                let newItems = try JSONDecoder().decode([ImageInfo].self, from: data)
                imageInfoList.append(contentsOf: newItems)
                currentPage += 1
            } catch {
                print("Error fetching next page: \(error.localizedDescription)")
            }
            
            isLoading = false
        }
    
    
    @MainActor
    func loadImage(at url: URL) async {
        
        guard images[url] == nil else { return }
        if let image = await imageLoader.getImage(from: url) {
            images[url] = image
        }
    }
}

