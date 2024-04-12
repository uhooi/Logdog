public enum Metadata: CaseIterable, Identifiable, Sendable {
    case type
    case timestamp
    case library
    case pidAndTid
    case subsystem
    case category

    public var id: Self { self }
}
