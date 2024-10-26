import SwiftUI
import Logdog

/// ログ一覧画面。
public struct LogdogScreen: View {
    @State private var entries: [LogEntry] = []
    @State private var subsystems: Set<String> = []
    @State private var subsystemSearchScope: SubsystemSearchScope = .all
    @State private var categories: Set<String> = []
    @State private var categorySearchScope: CategorySearchScope = .all
    @State private var levelSearchScope: LogLevel = .undefined
    @State private var query = ""
    @State private var shouldShowMetadata = false
    @State private var selectedMetadata: Set<Metadata> = []
    @State private var isLoading = false

    private let logStore = LogStore()

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Menu {
                            Picker(selection: $subsystemSearchScope) {
                                Text("All", bundle: .module)
                                    .tag(SubsystemSearchScope.all)

                                ForEach(sortedSubsystems, id: \.self) { subsystem in
                                    Text(subsystem)
                                        .tag(SubsystemSearchScope.subsystem(subsystem))
                                }
                            } label: {
                                Text("Subsystem", bundle: .module)
                            }
                        } label: {
                            HStack(spacing: 2) {
                                Image(systemName: Metadata.subsystem.iconName) // swiftlint:disable:this accessibility_label_for_image

                                Text(subsystemSearchScope.text)
                                    .lineLimit(1)
                            }
                        }

                        Menu {
                            Picker(selection: $categorySearchScope) {
                                Text("All", bundle: .module)
                                    .tag(CategorySearchScope.all)

                                ForEach(sortedCategories, id: \.self) { category in
                                    Text(category)
                                        .tag(CategorySearchScope.category(category))
                                }
                            } label: {
                                Text("Category", bundle: .module)
                            }
                        } label: {
                            HStack(spacing: 2) {
                                Image(systemName: Metadata.category.iconName) // swiftlint:disable:this accessibility_label_for_image

                                Text(categorySearchScope.text)
                                    .lineLimit(1)
                            }
                        }

                        Menu {
                            Picker(selection: $levelSearchScope) {
                                ForEach(LogLevel.allCases, id: \.self) { logLevel in
                                    LabeledContent(logLevel.text) {
                                        Image(systemName: logLevel.iconName) // swiftlint:disable:this accessibility_label_for_image
                                    }
                                    .tag(logLevel)
                                }
                            } label: {
                                Text("Log level", bundle: .module)
                            }
                        } label: {
                            HStack(spacing: 2) {
                                Image(systemName: "note.text") // swiftlint:disable:this accessibility_label_for_image

                                Text(levelSearchScope.text)
                                    .lineLimit(1)
                            }
                        }
                    }
                }

                Menu {
                    Toggle(
                        String(localized: "Metadata", bundle: .module),
                        isOn: $shouldShowMetadata
                    )

                    Divider()

                    ForEach(Metadata.allCases) { metadata in
                        Toggle(
                            metadata.text,
                            systemImage: metadata.iconName,
                            isOn: .init(get: {
                                selectedMetadata.contains(metadata)
                            }, set: { newValue in
                                if newValue {
                                    selectedMetadata.insert(metadata)
                                } else {
                                    selectedMetadata.remove(metadata)
                                }
                            })
                        )
                    }
                    .disabled(!shouldShowMetadata)
                } label: {
                    Image(systemName: "switch.2") // swiftlint:disable:this accessibility_label_for_image
                }
                .menuActionDismissBehaviorDisabledIfAvailable()
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 8)
            .disabled(isLoading)

            Divider()

            Group {
                if isLoading {
                    ProgressView()
                } else {
                    List {
                        ForEach(filteredEntries) { entry in
                            LogRowView(
                                entry: entry,
                                shouldShowType: shouldShowMetadata && selectedMetadata.contains(.type),
                                shouldShowTimestamp: shouldShowMetadata && selectedMetadata.contains(.timestamp),
                                shouldShowLigrary: shouldShowMetadata && selectedMetadata.contains(.library),
                                shouldShowPidAndTid: shouldShowMetadata && selectedMetadata.contains(.pidAndTid),
                                shouldShowSubsystem: shouldShowMetadata && selectedMetadata.contains(.subsystem),
                                shouldShowCategory: shouldShowMetadata && selectedMetadata.contains(.category)
                            )
                            .listRowBackground(entry.level.backgroundColor)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .searchable(
            text: $query,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .task {
            isLoading = true
            do {
                entries = try await logStore.entries()
                subsystems = Set(entries.map({ $0.subsystem }))
                categories = Set(entries.map({ $0.category }))
            } catch {
                print(error)
            }
            isLoading = false
        }
    }

    public init() {}
}

// MARK: - Privates

private enum SubsystemSearchScope: Hashable {
    case all
    case subsystem(String)

    var text: String {
        switch self {
        case .all: .init(localized: "All", bundle: .module)
        case let .subsystem(subsystem): subsystem
        }
    }
}

private enum CategorySearchScope: Hashable {
    case all
    case category(String)

    var text: String {
        switch self {
        case .all: .init(localized: "All", bundle: .module)
        case let .category(category): category
        }
    }
}

private extension LogdogScreen {
    var filteredEntries: [LogEntry] {
        let filteredEntries: [LogEntry] = entries
            .filter {
                switch subsystemSearchScope {
                case .all: true
                case let .subsystem(subsystem): $0.subsystem == subsystem
                }
            }
            .filter {
                switch categorySearchScope {
                case .all: true
                case let .category(category): $0.category == category
                }
            }
            .filter {
                $0.level.rawValue >= levelSearchScope.rawValue
            }

        let trimmedQuery = query.trimmingCharacters(in: .whitespaces)
        return trimmedQuery.isEmpty ? filteredEntries : filteredEntries.filter { $0.message.range(of: trimmedQuery, options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive]) != nil }
    }

    var sortedSubsystems: [String] {
        Array(subsystems)
            .sorted { $0 < $1 }
    }

    var sortedCategories: [String] {
        Array(categories)
            .sorted { $0 < $1 }
    }
}

private extension View {
    @ViewBuilder
    func menuActionDismissBehaviorDisabledIfAvailable() -> some View {
        if #available(iOS 16.4, *) {
            menuActionDismissBehavior(.disabled)
        } else {
            self
        }
    }
}

// MARK: - Previews

#if DEBUG
#Preview {
    NavigationStack {
        LogdogScreen()
            .navigationTitle(String(localized: "Log", bundle: .module))
            .navigationBarTitleDisplayMode(.inline)
    }
}
#endif
