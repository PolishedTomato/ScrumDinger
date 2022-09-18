import SwiftUI

struct ThemeView: View {
    let theme: Theme
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Label(theme.rawValue, systemImage: "paintpalette")
                .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}
//Since ZStack put view on top of other, RoudedRecttangle will act as a backgound
struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .Yellow)
    }
}
