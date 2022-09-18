import SwiftUI

struct MeetingHeader: View {
    let secondsElaspsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    private var totalSeconds: Int{
        get{
            secondsElaspsed + secondsRemaining
        }
    }
    
    private var progress: Double{
        guard totalSeconds > 0
        else{
            return 1
        }
        return Double(secondsElaspsed) / Double(totalSeconds)
    }
    
    private var minuteRemaining: Int{
        return secondsRemaining / 60
    }
    
    var body: some View {
        VStack{
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgrssViewStyle(theme: theme))
            HStack{
                VStack(alignment: .leading){
                    Text("Second Elapse")
                        .font(.caption)
                    Label("\(secondsElaspsed)", systemImage: "hourglass.bottomhalf.filled")
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("Second Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                        .labelStyle(TrailingIconLabelStyle())
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minuteRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

struct MeetingHeader_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeader(secondsElaspsed: 10, secondsRemaining: 15, theme: .Blue)
            .previewLayout(.sizeThatFits)
    }
}
//to more accurate present the preview 
