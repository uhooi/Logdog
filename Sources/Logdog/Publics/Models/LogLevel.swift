/// ログレベル。
public enum LogLevel: Int, CaseIterable, Sendable {
    /// 未定義。
    case undefined = 0

    /// デバッグ。
    case debug = 1

    /// 情報。
    case info = 2

    /// お知らせ。
    case notice = 3

    /// エラー。
    case error = 4

    /// フォルト。
    case fault = 5
}
