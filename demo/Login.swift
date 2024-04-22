import SwiftUI

struct Login: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isAuthenticated = false  // This will control the navigation to Dashboard

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                                .padding()
                        }
                        Spacer()
                    }

                    Image("guycoding")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)

                    Text("Login UI")
                        .bold()
                        .font(.title)

                    TextField("Email", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(7.0)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(7.0)
                        .frame(maxWidth: .infinity, minHeight: 50)

                    Button(action: loginAction) {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, minHeight: 50)
                    }
                    .background(Color.blue)
                    .cornerRadius(7.0)
                    .buttonStyle(PlainButtonStyle())
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(20)
            }
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $isAuthenticated) {
            Dashboard()
        }
    }

    private func loginAction() {
        if !isEmailValid(username) {
            alertMessage = "Please enter a valid email address."
            showingAlert = true
        } else if !isPasswordValid(password) {
            alertMessage = "Password must be at least 8 characters long."
            showingAlert = true
        } else {
            // Assuming validation passes, navigate to the Dashboard
            isAuthenticated = true
        }
    }

    private func isEmailValid(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }

    private func isPasswordValid(_ password: String) -> Bool {
        return password.count >= 8
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
