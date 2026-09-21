import SwiftUI

struct ThermalDashboardView: View {
    @StateObject private var viewModel = ThermalViewModel()
    @State private var isAboutPresented = false

    var body: some View {
        ZStack {
            BackgroundView(condition: viewModel.condition)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    header

                    ThermalIndicatorView(condition: viewModel.condition)
                        .padding(.top, 8)

                    quickCards

                    RecommendationCard(condition: viewModel.condition)

                    InfoCardView(
                        condition: viewModel.condition,
                        lastUpdatedText: viewModel.lastUpdatedText,
                        onRefresh: viewModel.refresh
                    )

                    Text("Показатель берётся из официального thermalState iOS")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.38))
                        .padding(.top, 4)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 26)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $isAboutPresented) {
            AboutView(condition: viewModel.condition)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .task { viewModel.refresh() }
        .animation(.spring(response: 0.55, dampingFraction: 0.84), value: viewModel.condition)
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text("ThermalView")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Температурное состояние iPhone")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white.opacity(0.52))
            }

            Spacer()

            Button {
                isAboutPresented = true
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.82))
                    .frame(width: 46, height: 46)
                    .background(.white.opacity(0.08), in: Circle())
            }
            .accessibilityLabel("О приложении")
        }
    }

    private var quickCards: some View {
        HStack(spacing: 12) {
            MetricTile(
                title: "Уровень",
                value: viewModel.condition.displayTitle,
                icon: viewModel.condition.iconName,
                color: viewModel.condition.accentColor
            )

            MetricTile(
                title: "Обновлено",
                value: viewModel.lastUpdatedText,
                icon: "clock.fill",
                color: .white.opacity(0.75)
            )
        }
    }
}

private struct MetricTile: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 34, height: 34)
                .background(color.opacity(0.14), in: Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.46))

                Text(value)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 1)
        }
    }
}

private struct RecommendationCard: View {
    let condition: ThermalCondition

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Что делать", systemImage: "sparkles")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white.opacity(0.72))

            Text(condition.recommendation)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.white.opacity(0.92))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(condition.accentColor.opacity(0.13), in: RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(condition.accentColor.opacity(0.24), lineWidth: 1)
        }
    }
}

private struct AboutView: View {
    let condition: ThermalCondition

    var body: some View {
        NavigationStack {
            List {
                Section("Что показывает") {
                    Text("ThermalView показывает официальный системный thermalState, который iOS использует для оценки тепловой нагрузки устройства.")
                    Text("Это не градусы Цельсия и не датчик батареи. Apple отдаёт только уровни: nominal, fair, serious и critical.")
                }

                Section("Текущий технический статус") {
                    LabeledContent("iOS thermalState", value: condition.technicalName)
                }

                Section("Сборка") {
                    Text("IPA собирается неподписанным через GitHub Actions. Подпись выполняется отдельно в ESign личным сертификатом.")
                }
            }
            .navigationTitle("О приложении")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
    }
}
