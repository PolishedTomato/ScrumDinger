import SwiftUI

struct DailyScrum: Identifiable{
    let id = UUID()
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    
    init(title: String, attendees: [String], lengthInMinutes: Int, theme: Theme)
    {
        self.title = title
        self.attendees = attendees.map
        {
            (name: String) in 
            return Attendee(name: name)
        }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum{
    struct Attendee: Identifiable{
        let id: UUID
        var name: String
        
        init(name: String)
        {
            self.id = UUID()
            self.name = name
        }
    }
}

extension DailyScrum{
    //sample data
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design", attendees: ["John","Lei","God"], lengthInMinutes: 30, theme: .Yellow ),
        DailyScrum(title: "Apple Dev", attendees: ["Lei","God"], lengthInMinutes: 50 , theme: .Cyan ),
        DailyScrum(title: "App Learn", attendees: ["John","Lei","God"], lengthInMinutes: 60 , theme: .Blue )
    ]

}
