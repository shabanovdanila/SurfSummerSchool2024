import SwiftUI

struct CharacterListView: View {
    
    @StateObject var viewModel: CharacterListViewModel
    @Environment(NetworkMonitor.self) private var networkMonitor
    
    init(viewModel: CharacterListViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                Text("Rick & Morty Characters")
                    .font(.system(size: 24, weight: .bold))
                    LazyVStack (alignment: .center) {
                        ForEach(viewModel.characters, id:\.id) { item in
                            NavigationLink {
                                CharacterCardView(viewModel: .init(client: viewModel.client, character: item))
                                    .toolbarRole(.editor)
                            } label : {
                                CharacterCellView(character: item)
                            }
                        }
                        lastRowView
                    }
                }
            if !networkMonitor.isConnected {
                NetWorkErrorView()
            }
                
        }
    }
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            if viewModel.canLoadMore {
                ProgressView()
            } else {
                Text("\(viewModel.characters.count) Characters")
            }
        }
        .frame(height: 50)
        .task {
            await viewModel.loadNext()
        }
    }
}
