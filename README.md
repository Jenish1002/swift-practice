## SwiftUI Snippet: login Component

### Overview
The `login` component is a SwiftUI view designed for user authentication. It includes email and password input fields, validation logic, and an alert system to provide feedback to the user.

### Features
- **User Inputs**: Email and password fields with customization.
- **Navigation**: Back navigation with a simple button.
- **Validation**: Email and password validation to ensure data integrity.
- **Alerts**: Feedback provided via alerts based on the validation result.

### Code Breakdown

#### Environment and State Declarations
```swift
@Environment(\.presentationMode) var presentationMode
@State private var username: String = ""
@State private var password: String = ""
@State private var showingAlert = false
@State private var alertMessage = ""
```

#### View Model
```
NavigationView {
    ScrollView {
        VStack(spacing: 20) {
            backButton
            loginImage
            titleText
            emailInputField
            passwordInputField
            loginButton
        }
        .padding(20)
    }
    .navigationBarTitle("Login", displayMode: .inline)
    .navigationBarHidden(true)
}
```
#### Back button
```
var backButton: some View {
    Button(action: {
        presentationMode.wrappedValue.dismiss()
    }) {
        Image(systemName: "chevron.left")
            .foregroundColor(.blue)
            .imageScale(.large)
            .padding()
    }
}
```

#### Image
- Make sure to add your image in the Assets.

```
var loginImage: some View {
    Image("guycoding")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 250, height: 250)
}

```

#### Title Text
```
var titleText: some View {
    Text("Login")
        .bold()
        .font(.title)
}

```
#### EmailInputField
```
var emailInputField: some View {
    TextField("Email", text: $username)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(7.0)
        .frame(maxWidth: .infinity, minHeight: 50)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
}

```

#### PasswordInputField
```
var passwordInputField: some View {
    SecureField("Password", text: $password)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(7.0)
        .frame(maxWidth: .infinity, minHeight: 50)
}

```

#### Login Button

```
var loginButton: some View {
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
        Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
    }
}

```

## Login Logic and Validation
#### Login Action
```
private func loginAction() {
    if !isEmailValid(username) {
        alertMessage = "Please enter a valid email address."
        showingAlert = true
    } else if !isPasswordValid(password) {
        alertMessage = "Password must be at least 8 characters long."
        showingAlert = true
    } else {
        alertMessage = "Login successful!"
        showingAlert = true
    }
}

```
#### Validation Functions
``` 
private func isEmailValid(_ email: String) -> Bool {
    let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
    return emailPredicate.evaluate(with: email)
}

private func isPasswordValid(_ password: String) -> Bool {
    return password.count >= 8
}

```

#### Preview Provider
```
struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}

```

## login.swift
```
import SwiftUI

struct login: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

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

                    Text("Login")
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
                        Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(20)
            }
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarHidden(true)
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
            // Proceed with login process if both validations pass
            alertMessage = "Login successful!"
            showingAlert = true
        }
    }

    private func isEmailValid(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }

    private func isPasswordValid(_ password: String) -> Bool {
        return password.count >= 8
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}

```
