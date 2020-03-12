
import PublisherView
import Resourceful
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PublisherView(publisher: URLSession.shared.publisher(for: .metadata),
                          initial: LoadingView.init,
                          output: MetadataList.init,
                          failure: ErrorView.init)
        }
    }
}

struct LoadingView: View {

    var body: some View {
        Text("Loading")
    }
}

struct ErrorView: View {
    let error: Error
    var body: some View {
        VStack(spacing: 8) {
            Text("Something went wrong.")
            Text(error.localizedDescription)
        }
    }
}

struct MetadataList: View {

    let items: [Metadata]

    var body: some View {
        List(items) { item in
            NavigationLink(destination: MetadataView(item: item)) {
                Text(item.author)
            }
        }
    }
}

struct MetadataView: View {
    let item: Metadata
    var body: some View {
        PublisherView(publisher: URLSession.shared.publisher(for: item.image),
                      initial: LoadingView.init,
                      output: PhotoView.init,
                      failure: ErrorView.init)
    }
}

struct PhotoView: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

