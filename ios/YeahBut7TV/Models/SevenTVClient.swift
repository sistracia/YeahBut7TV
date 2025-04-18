import Foundation

enum SevenTVClientError: Error {
    case networkError(String)
}

struct SevenTVAPISearchEmotesQuery {
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
        let rawEmotes = try? values.decode(Emotes.self, forKey: .emotes)
        
        guard let emotes = rawEmotes
        else {
            throw SevenTVClientError.networkError("Missing emote data")
        }
        
        self.emotes = emotes
    }
}

struct Emotes {
    let count: Int
    let items: [EmoteItem]
}

extension Emotes: Decodable {
    private enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawCount = try? values.decode(Int.self, forKey: .count)
        let rawItems = try? values.decode([EmoteItem].self, forKey: .items)
        
        guard let count = rawCount,
              let items = rawItems
        else {
            throw SevenTVClientError.networkError("Missing emotes data")
        }
        
        self.count = count
        self.items = items
    }
}

struct EmoteItem {
    let id: String
    let name: String
    let host: EmoteItemHost
}

extension EmoteItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case host
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? container.decode(String.self, forKey: .id)
        let rawName = try? container.decode(String.self, forKey: .name)
        let rawHost = try? container.decode(EmoteItemHost.self, forKey: .host)
        
        guard let id = rawId,
              let name = rawName,
              let host = rawHost
        else {
            throw SevenTVClientError.networkError("Missing emote item data")
        }
        
        self.id = id
        self.name = name
        self.host = host
    }
}

struct EmoteItemHost {
    let url: String
    let files: [EmoteFile]
}

extension EmoteItemHost: Decodable {
    private enum CodingKeys: String, CodingKey {
        case url
        case files
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawUrl = try? container.decode(String.self, forKey: .url)
        let rawFiles = try? container.decode([EmoteFile].self, forKey: .files)
        
        guard let url = rawUrl,
              let files = rawFiles
        else {
            throw SevenTVClientError.networkError("Missing emote item host data")
        }
        
        self.url = url
        self.files = files
    }
}

struct EmoteFile {
    let name: String
    let width: Int
    let height: Int
    let format: String
}

extension EmoteFile: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case width
        case height
        case format
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawName = try? container.decode(String.self, forKey: .name)
        let rawWidth = try? container.decode(Int.self, forKey: .width)
        let rawHeight = try? container.decode(Int.self, forKey: .height)
        let rawFormat = try? container.decode(String.self, forKey: .format)
        
        guard let name = rawName,
              let width = rawWidth,
              let height = rawHeight,
              let format = rawFormat
        else {
            throw SevenTVClientError.networkError("Missing emote file data")
        }
        
        self.name = name
        self.width = width
        self.height = height
        self.format = format
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
    
    init(url: URL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }
    
    func httpRequest(path: String, queryItems: [URLQueryItem]? = nil)
    async throws -> Data
    {
        guard let url = URL(string: path, relativeTo: self.url) else {
            throw SevenTVClientError.networkError("Invalid request URL")
        }
        
        guard var urlCompoents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else {
            throw SevenTVClientError.networkError("Invalid URL component")
        }
        
        urlCompoents.queryItems = queryItems
        
        guard let urlWithQueryItems = urlCompoents.url else {
            throw SevenTVClientError.networkError("Invalid URL query")
        }
        
        var request = URLRequest(url: urlWithQueryItems)
        request.httpMethod = "GET"
        
        guard let (data, response) = try await self.session.data(for: request) as? (Data, HTTPURLResponse),
              validStatuses.contains(response.statusCode)
        else {
            throw SevenTVClientError.networkError("Invalid status code")
        }
        
        return data
    }
    
    func searchEmotes(query: SevenTVAPISearchEmotesQuery) async throws -> Emote
    {
        let result = try await self.httpRequest(
            path: "/search-emotes",
            queryItems: [
                .init(name: "query", value: query.query),
                .init(name: "page", value: String(query.page)),
                .init(name: "limit", value: String(query.limit)),
                .init(
                    name: "case_sensitive",
                    value: String(query.caseSensitive)
                ),
                .init(name: "exact_match", value: String(query.exactMatch)),
            ]
        )
        
        return try self.jsonDecoder.decode(Emote.self, from: result)
    }
}

