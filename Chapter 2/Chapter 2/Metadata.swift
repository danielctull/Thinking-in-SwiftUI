
import Foundation

struct Metadata: Codable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let download_url: URL
}

import Resourceful

extension Resource where Value == [Metadata] {

    static let metadata = Resource(
        request: URLRequest(url: URL(string: "https://picsum.photos/v2/list")!),
        transform: { try JSONDecoder().decode([Metadata].self, from: $0.data) })
}

import SwiftUI
import UIKit

extension Metadata {

    var image: Resource<Image> {
        Resource(
            request: URLRequest(url: download_url),
            transform: { try Image(data: $0.data) })
    }
}

extension Image {

    init(data: Data) throws {
        struct ImageError: Error {}
        guard let image = UIImage(data: data) else { throw ImageError() }
        self.init(uiImage: image)
    }
}
