import SwiftUI

struct NightGradientBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.03, green: 0.05, blue: 0.14),
                Color(red: 0.08, green: 0.07, blue: 0.28),
                Color(red: 0.18, green: 0.08, blue: 0.33)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

extension View {
    func glassCard() -> some View {
        self
            .background(.white.opacity(0.10))
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(.white.opacity(0.18), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.25), radius: 18, y: 10)
    }
}
