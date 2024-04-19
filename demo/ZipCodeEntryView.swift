import SwiftUI

struct ZipCodeEntryView: View {
    @State private var zipCode: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView{
            NavigationStack {
                Spacer(minLength: 350)
                VStack(alignment: .center) {
                    TextField("Enter Zip Code", text: $zipCode)
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 30)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .onReceive(zipCode.publisher.collect()) {
                            self.zipCode = String($0.prefix(6).filter { "0123456789".contains($0) })
                        }

                    Spacer(minLength: 10)

                    Button("Continue") {
                      
                    }
                    .disabled(zipCode.count != 6)
                    .padding(.all)
                    
                    .buttonStyle(.borderedProminent)
                    .frame(maxHeight: 1000)
                }
                .navigationTitle("Enter Zip Code")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
        }

struct ZipCodeEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ZipCodeEntryView()
    }
}
