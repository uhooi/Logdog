import Foundation

/// ログエントリ。
public struct LogEntry: Identifiable, Sendable {
    public let id: UUID = .init()

    /// メッセージ。
    public let message: String

    /// 日時。
    public let date: Date

    /// ライブラリ。
    public let library: String

    /// PID。
    public let processIdentifier: String

    /// TID。
    public let threadIdentifier: String

    /// カテゴリ。
    public let category: String

    /// サブシステム。
    public let subsystem: String

    /// ログレベル。
    public let level: LogLevel
}
