import SwiftUI

struct RemoteImageViewExample: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://community.brave.com/t/copy-image-link/435252")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 300, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct RemoteImageViewExample_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageViewExample()
    }
}
