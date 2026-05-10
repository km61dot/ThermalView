import SwiftUI

struct ThermalIndicatorView: View {
    let condition: ThermalCondition

    var body: some View {
        ZStack {
            outerGlow
            glassCircle
            ring
            content
        }
        .frame(width: 270, height: 270)
        .scaleEffect(condition.scale)
        .animation(
            .spring(response: 0.55, dampingFraction: 0.82),
            value: condition
        )
    }

    private var outerGlow: some View {
        Circle()
            .fill(condition.accentColor.opacity(condition.intensity * 0.22))
            .blur(radius: 28)
            .frame(width: 292, height: 292)
    }

    private var glassCircle: some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.105),
                        Color.white.opacity(0.035),
                        Color.black.opacity(0.38)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.22),
                                Color.white.opacity(0.055),
                                condition.accentColor.opacity(0.18)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
            .shadow(color: Color.black.opacity(0.55), radius: 38, x: 0, y: 24)
    }

    private var ring: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.055), lineWidth: 12)

            Circle()
                .trim(from: 0, to: ringProgress)
                .stroke(
                    AngularGradient(
                        colors: [
                            condition.accentColor.opacity(0.24),
                            condition.accentColor.opacity(0.82),
                            condition.accentColor.opacity(0.24)
                        ],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
        }
        .padding(16)
    }

    private var content: some View {
        VStack(spacing: 16) {
            Image(systemName: condition.iconName)
                .font(.system(size: 42, weight: .semibold))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(condition.accentColor)
                .contentTransition(.opacity)
                .id(condition.iconName)

            Text(condition.displayTitle)
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .tracking(1.8)
                .foregroundStyle(.white)
                .contentTransition(.opacity)
                .id(condition.displayTitle)

            Text("LIVE")
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .tracking(2.2)
                .foregroundStyle(.white.opacity(0.46))
        }
        .transition(.opacity.combined(with: .scale(scale: 0.96)))
    }

    private var ringProgress: CGFloat {
        switch condition {
        case .nominal:
            return 0.28
        case .fair:
            return 0.48
        case .serious:
            return 0.72
        case .critical:
            return 0.94
        case .unknown:
            return 0.12
        }
    }
}
