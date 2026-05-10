import Foundation
import Combine

@MainActor
final class ThermalMonitor: ObservableObject {
    @Published private(set) var thermalState: ProcessInfo.ThermalState
    @Published private(set) var lastUpdated: Date

    private var observer: NSObjectProtocol?
    private let processInfo: ProcessInfo

    init(
        notificationCenter: NotificationCenter = .default,
        processInfo: ProcessInfo = .processInfo
    ) {
        self.processInfo = processInfo
        self.thermalState = processInfo.thermalState
        self.lastUpdated = Date()

        observer = notificationCenter.addObserver(
            forName: ProcessInfo.thermalStateDidChangeNotification,
            object: processInfo,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.refresh()
            }
        }
    }

    deinit {
        if let observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    func refresh() {
        thermalState = processInfo.thermalState
        lastUpdated = Date()
    }
}
