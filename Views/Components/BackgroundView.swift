import SwiftUI

struct BackgroundView: View {
    let condition: ThermalCondition

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            RadialGradient(
                colors: [
                    condition.backgroundTint.opacity(condition.intensity),
                    Color.black.opacity(0.88),
                    Color.black
                ],
                center: .center,
                startRadius: 60,
                endRadius: 520
            )
            .ignoresSafeArea()

            LinearGradient(
                colors: [
                    Color.white.opacity(0.028),
                    Color.clear,
                    Color.black.opacity(0.42)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
        .animation(.easeInOut(duration: 0.45), value: condition)
    }
}
