import SwiftUI

struct ThermalDashboardView: View {
    @StateObject private var viewModel = ThermalViewModel()

    var body: some View {
        ZStack {
            BackgroundView(condition: viewModel.condition)

            VStack(spacing: 34) {
                header

                Spacer(minLength: 18)

                ThermalIndicatorView(condition: viewModel.condition)

                Spacer(minLength: 18)

                InfoCardView(
                    condition: viewModel.condition,
                    rawStateText: viewModel.rawStateText,
                    lastUpdatedText: viewModel.lastUpdatedText
                )
            }
            .padding(.horizontal, 22)
            .padding(.top, 22)
            .padding(.bottom, 24)
        }
        .preferredColorScheme(.dark)
        .task {
            viewModel.refresh()
        }
        .animation(
            .spring(response: 0.55, dampingFraction: 0.82),
            value: viewModel.condition
        )
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Тепловое состояние")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Официальный системный уровень iOS")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white.opacity(0.54))
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
