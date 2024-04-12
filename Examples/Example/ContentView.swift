import SwiftUI
import LogDog

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
            LogDog().hello()
        }
    }
}

#Preview {
    ContentView()
}
