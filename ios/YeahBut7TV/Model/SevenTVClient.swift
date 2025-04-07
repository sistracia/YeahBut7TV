import Foundation
import Apollo

class SevenTVClient {
    private let apolloClient: ApolloClient
    
    init (url: URL) {
        self.apolloClient = ApolloClient(url: url)
    }
    
    func searchEmotes() {
        self.apolloClient.fetch(query: SevenTVAPI.SearchEmotesQuery(query: "", page: 1, sort: .none, limit: 10, filter: .none)) { result in
            switch result {
            case .success(let graphQLResult):
                print("Success! Result: \(graphQLResult)")
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
