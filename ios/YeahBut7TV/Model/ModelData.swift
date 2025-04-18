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
    
    init(sevenTVClient: SevenTVClient = SevenTVClient(url: URL(string: "https://7tv-emotes.sistracia.com")!)) {
        self.sevenTVClient = sevenTVClient
    }
    
    @MainActor
    func searchEmotes(query: SevenTVAPISearchEmotesQuery) async {
        self.serverState = .loading
        do {
            let searchEmote = try await self.sevenTVClient.searchEmotes(query: query)
            self.emote = searchEmote
            self.serverState = .idle
        } catch(let error) {
            self.serverState = .error(error.localizedDescription)
        }
    }
}
