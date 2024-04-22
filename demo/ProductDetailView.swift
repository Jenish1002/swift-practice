import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(product.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Price: $\(product.price)")
                    .font(.subheadline)
                
                Text("Rating: \(product.rating) (\(product.stock) in stock)")
                    .font(.subheadline)
                
                Text(product.description)
                    .font(.body)
                    .padding(.top)

                Text("Images")
                    .font(.headline)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(product.images, id: \.self) { imageUrl in
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 200, height: 200)
                            .cornerRadius(8)
                            .padding(.vertical)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
