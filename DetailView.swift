import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    var body: some View {
        List{
            Section(header: Text("Meeting Info"))
            {
                NavigationLink(destination: ContentView(scrum: $scrum)){
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes)")
                }
                .accessibilityElement(children: .combine)
                HStack{
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.rawValue)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(15.0)
                }
            }
            Section(header: Text("Attendees"))
            {
                ForEach(scrum.attendees)
                {
                    attendee in 
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")){
                if scrum.history.isEmpty{
                    Label("No meeting yet", systemImage: "hare")
                }
                ForEach(scrum.history){
                    h in HStack{
                            Image(systemName: "calender")
                            Text(h.data, style: .date)
                        }
                    
                }
            }
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView){
            NavigationView{
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction)
                        {
                            Button("Cancel"){
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction, content: {Button("Confirm", action: { 
                            scrum.update(from: data)
                            isPresentingEditView = false
                            return 
                        })})
                    }
            }
        }
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
                data = scrum.data
            }
        }
    }
}
//sheet modifier cover the underlying view with new view like a sheet paper

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(scrum: .constant(DailyScrum.sampleData[2]))
        }
    }
}
