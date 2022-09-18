import SwiftUI

//struct used to record past event
struct History: Identifiable, Codable {
    let id: UUID
    let data: Date
    var attendees: [DailyScrum.Attendee]
    var lengthInMinutes: Int
    
}


