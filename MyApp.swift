import SwiftUI

@main
struct MyApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ScrumsView(scrums: $store.scrums){
                    Task{
                        do{
                            try await ScrumStore.save(scrums: store.scrums)
                        }
                        catch{
                            errorWrapper = ErrorWrapper(error: error, guidance: "Save fail, try again")
                        }
                    }
                }
                    .navigationTitle("Daily Scrums")
            }
            .task {
                do{
                    store.scrums = try await ScrumStore.load()
                }
                catch{
                    errorWrapper = ErrorWrapper(error: error, guidance: "scrumDinger will load save data")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {store.scrums = DailyScrum.sampleData}, content: {
                wrapper in 
                ErrorView(errorWrapper: wrapper)
            })
        }
    }
}
//entry point of the app
//with @main property wrapper, struct conform to App, WindowGroup to Scene protocol
