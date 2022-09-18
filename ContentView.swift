import SwiftUI
import AVFoundation

struct ContentView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    private var player: AVPlayer{ AVPlayer.sharedDingPlayer}
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack{
                MeetingHeader(secondsElaspsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining , theme: scrum.theme)
                Circle().strokeBorder(lineWidth: 15.0)
                MeetingFooter(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear{
            scrumTimer.stopScrum()
            let newHistory = History(id: UUID(), data: Date(), attendees: scrum.attendees, lengthInMinutes: scrum.lengthInMinutes)
            scrum.history.insert(newHistory, at: 0)
        }
    }
}
//life cycle of content view
//appear, copy the individual scrum data into scrumTimer and make the first attendee as speaker, start the timer
//timer use timescheduled call update method for every 0.1 second to render the UI
//disappear, stop the timer

//navigationBarTitleDisplay ?
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( scrum: .constant(DailyScrum.sampleData[0]))
    }
}
