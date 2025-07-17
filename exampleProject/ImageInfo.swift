
import Foundation

struct ImageInfo: Codable, Identifiable, Hashable {
    let id: String
    let author: String
    let download_url: URL
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        
        let urlString = try container.decode(String.self, forKey: .download_url)
        let baseURL = URL(string: urlString)!.deletingLastPathComponent().deletingLastPathComponent()
        self.download_url = baseURL.appending(component: "200").appending(component: "300")
    }
}

extension URL {
    static func authURL(page: Int, limit: Int) -> URL {
        
        URL.picsumURL(page: page, limit: limit)
    }
    
    static func picsumURL(page: Int, limit: Int) -> URL {
        URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)")!
    }
}
