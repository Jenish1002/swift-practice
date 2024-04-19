import SwiftUI

struct LoginForm: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @StateObject private var viewModel = LoginViewModel(repository: APILoginRepository())

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Email", text: $username)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Login") {
                    viewModel.login(email: username, password: password)
                }
                .disabled(!isFormValid)
                .padding()

                NavigationLink(destination: StacksView(), isActive: $viewModel.shouldNavigate) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Login")
            .padding()
        }
    }

    var isFormValid: Bool {
        isValidEmail(username) && isValidPassword(password)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        let passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordPredicate.evaluate(with: password)
    }
}
