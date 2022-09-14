import SwiftUI

struct DetailEditView: View {
    @State private var data = DailyScrum.Data()//initalize nested type
    @State private var newAttendeeName = ""
    //voiceOver will use Text in Slide to identify what to read
    var body: some View {
        Form{
            Section(header: Text("Meeting Info")){
                TextField("Title", text: $data.title)
                HStack{
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1){
                        Text("Length")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
            }
            Section(header: Text("Attendees"))
            {
                ForEach(data.attendees){
                    attendee in Text(attendee.name)
                }
                .onDelete{
                    indices in 
                    data.attendees.remove(atOffsets: indices)
                }
                HStack{
                    TextField("New Attendee", text: $newAttendeeName)
                    Spacer()
                    Button(action: {
                        withAnimation{
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}
//disable modifier make button unusable when bool is true


struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
