import Foundation

protocol LoginRepository {
    func login(credentials: LoginRequest, completion: @escaping (Result<Bool, Error>) -> Void)
}

class APILoginRepository: LoginRepository {
    private let urlString = "https://social-demo-backend.onrender.com/login"

    func login(credentials: LoginRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(IdentifiableError(message: "Invalid URL")))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(credentials)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(IdentifiableError(message: "Login failed: \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(IdentifiableError(message: "No data received")))
                return
            }

            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                if loginResponse.success {
                    completion(.success(true))
                } else {
                    completion(.failure(IdentifiableError(message: loginResponse.message ?? "Unknown error")))
                }
            } catch {
                completion(.failure(IdentifiableError(message: "Failed to decode response")))
            }
        }.resume()
    }
}
