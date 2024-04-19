import SwiftUI
import Combine

// Define your server error response struct
struct ServerErrorResponse: Codable {
    var message: String?
}

// Define your login response struct
struct LoginResponse: Codable {
    var accessToken: String
    var email: String
    var message: String
    var name: String
    var refreshToken: String
}

// The Login ViewModel
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var shouldNavigate = false
    @Published var showAlert = false
    @Published var alertMessage: String = ""

    var cancellables = Set<AnyCancellable>()

    func login() {
        let loginURL = "https://social-demo-backend.onrender.com/login"
        guard let url = URL(string: loginURL) else {
            updateAlert(message: "Invalid URL for login service.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["email": email, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(handleResponse)
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: handleCompletion, receiveValue: handleReceivedValue(response:))

            .store(in: &cancellables)
    }

    private func handleResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        if response.statusCode == 200 {
            return output.data
        } else {
            // Assuming that any non-200 response will still return JSON with an error message
            if let errorResponse = try? JSONDecoder().decode(ServerErrorResponse.self, from: output.data) {
                throw NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message ?? "Unknown server error"])
            } else {
                // If decoding the error message failed
                let rawResponseString = String(data: output.data, encoding: .utf8) ?? "Failed to decode response"
                throw NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server responded with status code \(response.statusCode): \(rawResponseString)"])
            }
        }
    }


    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            // Processing completed successfully, no need to do anything here
            break
        case .failure(let error):
            updateAlert(message: error.localizedDescription)
        }
    }

    private func handleReceivedValue(response: LoginResponse) {
        if response.message == "Login successful" {
            shouldNavigate = true // Triggers the navigation
        } else {
            updateAlert(message: response.message)
        }
    }


    private func updateAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

struct LoginForm: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                    .frame(minHeight: 50)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                SecureField("Password", text: $viewModel.password)
                    .padding(.horizontal)
                    .frame(minHeight: 50)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                Button("Login") {
                    viewModel.login()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                .padding(.horizontal)

                NavigationLink(destination: StacksView(), isActive: $viewModel.shouldNavigate) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Login")
            .padding(.horizontal)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Login Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}

// StacksView for successful login navigation
struct StacksView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 300, height: 500, alignment: .center)
            VStack {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 150, height: 150)
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 50, height: 50)
                    Rectangle()
                        .fill(Color.pink)
                        .frame(width: 25, height: 25)
                }
            }.background(Color.white)
        }
    }
}
