import SwiftUI

struct Hotel {
    let name: String
    let imageName: String
}

struct Dashboard: View {
    let hotels = [
        Hotel(name: "Hotel Sunshine", imageName: "image1"),
        Hotel(name: "Hotel Retreat", imageName: "image2"),
        Hotel(name: "Hotel Living", imageName: "image2"),
        Hotel(name: "Hotel Resort", imageName: "image4"),
        Hotel(name: "Ocean View", imageName: "image2"),
        Hotel(name: "Mountain Retreat", imageName: "image2"),
        Hotel(name: "City Central", imageName: "image2"),
        Hotel(name: "Desert Oasis", imageName: "image2")
    ]
    
    @State private var searchText = ""

    var body: some View {
        TabView {
            hotelList
                .tabItem {
                    Label("Hotels", systemImage: "building.2")
                }
            
            Text("Booking")
                .tabItem {
                    Label("Bookings", systemImage: "calendar")
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }

    private var hotelList: some View {
        NavigationView {
            VStack {
                TextField("Search hotels", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
                
                List(filteredHotels, id: \.name) { hotel in
                    HStack {
                        Image(hotel.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                        
                        Text(hotel.name)
                            .fontWeight(.medium)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Hotels Dashboard", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "bell")
                    }
                }
            }
        }
    }

    private var filteredHotels: [Hotel] {
        if searchText.isEmpty {
            return hotels
        } else {
            return hotels.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
