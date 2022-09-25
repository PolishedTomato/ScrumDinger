import SwiftUI

struct ErrorWrapper: Identifiable{
    let id = UUID()
    let error : Error
    let guidance: String
    
    init(error: Error, guidance: String)
    {
        self.error = error
        self.guidance = guidance
    }
}
