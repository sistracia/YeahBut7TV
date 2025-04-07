import Foundation

class ModelData: ObservableObject {
    private let sevenTVClient: SevenTVClient
    
    init(sevenTVClient: SevenTVClient = SevenTVClient(url: URL(string: "https://7tv.io/v3/gql")!)) {
        self.sevenTVClient = sevenTVClient
    }
    
    func searchEmotes() {
        self.sevenTVClient.searchEmotes()
    }
}
