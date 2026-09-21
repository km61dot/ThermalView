import SwiftUI

struct ThermalIndicatorView: View {
    let condition: ThermalCondition

    var body: some View {
        ZStack {
            Circle()
                .fill(condition.accentColor.opacity(0.18))
                .blur(radius: 34)
                .frame(width: 310, height: 310)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.13), .white.opacity(0.035), .black.opacity(0.34)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    Circle().stroke(.white.opacity(0.10), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.42), radius: 34, x: 0, y: 20)

            Circle()
                .trim(from: 0, to: condition.progress)
                .stroke(
                    condition.accentColor,
                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .padding(16)

            VStack(spacing: 13) {
                Image(systemName: condition.iconName)
                    .font(.system(size: 44, weight: .bold))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(condition.accentColor)

                Text(condition.displayTitle)
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text(condition.shortStatus)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.56))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
            }
            .contentTransition(.opacity)
            .id(condition.displayTitle)
        }
        .frame(width: 292, height: 292)
    }
}
