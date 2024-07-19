import SwiftUI

struct NetWorkErrorView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("ConnectionError")
                .resizable()
                .scaledToFit()
                .frame(width: 263, height: 263)
                .padding(.top, 120)
            Text("Network Error")
                .font(.system(size: 28, weight: .semibold))
                .padding(.top, 56)
                .padding(.bottom, 5)
            Text("There was an error connecting.")
                .foregroundColor(Color.RMColor.lightGray)
                .font(.system(size: 16, weight: .regular))
            Text("Please check your internet.")
                .foregroundColor(Color.RMColor.lightGray)
                .font(.system(size: 16, weight: .regular))
            Spacer()
        }
        .allowsHitTesting(false)
        .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
        .background(.black)
    }
}
