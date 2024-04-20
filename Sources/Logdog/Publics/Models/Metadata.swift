/// メタデータ。
public enum Metadata: CaseIterable, Identifiable, Sendable {
    /// タイプ。
    case type

    /// タイムスタンプ。
    case timestamp

    /// ライブラリ。
    case library

    /// PID:TID。
    case pidAndTid

    /// サブシステム。
    case subsystem

    /// カテゴリ。
    case category

    public var id: Self { self }
}
