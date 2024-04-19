import SwiftUI

struct DemoScrollView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<10) { index in
                    ScrollView(.horizontal,content: {})
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(height: 100)
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct DemoScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DemoScrollView()
    }
}
