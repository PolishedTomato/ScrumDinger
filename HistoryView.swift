import SwiftUI

//notic List view automatically embeded in scroll view
struct HistoryView: View {
    let history: History
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript{
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}
//format a string by a list of string
extension History{
    var attendeeString: String{
        ListFormatter.localizedString(byJoining: attendees.map{$0.name})
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: History(id: UUID(), date: Date(), attendees: [DailyScrum.Attendee(name: "Joe"), DailyScrum.Attendee(name: "Plato"),DailyScrum.Attendee(name: "Jay")], lengthInMinutes: 45))
    }
}
