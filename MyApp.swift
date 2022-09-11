import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ScrumsView(scrums: DailyScrum.sampleData)
                    .navigationTitle("Daily Scrums")
                    .toolbar{
                        Button(action: {}){
                            Image(systemName: "plus")
                        }
                        .accessibilityLabel("New Scrum")
                    }
            }
        }
    }
}
