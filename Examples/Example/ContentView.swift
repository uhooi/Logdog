import SwiftUI
import LogdogUI

struct ContentView: View {
    var body: some View {
        LogdogScreen()
            .navigationTitle(String(localized: "Log"))
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
