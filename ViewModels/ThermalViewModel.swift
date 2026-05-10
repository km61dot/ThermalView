import Foundation
import Combine

@MainActor
final class ThermalViewModel: ObservableObject {
    @Published private(set) var condition: ThermalCondition
    @Published private(set) var rawStateText: String
    @Published private(set) var lastUpdatedText: String

    private let monitor: ThermalMonitor
    private var cancellables = Set<AnyCancellable>()

    init() {
        let monitor = ThermalMonitor()

        self.monitor = monitor
        self.condition = ThermalCondition(monitor.thermalState)
        self.rawStateText = monitor.thermalState.rawDescription
        self.lastUpdatedText = DateFormatter.thermalTime.string(from: monitor.lastUpdated)

        bind()
    }

    func refresh() {
        monitor.refresh()
    }

    private func bind() {
        monitor.$thermalState
            .combineLatest(monitor.$lastUpdated)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state, date in
                self?.condition = ThermalCondition(state)
                self?.rawStateText = state.rawDescription
                self?.lastUpdatedText = DateFormatter.thermalTime.string(from: date)
            }
            .store(in: &cancellables)
    }
}

private extension ProcessInfo.ThermalState {
    var rawDescription: String {
        switch self {
        case .nominal:
            return "ProcessInfo.ThermalState.nominal"
        case .fair:
            return "ProcessInfo.ThermalState.fair"
        case .serious:
            return "ProcessInfo.ThermalState.serious"
        case .critical:
            return "ProcessInfo.ThermalState.critical"
        @unknown default:
            return "ProcessInfo.ThermalState.unknown"
        }
    }
}
