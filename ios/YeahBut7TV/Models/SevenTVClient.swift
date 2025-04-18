import Foundation

enum SevenTVClientError: Error {
    case networkError(String)
}

struct SevenTVAPISearchEmotesQuery  {
    var query: String = ""
    var page: Int = 1
    var limit: Int = 100
    var caseSensitive: Bool = false
    var exactMatch: Bool = false
}

struct Emote {
    let emotes: Emotes
}

extension Emote: Decodable {
    enum CodingKeys: String, CodingKey {
        case emotes
    }
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.emotes = try values.decode(Emotes.self, forKey: .emotes)
    }
}

struct Emotes {
    let count: Int
    let items: [EmoteItem]
}

extension Emotes: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decode(Int.self, forKey: .count)
        self.items = try values.decode([EmoteItem].self, forKey: .items)
    }
}

struct EmoteItem {
    let id: String
    let name: String
    let host: EmoteItemHost
}

extension EmoteItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case host
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.host = try container.decode(EmoteItemHost.self, forKey: .host)
    }
}

struct EmoteItemHost {
    let url: String
    let files: [EmoteFile]
}

extension EmoteItemHost: Decodable {
    enum CodingKeys: String, CodingKey {
        case url
        case files
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.files = try container.decode([EmoteFile].self, forKey: .files)
    }
}

struct EmoteFile {
    let name: String
    let width: Int
    let height: Int
    let format: String
}

extension EmoteFile: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case width
        case height
        case format
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.format = try container.decode(String.self, forKey: .format)
    }
}

class SevenTVClient {
    private let url: URL
    private let session: URLSession
    private let validStatuses = 200..<300
    
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    init (url: URL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }
    
    func httpRequest(path: String, queryItems: [URLQueryItem]? = nil) async throws -> Data {
        guard let url = URL(string: path, relativeTo: self.url) else {
            throw SevenTVClientError.networkError("Invalid request URL")
        }
        
        
        guard var urlCompoents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw SevenTVClientError.networkError("Invalid URL component")
        }
        
        urlCompoents.queryItems = queryItems
        
        guard let urlWithQueryItems = urlCompoents.url else {
            throw SevenTVClientError.networkError("Invalid URL query")
        }
        
        var request = URLRequest(url: urlWithQueryItems)
        request.httpMethod = "GET"
        request.setValue("accept", forHTTPHeaderField: "application/json")
        
        guard let (data, response) = try await self.session.data(for: request) as? (Data, HTTPURLResponse),
              validStatuses.contains(response.statusCode)
        else {
            throw SevenTVClientError.networkError("Invalid status code")
        }
        
        return data
    }
    
    func searchEmotes(query: SevenTVAPISearchEmotesQuery) async throws -> Emote {
        let result = try await self.httpRequest(path: "/search-emotes",
                                                queryItems: [
                                                    .init(name: "query", value: query.query),
                                                    .init(name: "page", value: String(query.page)),
                                                    .init(name: "limit", value: String(query.limit)),
                                                    .init(name: "case_sensitive", value: String(query.caseSensitive)),
                                                    .init(name: "exact_match", value: String(query.exactMatch)),
                                                ])
        
        return try self.jsonDecoder.decode(Emote.self, from: result)
    }
}
