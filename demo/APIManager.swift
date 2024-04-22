import Foundation

class APIManager {
    static let shared = APIManager()

    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                completion(.success(productsResponse.products))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
