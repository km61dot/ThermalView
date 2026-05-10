import Foundation

extension DateFormatter {
    static let thermalTime: DateFormatter = {
        let formatter = DateFormatter()

        formatter.locale = Locale.current
        formatter.dateStyle = .none
        formatter.timeStyle = .medium

        return formatter
    }()
}
