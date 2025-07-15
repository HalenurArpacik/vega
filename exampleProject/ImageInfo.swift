
import Foundation

struct ImageInfo: Codable, Identifiable, Hashable {
    let id: String
    let author: String
    let download_url: String
}

extension URL {
    static func picsumURL(page: Int, limit: Int) -> URL {
        URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)")!
    }
}
