import SwiftUI

struct CharacterCardView: View {
    
    @StateObject private var viewModel: CharacterCardViewModel
    
    private var character: RMCharacter {
        viewModel.character
    }
    
    init(viewModel: CharacterCardViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            CachedAsyncImage(url: URL(string: character.image)!) { image in
                image
                    .resizable()
                    .aspectRatio(320 / 320, contentMode: .fill)
            } placeholder: {
                ProgressView()
                    .controlSize(.regular)
            }
            .frame(width: 320, height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            Text(character.status.capitalized(with: nil))
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 320, height: 42)
                .background(character.color)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Species: ")
                        .font(.system(size: 16, weight: .semibold))
                    + Text("\(character.species)")
                        .font(.system(size: 16, weight: .regular))
                    Text("Gender: ")
                        .font(.system(size: 16, weight: .semibold))
                    + Text("\(character.gender.capitalized)")
                        .font(.system(size: 16, weight: .regular))
                    if viewModel.isLoadingEpisodes {
                        ProgressView()
                    } else {
                        if let error = viewModel.error {
                            if let apiError = error as? ApiPerformerError, apiError == .DecodeError {
                                Text("Error")
                            } else {
                                Text("Episodes: Need Internet Connection...")
                            }
                        } else {
                            Text("Episodes: ")
                                .font(.system(size: 16, weight: .semibold))
                            + Text("\(viewModel.episodes.joined(separator: ", "))")
                                .font(.system(size: 16, weight: .regular))
                        }
                    }
                    Text("Last known location: ")
                        .font(.system(size: 16, weight: .semibold))
                    + Text("\(character.location.name)")
                        .font(.system(size: 16, weight: .light))
                }
                Spacer()
            }
        }
        .padding(20)
        .background(Color.RMColor.black.clipShape(RoundedRectangle (cornerRadius: 24)) )
        .padding(16)
        .navigationTitle(character.name)
        .task {
            await viewModel.loadEpisodes()
        }
        Spacer()
    }
}

extension RMCharacter {
    var color: Color {
        switch status {
        case "Alive":
                .RMColor.green
        case "Dead":
                .RMColor.red
        case "unknown":
                .RMColor.gray
        default:
                .white
        }
    }
}
