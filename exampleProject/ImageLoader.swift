//
//  ImageLoader.swift
//  exampleProject
//
//  Created by Halenur Arpacık on 10.07.2025.
//

import Foundation

class ImageLoader {
    var cacheDictionary: [URL: Data] = [:]
    
    func getImage(from url: URL) async -> Data? {
        if let cachedImageData = cacheDictionary[url] {
            return cachedImageData
        }
        
        let urlRequest = URLRequest(url: url)
        let response =  try? await URLSession.shared.data(for: urlRequest)
        guard let data = response?.0 else {
            return nil
        }
        
        set(imageData: data, url: url)
        
        return data
    }
    
    func set(imageData: Data, url: URL) {
        cacheDictionary[url] = imageData
    }
}
