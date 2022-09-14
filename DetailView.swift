import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    @State var isPresentingEditView = false
    var body: some View {
        List{
            Section(header: Text("Meeting Info"))
            {
                NavigationLink(destination: ContentView()){
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
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView){
            NavigationView{
                DetailEditView()
                    .navigationTitle(scrum.title)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction)
                        {
                            Button("Cancel"){
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction, content: {Button("Confirm", action: { isPresentingEditView = false})})
                    }
            }
        }
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
            }
        }
    }
}
//sheet modifier cover the underlying view with new view like a sheet paper

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(scrum: DailyScrum.sampleData[2])
        }
    }
}
