import SwiftUI

enum Theme: String{
    case Red, Orange, Yellow, Green, Mint, Teal, Cyan, Blue, Indigo, Purple, Pink, Brown 
    
    var accentColor: Color{
        switch self{
            case .Red, .Orange, .Yellow, .Teal, .Pink:
            return .black
            case .Indigo, .Green, .Purple, .Mint, .Cyan, .Brown, .Blue:
            return .white
        }
    }
    
    var mainColor: Color{
        switch self{
            case .Yellow:
            return Color.yellow
            
            case .Red:
            return Color.blue
            
            case .Green:
            return Color.green
            
            case .Orange:
            return Color.orange
            
            case .Brown:
            return Color.brown
            
            case .Cyan:
            return Color.cyan
            
            case .Indigo:
            return Color.indigo
            
            case .Mint:
            return Color.mint
            
            case .Pink:
            return Color.pink
            
            case .Purple:
            return Color.purple
            
            case .Teal:
            return Color.teal
            
            case .Blue:
            return Color.blue
        }
    }
}
