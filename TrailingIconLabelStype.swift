import SwiftUI

//configuration is a label styleconfiguration which contain icon, title view
struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}
//this labelstyle basically change the behavior of default label,

//this code make it possible to use leading dot syntax with trailingIcon name
extension LabelStyle where Self == TrailingIconLabelStyle{
    static var trailingIcon: Self { Self()}
}
