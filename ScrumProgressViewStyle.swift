import SwiftUI

struct ScrumProgrssViewStyle: ProgressViewStyle {
    var theme: Theme
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(theme.accentColor)
                .frame(height: 20.0)
            
            ProgressView(configuration)
                .frame(height:12.0)
                .padding(.horizontal)
                .tint(theme.mainColor)
        }
    }
}

struct ScrumProgrssViewStyle_Preview: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 15, total: 20)
            .progressViewStyle(ScrumProgrssViewStyle(theme: .Blue))
            .previewLayout(.sizeThatFits)
    }
}
