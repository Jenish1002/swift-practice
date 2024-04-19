import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let success: Bool
    let message: String?
}

struct IdentifiableError: Error, Identifiable {
    let id = UUID()
    let message: String
}
