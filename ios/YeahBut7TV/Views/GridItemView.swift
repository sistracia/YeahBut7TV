import SwiftUI

struct GridItemView: View {
    let emoteItem: EmoteItem
    let onTap: (String, URL) -> Void
    
    @State private var isTapped: Bool = false
    
    var body: some View {
        if let lastEmote = emoteItem.host.files.last,
           let emoteURL = URL(string: "https:\(emoteItem.host.url)/\(lastEmote.name)") {
            VStack {
                GeometryReader { geo in
                    ImageItem(size:geo.size.width,
                              url: emoteURL,
                              isAnimated: lastEmote.format != "PNG")
                }
                .cornerRadius(8.0)
                .aspectRatio(1, contentMode: .fit)
                Text(emoteItem.name)
            }
            .background(isTapped ? Color.gray.opacity(0.4) : Color.gray.opacity(0.0))
            .cornerRadius(10)
            .scaleEffect(isTapped ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isTapped)
            .onTapGesture {
                withAnimation {
                    isTapped = true
                }
                // Reset after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation {
                        isTapped = false
                    }
                }
                
                onTap("\(emoteItem.name).\(lastEmote.format.lowercased())", emoteURL)
            }
        }
    }
}
