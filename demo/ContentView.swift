import SwiftUI
import Combine


struct Course: Hashable,Codable{
let name: String
let image: String
}

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}


class ViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var isLoading = false
    @Published var errorMessage: IdentifiableError?

    func fetchCourses() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            errorMessage = IdentifiableError(message: "Invalid URL")
            return
        }
        isLoading = true
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = IdentifiableError(message: "Failed to load data: \(error.localizedDescription)")
                    return
                }
                guard let data = data else {
                    self?.errorMessage = IdentifiableError(message: "No data received")
                    return
                }
                do {
                    let courses = try JSONDecoder().decode([Course].self, from: data)
                    self?.courses = courses
                } catch {
                    self?.errorMessage = IdentifiableError(message: "Failed to decode JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.courses, id: \.self) { course in
                HStack {
                    AsyncImage(url: URL(string: course.image)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.frame(width: 60, height: 60)
                    }
                    .scaledToFit()
                    .frame(width: 60, height: 60)

                    Text(course.name)
                }
            }
            .navigationTitle("Courses")
            .onAppear {
                viewModel.fetchCourses()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
