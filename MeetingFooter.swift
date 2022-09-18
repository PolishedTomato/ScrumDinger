import SwiftUI

struct MeetingFooter: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: () ->Void
    
    //return the first index of which is not complete their speach
    //otherwise return nil
    private var speakerNumber: Int?{
        guard let index = speakers.firstIndex(where: {!$0.isCompleted}) else{
            return nil
        }
        return index + 1
    }
    
    private var isLastSpeaker: Bool{
        return speakers.dropLast().allSatisfy{
            $0.isCompleted
        }
    }
    
    private var speakerText: String{
        guard let speakerNumber = speakerNumber else{
            return "No more speakers"
        }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack{
            HStack{
                if isLastSpeaker {
                    Text("Last Speaker")
                }
                else{
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction)
                    {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                    
                }
                }
        }
        .padding([.bottom, .horizontal])
        
    }
}

struct MeetingFooter_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooter(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
