import SwiftUI

struct CharacterCellView: View {
    let character: RMCharacter
    var body: some View {
        HStack(alignment: .center) {
            CachedAsyncImage(url: URL(string: character.image)!) { image in
                image
                    .resizable()
                    .aspectRatio(84 / 64, contentMode: .fill)
            } placeholder: {
                ProgressView()
                    .controlSize(.regular)
            }
            .frame(maxWidth: 84, maxHeight: 64)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .lineLimit(1)
                    .font(.system(size: 18, weight: .medium))
                Text(character.status.capitalized)
                    .foregroundColor(coloredStatus(status: character.status))
                    .font(.system(size: 12, weight: .semibold))
                + Text(" • " + character.species)
                    .font(.system(size: 12, weight: .semibold))
                Text(character.gender.capitalized)
                    .font(.system(size: 12, weight: .regular))
            }
            Spacer()
        }
        .padding()
        .frame(width: 353, height: 96)
        .background(Color.RMColor.black)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    func coloredStatus(status: String) -> Color {
        switch status {
        case "Alive" :
            Color.RMColor.green
        case "Dead" :
            Color.RMColor.red
        case "unknown" :
            Color.RMColor.gray
        default:
            Color.white
        }
    }
}
