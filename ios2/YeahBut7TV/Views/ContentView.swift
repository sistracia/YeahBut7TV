import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var emote: String = ""
    
    private var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        Form {
            Section {
                HStack {
                    TextField(
                        "Emotes",
                        text: $emote
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    Button {
                        Task {
                            await modelData.searchEmotes(
                                query: SevenTVAPISearchEmotesQuery(query: emote)
                            )
                        }
                    } label: {
                        Text("Search")
                    }
                    .buttonStyle(.borderedProminent)
                }
            } header: {
                Text("Search")
            }
            
            LazyVGrid(columns: gridColumns) {
                ForEach(modelData.emote.emotes.items, id: \.id) { emoteItem in
                    VStack {
                        if let lastEmote = emoteItem.host.files.last {
                            GeometryReader { geo in
                                ImageItem(size:geo.size.width,
                                          url: URL(string: "\(emoteItem.host.url)/\(lastEmote.name)")!,
                                          isAnimated: lastEmote.format != "PNG")
                            }
                            .cornerRadius(8.0)
                            .aspectRatio(1, contentMode: .fit)
                        }
                        Text(emoteItem.name)
                    }
                }
            }
        }
        .task() {
            await modelData.searchEmotes(
                query: SevenTVAPISearchEmotesQuery(query: "")
            )
        }
    }
}

#Preview {
    var modelData = ModelData()
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

