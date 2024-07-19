
import SwiftUI

struct ContentView: View {
    @State private var networkMonitor = NetworkMonitor()
    var body: some View {
        NavigationView {
            CharacterListView(viewModel: .init(client: RMClientDefault()))
                .environment(networkMonitor)
        }
        .tint(.white)
    }
}
