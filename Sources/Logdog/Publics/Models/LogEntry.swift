import Foundation

public struct LogEntry: Sendable {
    public let message: String
    public let date: Date
    public let library: String
    public let processIdentifier: String
    public let threadIdentifier: String
    public let category: String
    public let subsystem: String
    public let level: LogLevel
}
