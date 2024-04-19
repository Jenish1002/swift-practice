import Foundation

class LoginViewModel: ObservableObject {
    @Published var shouldNavigate = false
    @Published var errorMessage: String = ""
    
    private var loginRepository: LoginRepository
    
    init(repository: LoginRepository) {
        self.loginRepository = repository
    }

    func login(email: String, password: String) {
        let credentials = LoginRequest(email: email, password: password)
        loginRepository.login(credentials: credentials) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.shouldNavigate = true
                    self?.errorMessage = ""
                case .failure(let error):
                    self?.shouldNavigate = false
                    if let identifiableError = error as? IdentifiableError {
                        self?.errorMessage = identifiableError.message
                    } else {
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}
