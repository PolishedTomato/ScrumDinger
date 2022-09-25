import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView{
            VStack{
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Dismiss"){
                        dismiss()
                    }
                })
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleErorr: Error{
        case errorRequired
    }
    static var previews: some View {
        ErrorView(errorWrapper: ErrorWrapper(error: SampleErorr.errorRequired, guidance: "Sample error"))
    }
}
