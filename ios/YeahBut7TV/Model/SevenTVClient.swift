import Foundation
import Apollo

enum SevenTVClientError: Error {
    case networkError(String)
}

class SevenTVClient {
    private let apolloClient: ApolloClient
    
    init (url: URL) {
        self.apolloClient = ApolloClient(url: url)
    }
    
    func searchEmotes(query: SevenTVAPI.SearchEmotesQuery) async throws -> GraphQLResult<SevenTVAPI.SearchEmotesQuery.Data> {
        return try await withCheckedThrowingContinuation{ continuation in
            self.apolloClient.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    continuation.resume(returning: graphQLResult)
                case .failure(let error):
                    continuation.resume(throwing: SevenTVClientError.networkError(error.localizedDescription))
                }
            }
        }
    }
}
