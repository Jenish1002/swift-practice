import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}
struct ProductsResponse: Codable {
    let products: [Product]
}
