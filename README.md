# Logdog :dog:

[![CI](https://github.com/uhooi/Logdog/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/uhooi/Logdog/actions/workflows/ci.yml)
[![CI examples](https://github.com/uhooi/Logdog/actions/workflows/ci-examples.yml/badge.svg?branch=main)](https://github.com/uhooi/Logdog/actions/workflows/ci-examples.yml)
[![Release](https://img.shields.io/github/v/release/uhooi/Logdog)](https://github.com/uhooi/Logdog/releases/latest)
[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fuhooi%2FLogdog%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/uhooi/Logdog)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fuhooi%2FLogdog%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/uhooi/Logdog)
[![License](https://img.shields.io/github/license/uhooi/Logdog)](https://github.com/uhooi/Logdog/blob/main/LICENSE)
[![X](https://img.shields.io/twitter/follow/the_uhooi?style=social)](https://twitter.com/the_uhooi)

OSログをいい感じに表示するビューと、OSログを表示するための薄いラッパーを提供するパッケージです。

## 目次

- [システム要件](#システム要件)
- [インストール](#インストール)
- [使い方](#使い方)
- [貢献](#貢献)
- [スタッツ](#スタッツ)

## システム要件

- Xcode: 15.3+
- macOS: 14.0+

## インストール

### Swift Package Manager

#### Package

本パッケージを `Package.swift` に追加し、ターゲットの依存関係に含めます。

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/uhooi/Logdog", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "<your-target-name>",
            dependencies: [
                "Logdog", // ビューを自作する場合
                "LogdogUI", // ビューを使用する場合
            ]),
    ]
)
```

#### Xcode

本パッケージはXcode上で追加できます。

詳細は [ドキュメント](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app) をご参照ください。

## 使い方

### OSログの出力

本パッケージはOSログを確認するために存在します。  
そのため、まずはOSログを出力します。

以下のようなラッパーを用意すると便利です。

```swift
import Foundation
import os

enum Logger {
    nonisolated(unsafe) static let yourCategoryName: os.Logger = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "<your-category-name>"
    )
}
```

あとは `Logger.yourCategoryName` から `os.Logger` のメソッドを呼び出すだけです。

```swift
let message = "Foo"
Logger.yourCategoryName.debug("\(message, privacy: .public)")
```

詳細は以下の記事をご参照ください。  
[os.Loggerの説明と使い方(Swift) #Swift - Qiita](https://qiita.com/uhooi/items/2e4f6dc4600ca0d7c07b)

### OSログの表示

ここから本パッケージを使います。

#### ビューを使用する場合（オススメ）

`LogdogUI` ライブラリを使うと、OSログを表示するビューを簡単に追加できます。

```swift
import SwiftUI
import LogdogUI

struct ContentView: View {
    var body: some View {
        LogdogScreen()
    }
}
```

`LogScreen()` を呼び出すだけです。超簡単です。

#### ビューを自作する場合

`Logdog` ライブラリを使うと、OSログを整形したデータを簡単に取得できます。

```swift
import Logdog

struct LogdogScreen: View {
    @State private var entries: [LogEntry] = []
    private let logStore = LogStore()

    var body: some View {
        List {
            ForEach(entries, id: \.date) { entry in
                Text(entry.message)
            }
        }
        .task {
            entries = try? await logStore.entries()
        }
    }
}
```

`LogdogUI` ライブラリのために作ったものを公開しているだけなので、必要最低限の機能しか提供していません。

## 貢献

貢献をお待ちしています :relaxed:

- [新しいイシュー](https://github.com/uhooi/Logdog/issues/new)
- [新しいプルリクエスト](https://github.com/uhooi/Logdog/compare)

## スタッツ

[![スタッツ](https://repobeats.axiom.co/api/embed/402bd4c24a179fe7d29be33db37daa412656d080.svg "Repobeats analytics image")](https://github.com/uhooi/Logdog)
