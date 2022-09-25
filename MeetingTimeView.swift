import SwiftUI

struct MeetingTimeView: View {
    let speakers: [ScrumTimer.Speaker]
    let isRecording: Bool
    let theme : Theme
    
    private var cur_speaker: String{
        speakers.first(where: {!$0.isCompleted})?.name ?? "Someone"
    }
    //stroke modifier trace a line of the shape
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay{
                VStack{
                    Text(cur_speaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay  {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimeView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingTimeView(speakers: [ScrumTimer.Speaker(name: "Socrates", isCompleted: true), ScrumTimer.Speaker(name: "Plato", isCompleted: false)], isRecording: false,theme: .Yellow)
    }
}
