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
    
    init(imageLoader: ImageLoader = ImageLoader()) {
        self.imageLoader = imageLoader
    }
    
    @MainActor
    func loadImage(at url: URL) async {
        guard images[url] == nil else { return }
        if let image = await imageLoader.getImage(from: url) {
            images[url] = image
        }
    }
}

