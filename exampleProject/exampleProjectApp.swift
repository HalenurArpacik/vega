//
//  exampleProjectApp.swift
//  exampleProject
//
//  Created by Halenur Arpacık on 10.07.2025.
//

import SwiftUI

@main
struct exampleProjectApp: App {
    var body: some Scene {
        WindowGroup {
            //AsyncURLImageView(url: URL(string: "https://picsum.photos/seed/picsum/600/300"))
            AsyncImageListView()
        }
    }
}
