import SwiftUI
//make dailyScrum struct conform to codable
//for a struct to be codable, its stored property have to be codable
struct DailyScrum: Identifiable, Codable{
    var id = UUID()
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    var history: [History] = []
    
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
    struct Attendee: Identifiable, Codable{
        let id: UUID
        var name: String
        
        init(name: String)
        {
            self.id = UUID()
            self.name = name
        }
    }
    
    struct Data{
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .Teal
    }
    
    //a empty vessel for temp data
    var data: Data{
        Data(title: title, attendees: attendees,       lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
}

extension DailyScrum{
    //sample data
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design", attendees: ["John","Lei","God"], lengthInMinutes: 1, theme: .Yellow ),
        DailyScrum(title: "Apple Dev", attendees: ["Lei","God"], lengthInMinutes: 50 , theme: .Cyan ),
        DailyScrum(title: "App Learn", attendees: ["John","Lei","God"], lengthInMinutes: 60 , theme: .Blue )
    ]
}

extension DailyScrum{
    mutating func update(from: DailyScrum.Data){
        self.title = from.title
        self.attendees = from.attendees
        self.lengthInMinutes = Int(from.lengthInMinutes)
        self.theme = from.theme
    }
}

extension DailyScrum{
    init(data: Data){
        title = data.title
        attendees = data.attendees
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
    }
}


