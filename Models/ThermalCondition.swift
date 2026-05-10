import SwiftUI

enum ThermalCondition: Equatable {
    case nominal
    case fair
    case serious
    case critical
    case unknown

    init(_ state: ProcessInfo.ThermalState) {
        switch state {
        case .nominal:
            self = .nominal
        case .fair:
            self = .fair
        case .serious:
            self = .serious
        case .critical:
            self = .critical
        @unknown default:
            self = .unknown
        }
    }

    var displayTitle: String {
        switch self {
        case .nominal:
            return "НОРМА"
        case .fair:
            return "ТЕПЛО"
        case .serious:
            return "ГОРЯЧО"
        case .critical:
            return "КРИТИЧНО"
        case .unknown:
            return "НЕИЗВЕСТНО"
        }
    }

    var iconName: String {
        switch self {
        case .nominal:
            return "checkmark.circle.fill"
        case .fair:
            return "thermometer.medium"
        case .serious:
            return "thermometer.high"
        case .critical:
            return "exclamationmark.triangle.fill"
        case .unknown:
            return "questionmark.circle.fill"
        }
    }

    var explanation: String {
        switch self {
        case .nominal:
            return "Система работает в нормальном тепловом режиме."
        case .fair:
            return "Устройство стало теплее, но работа должна оставаться стабильной."
        case .serious:
            return "Устройство горячее. iOS может снижать производительность для защиты."
        case .critical:
            return "Критическая тепловая нагрузка. iOS может сильно ограничивать активность."
        case .unknown:
            return "iOS вернула неизвестное тепловое состояние."
        }
    }

    var accentColor: Color {
        switch self {
        case .nominal:
            return Color(red: 0.56, green: 0.78, blue: 0.64)
        case .fair:
            return Color(red: 0.86, green: 0.72, blue: 0.46)
        case .serious:
            return Color(red: 0.88, green: 0.48, blue: 0.34)
        case .critical:
            return Color(red: 0.92, green: 0.30, blue: 0.30)
        case .unknown:
            return Color(red: 0.52, green: 0.52, blue: 0.56)
        }
    }

    var backgroundTint: Color {
        switch self {
        case .nominal:
            return Color(red: 0.12, green: 0.20, blue: 0.16)
        case .fair:
            return Color(red: 0.22, green: 0.18, blue: 0.10)
        case .serious:
            return Color(red: 0.22, green: 0.11, blue: 0.08)
        case .critical:
            return Color(red: 0.24, green: 0.06, blue: 0.06)
        case .unknown:
            return Color(red: 0.10, green: 0.10, blue: 0.12)
        }
    }

    var intensity: Double {
        switch self {
        case .nominal:
            return 0.22
        case .fair:
            return 0.36
        case .serious:
            return 0.52
        case .critical:
            return 0.68
        case .unknown:
            return 0.18
        }
    }

    var scale: CGFloat {
        switch self {
        case .nominal:
            return 1.0
        case .fair:
            return 1.015
        case .serious:
            return 1.03
        case .critical:
            return 1.045
        case .unknown:
            return 1.0
        }
    }
}
