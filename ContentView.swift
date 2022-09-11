import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack{
            ProgressView(value: 5, total: 15)
            HStack{
                VStack(alignment: .leading){
                    Text("Second Elapse")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.bottomhalf.filled")
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("Second Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.tophalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time remaining abc")
            .accessibilityValue("10 minutes")
            
            Circle().strokeBorder(lineWidth: 15.0)
            HStack{
                Text("Speaker 1 of 3")
                Spacer()
                Button(action: {})
                {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next speaker")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
