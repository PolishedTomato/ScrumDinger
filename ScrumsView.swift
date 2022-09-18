import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    //use environment instances to know the scenephase
    //notice scene is the container of the whole app
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: ()->Void
    var body: some View {
        List{
            ForEach($scrums)
            {$scrum in 
                NavigationLink
                {
                    DetailView(scrum: $scrum)
                } label:
                {
                    CardView(scrum: scrum)
                }
                .listRowBackground( scrum.theme.mainColor)
            }
        }
        .toolbar{
            Button(action: {isPresentingNewScrumView = true }){
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
        .sheet(isPresented: $isPresentingNewScrumView){
            NavigationView{
                DetailEditView(data: $newScrumData)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Dismiss"){
                                isPresentingNewScrumView = false
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                let newScrum = DailyScrum(data: newScrumData)
                                
                                scrums.append(newScrum)
                                newScrumData = DailyScrum.Data()
                                
                                isPresentingNewScrumView = false
                            }.disabled(newScrumData.title.isEmpty || newScrumData.attendees.isEmpty)
                        }
                    }
            }
        }
        .onChange(of:  scenePhase){
            phase in 
            if phase == .inactive{
                saveAction()
            }
        }
    }
}
//past binding value in for each enable array binding

//listRowBackground only apply to the closest child of list
struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}
