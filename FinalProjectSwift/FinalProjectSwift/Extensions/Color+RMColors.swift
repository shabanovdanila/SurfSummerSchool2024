import SwiftUI

extension Color {
    enum RMColor {
        static let black = Color(r: 21, g: 21, b: 23)
        static let green = Color(r: 25, g: 135, b: 55)
        static let red = Color(r: 214, g: 35, b: 0)
        static let gray = Color(r: 104, g: 104, b: 116)
        static let lightGray = Color(r: 109, g: 120, b: 133)
        static let blue = Color(r: 66, g: 180, b: 202)
    }
}

fileprivate extension Color {
    init(r: Double, g: Double, b: Double) {
        self.init(red: r / 255, green: g / 255, blue: b / 255)
    }
}
