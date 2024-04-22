import SwiftUI

struct FadeInImageView: View {
    let url: URL
    @State private var isLoading = true

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .transition(.opacity)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity.animation(.easeIn(duration: 0.5)))
                    .onAppear { isLoading = false }
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.gray)
                    .transition(.opacity)
            @unknown default:
                EmptyView()
            }
        }
    }
}
