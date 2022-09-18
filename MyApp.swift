import SwiftUI

@main
struct MyApp: App {
    @StateObject private var store = ScrumStore()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ScrumsView(scrums: $store.scrums){
                    ScrumStore.save(scrums: store.scrums){
                        result in 
                        if case .failure(let error) = result{
                            fatalError(error.localizedDescription)
                        }
                        //print("data save")
                    }
                }
                    .navigationTitle("Daily Scrums")
            }
            .onAppear(){
                ScrumStore.load(completion: {
                    result in 
                    switch result{
                        case .failure(let error):
                        fatalError(error.localizedDescription)
                        
                        case .success(let scrums):
                        store.scrums = scrums
                    }
                    //print("data load")
                })
            }
        }
    }
}
//entry point of the app
//with @main property wrapper, struct conform to App, WindowGroup to Scene protocol
