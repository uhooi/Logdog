import OSLog

extension LogLevel {
    init(osLogLevel: OSLogEntryLog.Level) {
        self = switch osLogLevel {
        case .undefined: .undefined
        case .debug: .debug
        case .info: .info
        case .notice: .notice
        case .error: .error
        case .fault: .fault
        @unknown default: .undefined
        }
    }
}
