import SwiftUI
import SDWebImageSwiftUI

struct ImageItem: View {
    let size: Double
    let url: URL
    let isAnimated: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Group {
                if isAnimated {
                    AnimatedImage(url: url, placeholderImage: nil)
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade)
                        .scaledToFit()
                } else {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .transition(.fade)
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text(phase.error?.localizedDescription ?? "Error")
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
            .frame(width: size, height: size)
        }
    }
}
