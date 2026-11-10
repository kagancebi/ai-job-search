import SwiftUI

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

enum Theme {
    static let bg = Color(hex: 0x0B1117)
    static let surface = Color(hex: 0x151D26)
    static let teal = Color(hex: 0x2A9D8F)
    static let amber = Color(hex: 0xF4A261)
    static let coral = Color(hex: 0xE76F51)
    static let sky = Color(hex: 0x5AA9E6)
    static let muted = Color.white.opacity(0.6)
}

/// Dark canvas with two soft glows, shared by every screen.
struct Background: View {
    var body: some View {
        ZStack {
            Theme.bg
            Circle()
                .fill(Theme.teal.opacity(0.28))
                .frame(width: 340, height: 340)
                .blur(radius: 90)
                .offset(x: -150, y: -300)
            Circle()
                .fill(Theme.amber.opacity(0.16))
                .frame(width: 300, height: 300)
                .blur(radius: 100)
                .offset(x: 170, y: 340)
        }
        .ignoresSafeArea()
    }
}
