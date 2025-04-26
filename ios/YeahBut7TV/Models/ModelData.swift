import Foundation

@MainActor
class ModelData: ObservableObject {
    private let sevenTVClient: SevenTVClient
    
    enum ServerState {
        case idle;
        case loading;
        case error(String);
    }

    @Published var emote = Emote(emotes: Emotes(count: 0, items: []))
    @Published var serverState: ServerState = .idle
    
    @Published var lastQuery: SevenTVAPISearchEmotesQuery = .init()
    @Published var isAllEmotesLoaded = false
    
    init(sevenTVClient: SevenTVClient = SevenTVClient(url: URL(string: "https://7tv-emotes.sistracia.com")!)) {
        self.sevenTVClient = sevenTVClient
    }
    
    @MainActor
    func searchEmotes(query: SevenTVAPISearchEmotesQuery) async {
        self.serverState = .loading
        do {
            let searchEmote = try await self.sevenTVClient.searchEmotes(query: query)
            let emoteCount = searchEmote.emotes.count
            var emoteItems = self.emote.emotes.items
            emoteItems.append(contentsOf: searchEmote.emotes.items)
            
            self.lastQuery = query
            self.emote = Emote(emotes: Emotes(count: emoteCount, items: emoteItems))
            self.serverState = .idle
            self.isAllEmotesLoaded = emoteItems.count >= emoteCount
        } catch(let error) {
            self.serverState = .error(error.localizedDescription)
        }
    }
}
