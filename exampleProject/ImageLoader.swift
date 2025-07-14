//
//  ImageLoader.swift
//  exampleProject
//
//  Created by Halenur Arpacık on 10.07.2025.
//
import Foundation
import UIKit

class ImageLoader {
    private let cache: NSCache<NSURL, UIImage>
    init() {
            cache = NSCache<NSURL, UIImage>()
            cache.countLimit = 40
        }
    
    func getImage(from url: URL) async -> UIImage? {
        let nsUrl = url as NSURL
        
        if let cachedImage = cache.object(forKey: nsUrl) {
            return cachedImage
        }
        
        let urlRequest = URLRequest(url: url)
        guard let (data, _) = try? await URLSession.shared.data(for: urlRequest),
              let image = UIImage(data: data) else {
            return nil
        }
        
        cache.setObject(image, forKey: nsUrl)
        return image
    }
}


