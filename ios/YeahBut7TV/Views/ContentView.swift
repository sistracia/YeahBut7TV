import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var modelData: ModelData
    
    @State private var sharedFilePreviewName: String = ""
    @State private var sharedFilePreviewURL: URL? = nil
    @State private var sharedFileURL: URL? = nil
    @State private var loadingSharedFile: Bool = false
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var isEmoteLoading: Bool {
        switch modelData.serverState {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
        let isAnySharedFileURL = Binding(
            get: {
                return sharedFileURL != nil
            },
            set: { value in
                sharedFileURL = value ? sharedFileURL : nil
            }
        )
        
        Form {
            Section {
                SearchSection()
            } header: {
                Text("Search")
            }
            
            Section {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(modelData.emote.emotes.items, id: \.id) { emoteItem in
                            GridItemView(emoteItem: emoteItem) { fileName, url in
                                sharedFilePreviewName = fileName
                                sharedFilePreviewURL = url
                                downloadGIF(fileName, from: url)
                            }
                        }
                    }
                }
            } header: {
                Text("\(modelData.emote.emotes.count) Emotes")
            }
        }
        .overlay {
            if isEmoteLoading || loadingSharedFile {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .overlay(ProgressView())
            }
        }
        .sheet(isPresented: isAnySharedFileURL) {
            if let sharedFileURL = sharedFileURL,
               let sharedFilePreviewURL = sharedFilePreviewURL {
                VStack(alignment: .center) {
                    GeometryReader { geo in
                        VStack {
                            ImageItem(size: geo.size.width * 0.8,
                                      url: sharedFilePreviewURL,
                                      isAnimated: sharedFilePreviewURL.absoluteString.hasSuffix(".gif"))
                            Text(sharedFilePreviewName)
                        }
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)
                    }
                    
                    ShareLink(item: sharedFileURL) {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
        .task() {
            await modelData.searchEmotes(
                query: SevenTVAPISearchEmotesQuery(query: "")
            )
        }
    }
    
    // Thanks to Grok
    func downloadGIF(_ fileName: String, from url: URL) {
        loadingSharedFile = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading GIF: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let tempDirectory = FileManager.default.temporaryDirectory
            let fileURL = tempDirectory.appendingPathComponent(fileName)
            
            do {
                try data.write(to: fileURL)
                DispatchQueue.main.async {
                    self.sharedFileURL = fileURL
                }
            } catch {
                print("Error saving GIF: \(error.localizedDescription)")
            }
            
            loadingSharedFile = false
        }.resume()
    }
}

#Preview {
    let modelData = ModelData()
    modelData.emote = Emote(emotes: Emotes(count: 10,
                                           items: [
                                            .init(id: "01F6MZGCNG000255K4X1K7NTHR",
                                                  name: "GIGACHAD",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F6MZGCNG000255K4X1K7NTHR",
                                                                      files: [
                                                                        .init(name: "4x.gif", width: 128, height: 128, format: "GIF")
                                                                      ])),
                                            .init(id: "01F6MKTFTG0009C9ZSNZTFV2ZF",
                                                  name: "NOOOO",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F6MKTFTG0009C9ZSNZTFV2ZF",
                                                                      files: [
                                                                        .init(name: "4x.gif", width: 128, height: 128, format: "GIF")
                                                                      ])),
                                            .init(id: "01F6MQ33FG000FFJ97ZB8MWV52",
                                                  name: "catJAM",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F6MQ33FG000FFJ97ZB8MWV52",
                                                                      files: [
                                                                        .init(name: "4x.gif", width: 128, height: 128, format: "GIF")
                                                                      ])),
                                            .init(id: "01F6N31ETR0004P7N4A9PKS5X9",
                                                  name: "BOOBA",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F6N31ETR0004P7N4A9PKS5X9",
                                                                      files: [
                                                                        .init(name: "4x.gif", width: 128, height: 128, format: "GIF")
                                                                      ])),
                                            .init(id: "01F6ME7ADR0000WDA7ERT9H30R",
                                                  name: "COPIUM",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F6ME7ADR0000WDA7ERT9H30R",
                                                                      files: [
                                                                        .init(name: "4x.gif", width: 128, height: 128, format: "GIF")
                                                                      ])),
                                            .init(id: "01F6NACCD80006SZ7ZW5FMWKWK",
                                                  name: "Prayge",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F6NACCD80006SZ7ZW5FMWKWK",
                                                                      files: [
                                                                        .init(name: "4x.png", width: 128, height: 128, format: "PNG")
                                                                      ])),
                                            .init(id: "01F00Z3A9G0007E4VV006YKSK9",
                                                  name: "OMEGALUL",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F00Z3A9G0007E4VV006YKSK9",
                                                                      files: [
                                                                        .init(name: "4x.png", width: 128, height: 128, format: "PNG")
                                                                      ])),
                                            .init(id: "01F6MXJD8R000F76KNAAV5HDGD",
                                                  name: "Bedge",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F6MXJD8R000F76KNAAV5HDGD",
                                                                      files: [
                                                                        .init(name: "4x.png", width: 128, height: 128, format: "PNG")
                                                                      ])),
                                            .init(id: "01F5VW2TKR0003RCV2Z6JBHCST",
                                                  name: "catKISS",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F5VW2TKR0003RCV2Z6JBHCST",
                                                                      files: [
                                                                        .init(name: "4x.gif", width: 128, height: 128, format: "GIF")
                                                                      ])),
                                            .init(id: "01F6MDFCSR0000WDA7ERT623YT",
                                                  name: "NODDERS",
                                                  host: EmoteItemHost(url: "https://cdn.7tv.app/emote/01F6MDFCSR0000WDA7ERT623YT",
                                                                      files: [
                                                                        .init(name: "4x.gif", width: 128, height: 128, format: "GIF")
                                                                      ])),
                                           ]))
    
    return ContentView()
        .environmentObject(modelData)
}

