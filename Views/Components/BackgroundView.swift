import SwiftUI

struct BackgroundView: View {
    let condition: ThermalCondition

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            RadialGradient(
                colors: [
                    condition.backgroundTint.opacity(0.95),
                    Color(red: 0.03, green: 0.04, blue: 0.07).opacity(0.92),
                    .black
                ],
                center: .top,
                startRadius: 40,
                endRadius: 760
            )
            .ignoresSafeArea()

            LinearGradient(
                colors: [.white.opacity(0.05), .clear, .black.opacity(0.44)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
        .animation(.easeInOut(duration: 0.35), value: condition)
    }
}
