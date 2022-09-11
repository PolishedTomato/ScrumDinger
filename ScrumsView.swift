import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    var body: some View {
        List{
            ForEach(scrums)
            {scrum in 
                NavigationLink
                {
                    DetailView(scrum: scrum)
                } label:
                {
                    CardView(scrum: scrum)
                }
                .listRowBackground( scrum.theme.mainColor)
            }
        }
    }
}
//listRowBackground only apply to the closest child of list
struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
