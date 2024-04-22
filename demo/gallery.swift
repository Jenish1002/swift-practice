import SwiftUI

struct Gallery: View {
    @State private var products: [Product] = []
    @State private var isLoading = true

    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    private let spacing: CGFloat = 20
    private let padding: CGFloat = 20

    private var gridItemSize: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        return (screenWidth - padding * 2 - spacing * CGFloat(gridLayout.count - 1)) / CGFloat(gridLayout.count)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    LazyVGrid(columns: gridLayout, spacing: spacing) {
                        ForEach(products.prefix(10)) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                VStack(alignment: .center, spacing: 8) {
                                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: gridItemSize, height: gridItemSize)
                                    .cornerRadius(10)
                                    .scaledToFill()
                                    
                                    Text(product.title)
                                        .font(.caption)
                                        .lineLimit(1)
                                        .foregroundColor(.black)
                                        .frame(width: gridItemSize)
                                    
                                    Text("$\(product.price)")
                                        .font(.caption2)
                                }
                                .padding(.bottom, 8)
                            }
                        }
                    }
                    .padding(.all, padding)
                }
            }
            .navigationTitle("Gallery")
            .onAppear {
                loadProducts()
            }
        }
    }
    
    func loadProducts() {
        APIManager.shared.fetchProducts { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let products):
                    self.products = products
                case .failure(let error):
                    print("Error loading products: \(error)")
                }
            }
        }
    }
}

// Preview
struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery()
    }
}
