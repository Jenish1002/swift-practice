import SwiftUI

struct EventRow: View {

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
        .overlay(
            VStack{
            HStack {
            Text("Text one")
                Spacer()
            Text("Text two")
            }
                HStack {
                    Spacer()
                    Image(systemName: "flame")
                    .font(.body)
                    Spacer()
                } // END of second HStack
                    .padding(.top, -14)
            } //END of Vstack
        )
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
       EventRow().previewLayout(.fixed(width: 300, height: 60))

    }
}
