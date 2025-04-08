import Foundation

@MainActor
class ModelData: ObservableObject {
    private let sevenTVClient: SevenTVClient
    
    enum ServerState {
        case idle;
        case loading;
        case error(String);
    }
    
    @Published var emotes = [SevenTVAPI.SearchEmotesQuery.Data.Emotes.Item]()
    @Published var serverState: ServerState = .idle
    
    init(sevenTVClient: SevenTVClient = SevenTVClient(url: URL(string: "https://7tv.io/v3/gql")!)) {
        self.sevenTVClient = sevenTVClient
    }
    
    @MainActor
    func searchEmotes(query: SevenTVAPI.SearchEmotesQuery) async {
        self.serverState = .loading
        do {
            let searchEmotes = try await self.sevenTVClient.searchEmotes(query: query)
            self.emotes = searchEmotes.data?.emotes.items ?? []
            self.serverState = .idle
        } catch(let err) {
            self.serverState = .error(err.localizedDescription)
        }
    }
}
