import SwiftUI
import Logdog

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Logdog().hello()
        }
    }
}

#Preview {
    ContentView()
}
