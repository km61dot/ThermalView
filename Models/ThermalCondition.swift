import SwiftUI

enum ThermalCondition: Equatable, CaseIterable {
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
        case .nominal: return "Норма"
        case .fair: return "Тепло"
        case .serious: return "Горячо"
        case .critical: return "Критично"
        case .unknown: return "Неизвестно"
        }
    }

    var shortStatus: String {
        switch self {
        case .nominal: return "iPhone работает без тепловых ограничений"
        case .fair: return "Нагрузка есть, но всё стабильно"
        case .serious: return "iOS может снижать частоты"
        case .critical: return "Нужна пауза и охлаждение"
        case .unknown: return "Состояние не распознано"
        }
    }

    var recommendation: String {
        switch self {
        case .nominal:
            return "Можно играть, снимать видео, заряжать и пользоваться навигацией без специальных действий."
        case .fair:
            return "Если телефон нагревается дальше, снизь яркость, убери чехол и не держи его на солнце."
        case .serious:
            return "Лучше остановить тяжёлые игры, съёмку 4K, навигацию и зарядку до снижения температуры."
        case .critical:
            return "Положи телефон в прохладное место, отключи нагрузку и не заряжай, пока состояние не улучшится."
        case .unknown:
            return "Обнови показатель. Если статус не меняется, проверь позже на реальном устройстве."
        }
    }

    var technicalName: String {
        switch self {
        case .nominal: return "nominal"
        case .fair: return "fair"
        case .serious: return "serious"
        case .critical: return "critical"
        case .unknown: return "unknown"
        }
    }

    var iconName: String {
        switch self {
        case .nominal: return "checkmark.seal.fill"
        case .fair: return "thermometer.medium"
        case .serious: return "flame.fill"
        case .critical: return "exclamationmark.triangle.fill"
        case .unknown: return "questionmark.circle.fill"
        }
    }

    var accentColor: Color {
        switch self {
        case .nominal: return Color(red: 0.33, green: 0.88, blue: 0.62)
        case .fair: return Color(red: 1.00, green: 0.73, blue: 0.30)
        case .serious: return Color(red: 1.00, green: 0.43, blue: 0.26)
        case .critical: return Color(red: 1.00, green: 0.20, blue: 0.24)
        case .unknown: return Color(red: 0.55, green: 0.62, blue: 0.72)
        }
    }

    var backgroundTint: Color {
        switch self {
        case .nominal: return Color(red: 0.03, green: 0.18, blue: 0.15)
        case .fair: return Color(red: 0.20, green: 0.14, blue: 0.04)
        case .serious: return Color(red: 0.22, green: 0.08, blue: 0.04)
        case .critical: return Color(red: 0.22, green: 0.03, blue: 0.05)
        case .unknown: return Color(red: 0.07, green: 0.09, blue: 0.13)
        }
    }

    var progress: CGFloat {
        switch self {
        case .nominal: return 0.25
        case .fair: return 0.50
        case .serious: return 0.74
        case .critical: return 0.94
        case .unknown: return 0.12
        }
    }
}
