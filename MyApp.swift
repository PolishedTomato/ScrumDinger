import SwiftUI

@main
struct MyApp: App {
    @StateObject private var store = ScrumStore()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ScrumsView(scrums: $store.scrums){
                    Task{
                        do{
                            try await ScrumStore.save(scrums: store.scrums)
                        }
                        catch{
                            fatalError("fail to save")
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
                    fatalError("fail to load")
                }
            }
        }
    }
}
//entry point of the app
//with @main property wrapper, struct conform to App, WindowGroup to Scene protocol
