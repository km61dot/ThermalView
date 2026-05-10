import SwiftUI

struct InfoCardView: View {
    let condition: ThermalCondition
    let rawStateText: String
    let lastUpdatedText: String

    var body: some View {
        VStack(spacing: 16) {
            StatusRowView(
                title: "Системное значение",
                value: rawStateText
            )

            Divider()
                .overlay(Color.white.opacity(0.08))

            StatusRowView(
                title: "Обновлено",
                value: lastUpdatedText
            )

            Divider()
                .overlay(Color.white.opacity(0.08))

            VStack(alignment: .leading, spacing: 8) {
                Text("Описание")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.48))

                Text(condition.explanation)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.white.opacity(0.82))
                    .fixedSize(horizontal: false, vertical: true)
                    .contentTransition(.opacity)
                    .id(condition.explanation)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white.opacity(0.055))
                .background {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .opacity(0.58)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.16),
                                    Color.white.opacity(0.04),
                                    condition.accentColor.opacity(0.12)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
        }
        .shadow(color: Color.black.opacity(0.35), radius: 28, x: 0, y: 18)
        .animation(.easeInOut(duration: 0.35), value: condition)
    }
}
